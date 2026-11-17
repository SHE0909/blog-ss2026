<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Category;
use App\Models\Post;
use App\Models\PostImage;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

class PostController extends Controller
{
    public function index(Request $request)
    {
        $posts = Post::with(['category', 'authors'])
            ->when($request->status, fn ($q, $s) => $q->where('status', $s))
            ->orderByDesc('activity_date')->orderByDesc('id')->paginate(15)->withQueryString();

        return view('admin.posts.index', compact('posts'));
    }

    public function create()
    {
        return view('admin.posts.form', $this->formData());
    }

    public function store(Request $request)
    {
        $data = $this->validated($request);
        $data['user_id'] = $request->user()->id;
        $data['slug'] = Str::slug($data['title']) . '-' . Str::lower(Str::random(5));

        if ($request->hasFile('main_image')) {
            $data['main_image'] = $request->file('main_image')->store('posts', 'public');
        }

        $post = Post::create($data);
        $post->authors()->sync($request->input('authors', []));
        $this->saveImages($request, $post);
        $this->saveAttendance($request, $post);

        return redirect()->route('admin.posts.index')->with('ok', 'Entrada creada correctamente.');
    }

    public function edit(Post $post)
    {
        $post->load(['authors', 'images.user', 'attendances']);

        return view('admin.posts.form', $this->formData() + ['post' => $post]);
    }

    public function update(Request $request, Post $post)
    {
        $data = $this->validated($request);

        if ($request->hasFile('main_image')) {
            if ($post->main_image) {
                Storage::disk('public')->delete($post->main_image);
            }
            $data['main_image'] = $request->file('main_image')->store('posts', 'public');
        }

        $post->update($data);
        $post->authors()->sync($request->input('authors', []));
        $this->saveImages($request, $post);
        $this->saveAttendance($request, $post);

        return redirect()->route('admin.posts.index')->with('ok', 'Entrada actualizada correctamente.');
    }

    public function destroy(Post $post)
    {
        foreach ($post->images as $img) {
            Storage::disk('public')->delete($img->path);
        }
        if ($post->main_image) {
            Storage::disk('public')->delete($post->main_image);
        }
        $post->delete();

        return back()->with('ok', 'Entrada eliminada.');
    }

    public function destroyImage(PostImage $image)
    {
        Storage::disk('public')->delete($image->path);
        $image->delete();

        return back()->with('ok', 'Imagen eliminada.');
    }

    private function formData(): array
    {
        return [
            'categories' => Category::orderBy('name')->get(),
            'users' => User::orderBy('name')->get(),
        ];
    }

    private function saveAttendance(Request $request, Post $post): void
    {
        foreach ($request->input('attendance', []) as $userId => $status) {
            if (!User::whereKey($userId)->exists()) {
                continue;
            }
            $post->attendances()->updateOrCreate(['user_id' => $userId], ['status' => $status]);
        }
    }

    private function saveImages(Request $request, Post $post): void
    {
        foreach ($request->file('images', []) as $file) {
            $post->images()->create([
                'path' => $file->store('posts/galeria', 'public'),
                'user_id' => $request->input('evidence_user_id') ?: null,
                'caption' => $request->input('caption'),
                'type' => $request->input('evidence_type', 'galeria'),
            ]);
        }
    }

    private function validated(Request $request): array
    {
        return $request->validate([
            'title' => ['required', 'string', 'max:200'],
            'activity_date' => ['required', 'date'],
            'category_id' => ['required', 'exists:categories,id'],
            'content' => ['required', 'string'],
            'reflection' => ['nullable', 'string'],
            'status' => ['required', 'in:borrador,publicado'],
            'authors' => ['required', 'array', 'min:1'],
            'authors.*' => ['exists:users,id'],
            'main_image' => ['nullable', 'image', 'max:5120'],
            'images.*' => ['image', 'max:5120'],
            'evidence_user_id' => ['nullable', 'exists:users,id'],
            'caption' => ['nullable', 'string', 'max:255'],
            'evidence_type' => ['nullable', 'in:galeria,evidencia'],
            'attendance' => ['nullable', 'array'],
            'attendance.*' => ['in:pendiente,presente,ausente,justificada'],
        ], [
            'title.required' => 'El título es obligatorio.',
            'activity_date.required' => 'La fecha de la actividad es obligatoria.',
            'category_id.required' => 'Selecciona una categoría.',
            'content.required' => 'El contenido es obligatorio.',
            'authors.required' => 'Selecciona al menos un autor.',
            'main_image.image' => 'La imagen principal debe ser una imagen válida.',
            'main_image.max' => 'La imagen principal no puede superar 5 MB.',
            'images.*.image' => 'Todos los archivos de evidencia deben ser imágenes.',
            'images.*.max' => 'Cada imagen no puede superar 5 MB.',
        ]);
    }
}
