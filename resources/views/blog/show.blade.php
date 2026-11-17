@extends('layouts.app')
@section('title', $post->title . ' · Semana de Sistemas 2026')
@section('content')
<article class="section pb-0">
    <div class="container">
        <div class="article">
            <a class="back" href="{{ route('blog.index') }}"><i class="bi bi-arrow-left"></i> Volver a las entradas</a>
            <h1>{{ $post->title }}</h1>
            <div class="byline">
                <span class="tag">{{ $post->category->name }}</span>
                <span><i class="bi bi-calendar-event"></i>{{ $post->activity_date->format('d/m/Y') }}</span>
                <span class="avatars">
                    @foreach ($post->authors as $a)<span class="avatar" title="{{ $a->name }}">{{ mb_strtoupper(mb_substr($a->name, 0, 1)) }}</span>@endforeach
                    <span>{{ $post->authors->pluck('name')->join(' y ') }}</span>
                </span>
            </div>

            @if ($post->image_url)
                <figure class="article-hero"><img src="{{ $post->image_url }}" alt="{{ $post->title }}"></figure>
            @endif

            <div class="prose">{{ $post->content }}</div>

            @if ($post->reflection)
                <aside class="reflection">
                    <h2><i class="bi bi-chat-quote"></i> Nuestra reflexión</h2>
                    <div class="prose">{{ $post->reflection }}</div>
                </aside>
            @endif

            @php $gallery = $post->images->where('type', 'galeria'); @endphp
            @if ($gallery->count())
                <h2 class="h4 mt-5 mb-0">Galería</h2>
                <div class="gallery">
                    @foreach ($gallery as $img)
                        <a class="gallery-item" href="{{ $img->url }}" data-lightbox data-caption="{{ $img->caption }}">
                            <img src="{{ $img->url }}" alt="{{ $img->caption ?: 'Foto de la actividad' }}" loading="lazy">
                            @if ($img->caption)<span>{{ $img->caption }}</span>@endif
                        </a>
                    @endforeach
                </div>
            @endif
        </div>
    </div>
</article>
@endsection
