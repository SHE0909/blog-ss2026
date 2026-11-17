@extends('layouts.admin')
@php $c = $category ?? null; @endphp
@section('title', $c ? 'Editar categoría' : 'Nueva categoría')
@section('content')
<div class="page-head"><div><h1>{{ $c ? 'Editar categoría' : 'Nueva categoría' }}</h1></div></div>
<form method="POST" action="{{ $c ? route('admin.categories.update', $c) : route('admin.categories.store') }}" style="max-width:620px">
    @csrf @if ($c) @method('PUT') @endif
    <section class="form-section">
        <div class="mb-3">
            <label class="form-label" for="name">Nombre</label>
            <input id="name" name="name" value="{{ old('name', $c->name ?? '') }}" class="form-control @error('name') is-invalid @enderror" required>
            @error('name')<div class="invalid-feedback">{{ $message }}</div>@enderror
        </div>
        <div>
            <label class="form-label" for="description">Descripción</label>
            <textarea id="description" name="description" rows="3" class="form-control">{{ old('description', $c->description ?? '') }}</textarea>
        </div>
    </section>
    <div class="d-flex gap-2">
        <button class="btn-sds"><i class="bi bi-check2"></i> Guardar categoría</button>
        <a class="btn-ghost-dark" href="{{ route('admin.categories.index') }}">Cancelar</a>
    </div>
</form>
@endsection
