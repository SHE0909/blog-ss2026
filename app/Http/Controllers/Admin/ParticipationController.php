<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Post;
use App\Models\User;

class ParticipationController extends Controller
{
    public function index()
    {
        return view('admin.participation', [
            'users' => User::orderBy('name')->get(),
            'posts' => Post::with(['category', 'attendances', 'images'])
                ->orderBy('activity_date')->orderBy('id')->get(),
        ]);
    }
}
