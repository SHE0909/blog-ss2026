@extends('layouts.admin')
@php $p = $post ?? null; @endphp
@section('title', $p ? 'Editar entrada' : 'Nueva entrada')
@section('content')
<h3 class="mb-3">{{ $p ? 'Editar entrada' : 'Nueva entrada' }}</h3>

@if ($errors->any())
    <div class="alert alert-danger"><strong>Revisa el formulario:</strong>
        <ul class="mb-0">@foreach ($errors->all() as $e)<li>{{ $e }}</li>@endforeach</ul>
    </div>
@endif

<form method="POST" enctype="multipart/form-data"
      action="{{ $p ? route('admin.posts.update', $p) : route('admin.posts.store') }}">
    @csrf @if ($p) @method('PUT') @endif
    <div class="row g-3">
        <div class="col-md-8">
            <label class="form-label">Título</label>
            <input name="title" class="form-control" value="{{ old('title', $p->title ?? '') }}" required>
        </div>
        <div class="col-md-4">
            <label class="form-label">Fecha de la actividad</label>
            <input type="date" name="activity_date" class="form-control"
                   value="{{ old('activity_date', $p ? $p->activity_date->format('Y-m-d') : now()->format('Y-m-d')) }}" required>
        </div>
        <div class="col-md-6">
            <label class="form-label">Categoría</label>
            <select name="category_id" class="form-select" required>
                <option value="">-- Selecciona --</option>
                @foreach ($categories as $c)
                    <option value="{{ $c->id }}" @selected(old('category_id', $p->category_id ?? '') == $c->id)>{{ $c->name }}</option>
                @endforeach
            </select>
        </div>
        <div class="col-md-6">
            <label class="form-label">Estado</label>
            <select name="status" class="form-select">
                @foreach (['borrador', 'publicado'] as $s)
                    <option value="{{ $s }}" @selected(old('status', $p->status ?? 'borrador') === $s)>{{ ucfirst($s) }}</option>
                @endforeach
            </select>
        </div>
        <div class="col-12">
            <label class="form-label d-block">Autores</label>
            @php $sel = old('authors', $p ? $p->authors->pluck('id')->all() : [auth()->id()]); @endphp
            @foreach ($users as $u)
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="checkbox" name="authors[]" value="{{ $u->id }}" id="a{{ $u->id }}" @checked(in_array($u->id, $sel))>
                    <label class="form-check-label" for="a{{ $u->id }}">{{ $u->name }}</label>
                </div>
            @endforeach
        </div>
        <div class="col-12">
            <label class="form-label">Contenido (hechos reales de la actividad)</label>
            <textarea name="content" rows="10" class="form-control" required>{{ old('content', $p->content ?? '') }}</textarea>
        </div>
        <div class="col-12">
            <label class="form-label">Reflexión propia</label>
            <textarea name="reflection" rows="5" class="form-control">{{ old('reflection', $p->reflection ?? '') }}</textarea>
        </div>
        <div class="col-md-6">
            <label class="form-label">Imagen principal</label>
            <input type="file" name="main_image" accept="image/*" class="form-control">
            @if ($p && $p->image_url)<img src="{{ $p->image_url }}" class="img-thumbnail mt-2" style="max-height:120px">@endif
        </div>
    </div>

    <hr class="my-4">
    <h5>Asistencia individual</h5>
    <div class="row g-3 mb-3">
        @foreach ($users as $u)
            @php $cur = old('attendance.' . $u->id, $p ? optional($p->attendances->firstWhere('user_id', $u->id))->status : 'pendiente') ?? 'pendiente'; @endphp
            <div class="col-md-6">
                <label class="form-label">{{ $u->name }}</label>
                <select name="attendance[{{ $u->id }}]" class="form-select">
                    @foreach (['pendiente', 'presente', 'ausente', 'justificada'] as $s)
                        <option value="{{ $s }}" @selected($cur === $s)>{{ ucfirst($s) }}</option>
                    @endforeach
                </select>
            </div>
        @endforeach
    </div>

    <hr class="my-4">
    <h5>Imágenes y evidencias</h5>
    <p class="small text-muted">«Galería» se muestra en el blog público. «Evidencia de asistencia» (selfie, constancia, registro) queda solo en el panel y en Participación.</p>
    <div class="row g-3">
        <div class="col-md-6">
            <label class="form-label">Imágenes (puedes seleccionar varias)</label>
            <input type="file" name="images[]" accept="image/*" multiple class="form-control">
        </div>
        <div class="col-md-3">
            <label class="form-label">Tipo</label>
            <select name="evidence_type" class="form-select">
                <option value="galeria">Galería (pública)</option>
                <option value="evidencia">Evidencia de asistencia (privada)</option>
            </select>
        </div>
        <div class="col-md-3">
            <label class="form-label">Corresponde a</label>
            <select name="evidence_user_id" class="form-select">
                <option value="">General / ambos</option>
                @foreach ($users as $u)<option value="{{ $u->id }}">{{ $u->name }}</option>@endforeach
            </select>
        </div>
        <div class="col-md-4">
            <label class="form-label">Descripción (opcional)</label>
            <input name="caption" class="form-control" placeholder="Ej: Yo en la ponencia">
        </div>
    </div>

    @if ($p && $p->images->count())
        <div class="row g-2 mt-2">
            @foreach ($p->images as $img)
                <div class="col-6 col-md-3">
                    <div class="card">
                        <img src="{{ $img->url }}" class="card-img-top" style="height:120px;object-fit:cover">
                        <div class="card-body p-2 small">
                            <span class="badge text-bg-{{ $img->type === 'evidencia' ? 'warning' : 'primary' }}">{{ $img->type === 'evidencia' ? 'Evidencia' : 'Galería' }}</span> {{ $img->caption }} <em>{{ $img->user?->name }}</em>
                            <button type="submit" form="del{{ $img->id }}" class="btn btn-sm btn-outline-danger w-100 mt-1" onclick="return confirm('¿Eliminar imagen?')">Quitar</button>
                        </div>
                    </div>
                </div>
            @endforeach
        </div>
    @endif

    <div class="mt-4">
        <button class="btn btn-primary">Guardar</button>
        <a href="{{ route('admin.posts.index') }}" class="btn btn-outline-secondary">Cancelar</a>
    </div>
</form>

@if ($p)
    @foreach ($p->images as $img)
        <form id="del{{ $img->id }}" method="POST" action="{{ route('admin.images.destroy', $img) }}">@csrf @method('DELETE')</form>
    @endforeach
@endif
@endsection
