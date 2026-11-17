@extends('layouts.app')
@section('title', 'Entradas · Semana de Sistemas 2026')
@section('content')
<section class="section pb-0">
    <div class="container">
        <h1 class="page-title">Entradas</h1>
        <p class="text-muted mb-3">{{ $posts->total() }} {{ $posts->total() === 1 ? 'entrada publicada' : 'entradas publicadas' }}</p>

        <form method="GET" action="{{ route('blog.index') }}" class="search">
            <i class="bi bi-search"></i>
            @if ($cat)<input type="hidden" name="categoria" value="{{ $cat }}">@endif
            <input type="search" name="q" value="{{ $q }}" class="form-control" placeholder="Buscar por título o contenido" aria-label="Buscar entradas">
        </form>

        <div class="chips">
            <a class="chip {{ $cat ? '' : 'is-active' }}" href="{{ route('blog.index', array_filter(['q' => $q])) }}">Todas</a>
            @foreach ($categories as $c)
                <a class="chip {{ $cat === $c->slug ? 'is-active' : '' }}" href="{{ route('blog.index', array_filter(['q' => $q, 'categoria' => $c->slug])) }}">{{ $c->name }}</a>
            @endforeach
        </div>

        <div class="row g-4">
            @forelse ($posts as $post)
                @include('blog._card')
            @empty
                <div class="col-12"><div class="empty"><i class="bi bi-search"></i>No encontramos entradas con esa búsqueda. Prueba con otra palabra o quita el filtro de categoría.</div></div>
            @endforelse
        </div>
        <div class="mt-4 d-flex justify-content-center">{{ $posts->links('pagination::bootstrap-5') }}</div>
    </div>
</section>
@endsection
