@extends('layouts.admin')
@section('title', 'Entradas')
@section('content')
<div class="d-flex justify-content-between align-items-center mb-3">
    <h3>Entradas</h3>
    <a href="{{ route('admin.posts.create') }}" class="btn btn-primary">+ Nueva entrada</a>
</div>
<div class="mb-3 btn-group btn-group-sm">
    <a class="btn btn-outline-secondary" href="{{ route('admin.posts.index') }}">Todas</a>
    <a class="btn btn-outline-secondary" href="{{ route('admin.posts.index', ['status' => 'publicado']) }}">Publicadas</a>
    <a class="btn btn-outline-secondary" href="{{ route('admin.posts.index', ['status' => 'borrador']) }}">Borradores</a>
</div>
<div class="table-responsive">
<table class="table table-striped align-middle bg-white">
    <thead><tr><th>Título</th><th>Categoría</th><th>Fecha</th><th>Autores</th><th>Estado</th><th></th></tr></thead>
    <tbody>
    @forelse ($posts as $p)
        <tr>
            <td>{{ $p->title }}</td>
            <td>{{ $p->category->name }}</td>
            <td>{{ $p->activity_date->format('d/m/Y') }}</td>
            <td>{{ $p->authors->pluck('name')->join(', ') }}</td>
            <td><span class="badge text-bg-{{ $p->status === 'publicado' ? 'success' : 'warning' }}">{{ $p->status }}</span></td>
            <td class="text-nowrap">
                @if ($p->status === 'publicado')<a href="{{ route('blog.show', $p) }}" target="_blank" class="btn btn-sm btn-outline-secondary">Ver</a>@endif
                <a href="{{ route('admin.posts.edit', $p) }}" class="btn btn-sm btn-outline-primary">Editar</a>
                <form method="POST" action="{{ route('admin.posts.destroy', $p) }}" class="d-inline" onsubmit="return confirm('¿Eliminar esta entrada?')">
                    @csrf @method('DELETE')<button class="btn btn-sm btn-outline-danger">Eliminar</button>
                </form>
            </td>
        </tr>
    @empty
        <tr><td colspan="6" class="text-center text-muted">Sin entradas.</td></tr>
    @endforelse
    </tbody>
</table>
</div>
{{ $posts->links('pagination::bootstrap-5') }}
@endsection
