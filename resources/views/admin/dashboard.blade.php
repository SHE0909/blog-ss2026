@extends('layouts.admin')
@section('title', 'Panel')
@section('content')
<div class="d-flex justify-content-between align-items-center mb-3"><h3 class="mb-0">Panel de control</h3><a href="{{ route('admin.participation') }}" class="btn btn-outline-primary">Control de participación</a></div>
<div class="row g-3 mb-4">
    <div class="col-md-4"><div class="card text-center"><div class="card-body"><div class="display-6">{{ $total }}</div>Total de entradas</div></div></div>
    <div class="col-md-4"><div class="card text-center border-success"><div class="card-body"><div class="display-6 text-success">{{ $published }}</div>Publicadas</div></div></div>
    <div class="col-md-4"><div class="card text-center border-warning"><div class="card-body"><div class="display-6 text-warning">{{ $drafts }}</div>Borradores</div></div></div>
</div>
<div class="row g-4">
    <div class="col-md-6">
        <div class="card"><div class="card-header">Entradas por categoría</div>
            <ul class="list-group list-group-flush">
                @foreach ($categories as $c)
                    <li class="list-group-item d-flex justify-content-between">{{ $c->name }}<span class="badge text-bg-secondary">{{ $c->posts_count }}</span></li>
                @endforeach
            </ul>
        </div>
    </div>
    <div class="col-md-6">
        <div class="card"><div class="card-header d-flex justify-content-between">Últimas modificadas <a href="{{ route('admin.posts.create') }}" class="btn btn-sm btn-primary">+ Nueva</a></div>
            <ul class="list-group list-group-flush">
                @forelse ($latest as $p)
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        <a href="{{ route('admin.posts.edit', $p) }}">{{ $p->title }}</a>
                        <span class="badge text-bg-{{ $p->status === 'publicado' ? 'success' : 'warning' }}">{{ $p->status }}</span>
                    </li>
                @empty
                    <li class="list-group-item text-muted">Sin entradas.</li>
                @endforelse
            </ul>
        </div>
    </div>
</div>
@endsection
