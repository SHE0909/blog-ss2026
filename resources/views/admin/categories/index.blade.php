@extends('layouts.admin')
@section('title', 'Categorías')
@section('content')
<div class="d-flex justify-content-between align-items-center mb-3">
    <h3>Categorías</h3>
    <a href="{{ route('admin.categories.create') }}" class="btn btn-primary">+ Nueva categoría</a>
</div>
<table class="table table-striped bg-white align-middle">
    <thead><tr><th>Nombre</th><th>Descripción</th><th>Entradas</th><th></th></tr></thead>
    <tbody>
    @foreach ($categories as $c)
        <tr>
            <td>{{ $c->name }}</td><td>{{ $c->description }}</td><td>{{ $c->posts_count }}</td>
            <td class="text-nowrap">
                <a href="{{ route('admin.categories.edit', $c) }}" class="btn btn-sm btn-outline-primary">Editar</a>
                <form method="POST" action="{{ route('admin.categories.destroy', $c) }}" class="d-inline" onsubmit="return confirm('¿Eliminar categoría?')">
                    @csrf @method('DELETE')<button class="btn btn-sm btn-outline-danger">Eliminar</button>
                </form>
            </td>
        </tr>
    @endforeach
    </tbody>
</table>
@endsection
