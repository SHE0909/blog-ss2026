<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Category;
use App\Models\Post;

class DashboardController extends Controller
{
    public function index()
    {
        return view('admin.dashboard', [
            'total' => Post::count(),
            'published' => Post::published()->count(),
            'drafts' => Post::where('status', 'borrador')->count(),
            'categories' => Category::withCount('posts')->orderBy('name')->get(),
            'latest' => Post::with('category')->latest('updated_at')->take(6)->get(),
        ]);
    }
}
