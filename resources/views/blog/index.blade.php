@extends('layouts.app')
@section('title', 'Entradas')
@section('content')
<div class="container mt-4">
    <h2 class="mb-3">Entradas</h2>
    <form method="GET" class="row g-2 mb-3">
        <div class="col-md-5"><input type="search" name="q" value="{{ $q }}" class="form-control" placeholder="Buscar por título o contenido..."></div>
        <div class="col-md-4">
            <select name="categoria" class="form-select">
                <option value="">Todas las categorías</option>
                @foreach ($categories as $c)
                    <option value="{{ $c->slug }}" @selected($cat === $c->slug)>{{ $c->name }}</option>
                @endforeach
            </select>
        </div>
        <div class="col-md-3 d-flex gap-2">
            <button class="btn btn-primary flex-fill">Buscar</button>
            <a href="{{ route('blog.index') }}" class="btn btn-outline-secondary">Limpiar</a>
        </div>
    </form>
    <div class="row g-4">
        @forelse ($posts as $post)
            @include('blog._card')
        @empty
            <p class="text-muted">No se encontraron entradas.</p>
        @endforelse
    </div>
    <div class="mt-4">{{ $posts->links('pagination::bootstrap-5') }}</div>
</div>
@endsection
