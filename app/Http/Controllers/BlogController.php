<?php

namespace App\Http\Controllers;

use App\Models\Category;
use App\Models\Post;
use Illuminate\Http\Request;

class BlogController extends Controller
{
    public function home()
    {
        $latest = Post::published()->with(['category', 'authors'])
            ->orderByDesc('activity_date')->orderByDesc('id')->take(3)->get();

        return view('blog.home', compact('latest'));
    }

    public function index(Request $request)
    {
        $q = trim((string) $request->query('q'));
        $cat = $request->query('categoria');

        $posts = Post::published()->with(['category', 'authors'])
            ->when($q, fn ($query) => $query->where(function ($w) use ($q) {
                $w->where('title', 'ilike', "%{$q}%")
                  ->orWhere('content', 'ilike', "%{$q}%");
            }))
            ->when($cat, fn ($query) => $query->whereHas('category', fn ($c) => $c->where('slug', $cat)))
            ->orderByDesc('activity_date')->orderByDesc('id')
            ->paginate(9)->withQueryString();

        $categories = Category::orderBy('name')->get();

        return view('blog.index', compact('posts', 'categories', 'q', 'cat'));
    }

    public function show(Post $post)
    {
        abort_unless($post->status === 'publicado', 404); // los borradores no son públicos
        $post->load(['category', 'authors', 'images']);

        return view('blog.show', compact('post'));
    }
}
