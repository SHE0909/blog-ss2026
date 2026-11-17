<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('posts', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->cascadeOnDelete();       // quien la registró
            $table->foreignId('category_id')->constrained()->restrictOnDelete();
            $table->string('title');
            $table->string('slug')->unique();
            $table->date('activity_date');
            $table->text('content');
            $table->text('reflection')->nullable();
            $table->string('main_image')->nullable();
            $table->enum('status', ['borrador', 'publicado'])->default('borrador');
            $table->timestamps();
        });

        // Autores (ambos integrantes de la pareja)
        Schema::create('post_user', function (Blueprint $table) {
            $table->foreignId('post_id')->constrained()->cascadeOnDelete();
            $table->foreignId('user_id')->constrained()->cascadeOnDelete();
            $table->primary(['post_id', 'user_id']);
        });

        // Imágenes y evidencias (cada una puede asignarse a un integrante)
        Schema::create('post_images', function (Blueprint $table) {
            $table->id();
            $table->foreignId('post_id')->constrained()->cascadeOnDelete();
            $table->foreignId('user_id')->nullable()->constrained()->nullOnDelete();
            $table->string('path');
            $table->string('caption')->nullable();
            $table->string('type')->default('galeria'); // galeria (publica) | evidencia (asistencia, privada)
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('post_images');
        Schema::dropIfExists('post_user');
        Schema::dropIfExists('posts');
    }
};
