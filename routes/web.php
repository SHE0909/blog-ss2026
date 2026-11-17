<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\BlogController;
use App\Http\Controllers\Admin\CategoryController;
use App\Http\Controllers\Admin\DashboardController;
use App\Http\Controllers\Admin\ParticipationController;
use App\Http\Controllers\Admin\PostController;
use Illuminate\Support\Facades\Route;

// Área pública
Route::get('/', [BlogController::class, 'home'])->name('home');
Route::get('/entradas', [BlogController::class, 'index'])->name('blog.index');
Route::get('/entradas/{post:slug}', [BlogController::class, 'show'])->name('blog.show');

// Autenticación
Route::get('/login', [AuthController::class, 'showLogin'])->name('login')->middleware('guest');
Route::post('/login', [AuthController::class, 'login'])->middleware('guest');
Route::post('/logout', [AuthController::class, 'logout'])->name('logout')->middleware('auth');

// Área administrativa (protegida)
Route::prefix('admin')->name('admin.')->middleware('auth')->group(function () {
    Route::get('/', [DashboardController::class, 'index'])->name('dashboard');
    Route::resource('posts', PostController::class)->except('show');
    Route::delete('images/{image}', [PostController::class, 'destroyImage'])->name('images.destroy');
    Route::get('participacion', [ParticipationController::class, 'index'])->name('participation');
    Route::resource('categories', CategoryController::class)->except('show');
});
