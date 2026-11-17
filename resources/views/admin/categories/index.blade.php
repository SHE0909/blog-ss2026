@extends('layouts.admin')
@section('title', 'Categorías')
@section('content')
<div class="page-head">
    <div><h1>Categorías</h1><p>Agrupan las entradas por tipo de actividad.</p></div>
    <div class="page-actions"><a class="btn-sds" href="{{ route('admin.categories.create') }}"><i class="bi bi-plus-lg"></i> Nueva categoría</a></div>
</div>
<div class="panel">
    <div class="table-responsive">
        <table class="table table-sds">
            <thead><tr><th>Nombre</th><th>Descripción</th><th class="text-center">Entradas</th><th class="text-end">Acciones</th></tr></thead>
            <tbody>
            @foreach ($categories as $c)
                <tr>
                    <td class="t-title">{{ $c->name }}</td>
                    <td class="t-sub">{{ $c->description }}</td>
                    <td class="text-center"><span class="count">{{ $c->posts_count }}</span></td>
                    <td>
                        <div class="row-actions">
                            <a class="btn-ghost-dark btn-icon" href="{{ route('admin.categories.edit', $c) }}" title="Editar" aria-label="Editar"><i class="bi bi-pencil"></i></a>
                            <form method="POST" action="{{ route('admin.categories.destroy', $c) }}" onsubmit="return confirm('¿Eliminar esta categoría?')">
                                @csrf @method('DELETE')
                                <button class="btn-danger-soft btn-icon" title="Eliminar" aria-label="Eliminar"><i class="bi bi-trash"></i></button>
                            </form>
                        </div>
                    </td>
                </tr>
            @endforeach
            </tbody>
        </table>
    </div>
</div>
@endsection
