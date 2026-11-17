@extends('layouts.admin')
@section('title', 'Entradas')
@section('content')
<div class="page-head">
    <div><h1>Entradas</h1><p>Crea, edita y publica las entradas de cada actividad.</p></div>
    <div class="page-actions"><a class="btn-sds" href="{{ route('admin.posts.create') }}"><i class="bi bi-plus-lg"></i> Nueva entrada</a></div>
</div>

<div class="chips mt-0">
    <a class="chip {{ request('status') ? '' : 'is-active' }}" href="{{ route('admin.posts.index') }}">Todas</a>
    <a class="chip {{ request('status') === 'publicado' ? 'is-active' : '' }}" href="{{ route('admin.posts.index', ['status' => 'publicado']) }}">Publicadas</a>
    <a class="chip {{ request('status') === 'borrador' ? 'is-active' : '' }}" href="{{ route('admin.posts.index', ['status' => 'borrador']) }}">Borradores</a>
</div>

<div class="panel">
    <div class="table-responsive">
        <table class="table table-sds">
            <thead><tr><th>Entrada</th><th>Fecha</th><th>Autores</th><th>Estado</th><th class="text-end">Acciones</th></tr></thead>
            <tbody>
            @forelse ($posts as $p)
                <tr>
                    <td style="min-width:260px"><a class="t-title" href="{{ route('admin.posts.edit', $p) }}">{{ $p->title }}</a><div class="t-sub">{{ $p->category->name }}</div></td>
                    <td class="text-nowrap">{{ $p->activity_date->format('d/m/Y') }}</td>
                    <td><span class="avatars">@foreach ($p->authors as $a)<span class="avatar" title="{{ $a->name }}">{{ mb_strtoupper(mb_substr($a->name, 0, 1)) }}</span>@endforeach</span></td>
                    <td><span class="pill pill-{{ $p->status }}">{{ ucfirst($p->status) }}</span></td>
                    <td>
                        <div class="row-actions">
                            @if ($p->status === 'publicado')<a class="btn-ghost-dark btn-icon" href="{{ route('blog.show', $p) }}" target="_blank" title="Ver en el sitio" aria-label="Ver en el sitio"><i class="bi bi-eye"></i></a>@endif
                            <a class="btn-ghost-dark btn-icon" href="{{ route('admin.posts.edit', $p) }}" title="Editar" aria-label="Editar"><i class="bi bi-pencil"></i></a>
                            <form method="POST" action="{{ route('admin.posts.destroy', $p) }}" onsubmit="return confirm('¿Eliminar esta entrada y sus imágenes?')">
                                @csrf @method('DELETE')
                                <button class="btn-danger-soft btn-icon" title="Eliminar" aria-label="Eliminar"><i class="bi bi-trash"></i></button>
                            </form>
                        </div>
                    </td>
                </tr>
            @empty
                <tr><td colspan="5" class="text-center text-muted py-5">No hay entradas con este filtro.</td></tr>
            @endforelse
            </tbody>
        </table>
    </div>
</div>
<div class="mt-3 d-flex justify-content-center">{{ $posts->links('pagination::bootstrap-5') }}</div>
@endsection
