@extends('layouts.admin')
@section('title', 'Panel')
@section('content')
@php
    $pct = $total ? round($published / $total * 100) : 0;
    $max = max(1, $categories->max('posts_count'));
@endphp
<div class="page-head">
    <div><h1>Panel de control</h1><p>Resumen de las publicaciones de la Semana de Sistemas 2026.</p></div>
    <div class="page-actions">
        <a class="btn-ghost-dark" href="{{ route('admin.participation') }}"><i class="bi bi-person-check"></i> Control de participación</a>
        <a class="btn-sds" href="{{ route('admin.posts.create') }}"><i class="bi bi-plus-lg"></i> Nueva entrada</a>
    </div>
</div>

<div class="stats">
    <div class="stat s-total"><span class="stat-ico"><i class="bi bi-journal-richtext"></i></span><div><b>{{ $total }}</b><span>Entradas en total</span></div></div>
    <div class="stat s-pub"><span class="stat-ico"><i class="bi bi-broadcast"></i></span><div><b>{{ $published }}</b><span>Publicadas</span></div></div>
    <div class="stat s-draft"><span class="stat-ico"><i class="bi bi-pencil-square"></i></span><div><b>{{ $drafts }}</b><span>Borradores</span></div></div>
</div>

<div class="panel panel-pad mb-4">
    <div class="d-flex justify-content-between mb-2"><strong>Avance de publicación</strong><span class="text-muted">{{ $published }} de {{ $total }} entradas ({{ $pct }}%)</span></div>
    <div class="meter"><i style="width:0" data-w="{{ $pct }}"></i></div>
</div>

<div class="row g-4">
    <div class="col-lg-6">
        <div class="panel h-100">
            <div class="panel-head"><h2>Entradas por categoría</h2></div>
            <ul class="row-list">
                @foreach ($categories as $c)
                    <li class="cat-row">
                        <span>{{ $c->name }}</span>
                        <span class="meter"><i style="width:0" data-w="{{ round($c->posts_count / $max * 100) }}"></i></span>
                        <span class="count">{{ $c->posts_count }}</span>
                    </li>
                @endforeach
            </ul>
        </div>
    </div>
    <div class="col-lg-6">
        <div class="panel h-100">
            <div class="panel-head"><h2>Últimas modificadas</h2><a class="btn-ghost-dark btn-sm-sds" href="{{ route('admin.posts.index') }}">Ver todas</a></div>
            <ul class="row-list">
                @forelse ($latest as $p)
                    <li>
                        <a class="t-title" href="{{ route('admin.posts.edit', $p) }}">{{ $p->title }}</a>
                        <span class="pill pill-{{ $p->status }}">{{ ucfirst($p->status) }}</span>
                    </li>
                @empty
                    <li class="text-muted">Aún no hay entradas. Crea la primera.</li>
                @endforelse
            </ul>
        </div>
    </div>
</div>
@endsection
