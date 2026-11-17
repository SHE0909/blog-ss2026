@extends('layouts.app')
@section('title', $post->title)
@section('content')
<div class="container mt-4" style="max-width:860px">
    <a href="{{ route('blog.index') }}" class="small">&larr; Volver a las entradas</a>
    <span class="badge text-bg-primary ms-2">{{ $post->category->name }}</span>
    <h1 class="mt-2">{{ $post->title }}</h1>
    <p class="text-secondary">
        Fecha de la actividad: {{ $post->activity_date->format('d/m/Y') }}
        · Por {{ $post->authors->pluck('name')->join(' y ') }}
    </p>
    @if ($post->image_url)
        <img src="{{ $post->image_url }}" class="img-fluid rounded mb-4 w-100" alt="{{ $post->title }}">
    @endif
    <div class="post-content">{{ $post->content }}</div>
    @if ($post->reflection)
        <div class="card border-primary mt-4"><div class="card-body">
            <h5 class="text-primary">Reflexión</h5>
            <div class="post-content">{{ $post->reflection }}</div>
        </div></div>
    @endif
    @php $gallery = $post->images->where('type', 'galeria'); @endphp
    @if ($gallery->count())
        <h4 class="mt-5">Galería y evidencias</h4>
        <div class="row g-3 gallery">
            @foreach ($gallery as $img)
                <div class="col-6 col-md-4">
                    <figure class="m-0">
                        <img src="{{ $img->url }}" class="rounded" alt="{{ $img->caption ?? 'Evidencia' }}">
                        <figcaption class="small text-muted">{{ $img->caption }} @if($img->user)<em>({{ $img->user->name }})</em>@endif</figcaption>
                    </figure>
                </div>
            @endforeach
        </div>
    @endif
</div>
@endsection
