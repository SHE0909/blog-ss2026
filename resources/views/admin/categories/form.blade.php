@extends('layouts.admin')
@php $c = $category ?? null; @endphp
@section('title', $c ? 'Editar categoría' : 'Nueva categoría')
@section('content')
<h3 class="mb-3">{{ $c ? 'Editar categoría' : 'Nueva categoría' }}</h3>
<form method="POST" action="{{ $c ? route('admin.categories.update', $c) : route('admin.categories.store') }}" style="max-width:560px">
    @csrf @if ($c) @method('PUT') @endif
    <div class="mb-3">
        <label class="form-label">Nombre</label>
        <input name="name" value="{{ old('name', $c->name ?? '') }}" class="form-control @error('name') is-invalid @enderror" required>
        @error('name')<div class="invalid-feedback">{{ $message }}</div>@enderror
    </div>
    <div class="mb-3">
        <label class="form-label">Descripción</label>
        <textarea name="description" rows="3" class="form-control">{{ old('description', $c->description ?? '') }}</textarea>
    </div>
    <button class="btn btn-primary">Guardar</button>
    <a href="{{ route('admin.categories.index') }}" class="btn btn-outline-secondary">Cancelar</a>
</form>
@endsection
