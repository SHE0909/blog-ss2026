@extends('layouts.admin')
@php $p = $post ?? null; @endphp
@section('title', $p ? 'Editar entrada' : 'Nueva entrada')
@section('content')
<div class="page-head">
    <div><h1>{{ $p ? 'Editar entrada' : 'Nueva entrada' }}</h1><p>Describe hechos reales, escribe tu reflexión y sube las evidencias.</p></div>
    @if ($p && $p->status === 'publicado')
        <div class="page-actions"><a class="btn-ghost-dark" href="{{ route('blog.show', $p) }}" target="_blank"><i class="bi bi-eye"></i> Ver en el sitio</a></div>
    @endif
</div>

@if ($errors->any())
    <div class="alert-sds" role="alert"><strong>Revisa estos campos antes de guardar:</strong>
        <ul>@foreach ($errors->all() as $e)<li>{{ $e }}</li>@endforeach</ul>
    </div>
@endif

<form method="POST" enctype="multipart/form-data" action="{{ $p ? route('admin.posts.update', $p) : route('admin.posts.store') }}">
    @csrf @if ($p) @method('PUT') @endif
    <div class="row g-4">
        <div class="col-xl-8">
            <section class="form-section">
                <h2 class="sec-title"><i class="bi bi-card-heading"></i> Datos de la actividad</h2>
                <div class="row g-3">
                    <div class="col-md-8">
                        <label class="form-label" for="title">Título</label>
                        <input id="title" name="title" class="form-control" value="{{ old('title', $p->title ?? '') }}" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label" for="activity_date">Fecha de la actividad</label>
                        <input id="activity_date" type="date" name="activity_date" class="form-control" value="{{ old('activity_date', $p ? $p->activity_date->format('Y-m-d') : now()->format('Y-m-d')) }}" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label" for="category_id">Categoría</label>
                        <select id="category_id" name="category_id" class="form-select" required>
                            <option value="">Selecciona una categoría</option>
                            @foreach ($categories as $c)
                                <option value="{{ $c->id }}" @selected(old('category_id', $p->category_id ?? '') == $c->id)>{{ $c->name }}</option>
                            @endforeach
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label" for="status">Estado</label>
                        <select id="status" name="status" class="form-select">
                            @foreach (['borrador' => 'Borrador (no es público)', 'publicado' => 'Publicado (visible en el blog)'] as $val => $lab)
                                <option value="{{ $val }}" @selected(old('status', $p->status ?? 'borrador') === $val)>{{ $lab }}</option>
                            @endforeach
                        </select>
                    </div>
                </div>
            </section>

            <section class="form-section">
                <h2 class="sec-title"><i class="bi bi-pencil-square"></i> Contenido</h2>
                <div class="mb-3">
                    <label class="form-label" for="content">Lo que pasó en la actividad</label>
                    <textarea id="content" name="content" rows="10" class="form-control" required>{{ old('content', $p->content ?? '') }}</textarea>
                </div>
                <div>
                    <label class="form-label" for="reflection">Reflexión propia</label>
                    <textarea id="reflection" name="reflection" rows="5" class="form-control">{{ old('reflection', $p->reflection ?? '') }}</textarea>
                </div>
            </section>

            <section class="form-section">
                <h2 class="sec-title"><i class="bi bi-person-check"></i> Asistencia individual</h2>
                <div class="row g-3">
                    @foreach ($users as $u)
                        @php $cur = old('attendance.' . $u->id, $p ? optional($p->attendances->firstWhere('user_id', $u->id))->status : 'pendiente') ?? 'pendiente'; @endphp
                        <div class="col-md-6">
                            <div class="person"><span class="avatar">{{ mb_strtoupper(mb_substr($u->name, 0, 1)) }}</span> {{ $u->name }}</div>
                            <select name="attendance[{{ $u->id }}]" class="form-select" aria-label="Asistencia de {{ $u->name }}">
                                @foreach (['pendiente' => 'Pendiente', 'presente' => 'Presente', 'ausente' => 'Ausente', 'justificada' => 'Ausencia justificada'] as $val => $lab)
                                    <option value="{{ $val }}" @selected($cur === $val)>{{ $lab }}</option>
                                @endforeach
                            </select>
                        </div>
                    @endforeach
                </div>
                <p class="hint">Marca solo lo que realmente ocurrió. Las ausencias justificadas deben comunicarse al docente.</p>
            </section>

            <section class="form-section">
                <h2 class="sec-title"><i class="bi bi-images"></i> Imágenes y evidencias</h2>
                <p class="hint mt-0 mb-3">«Galería» se muestra en el blog público. «Evidencia de asistencia» (foto propia, constancia, registro) queda solo en el panel y en Participación.</p>
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label" for="images">Imágenes (puedes elegir varias)</label>
                        <input id="images" type="file" name="images[]" accept="image/*" multiple class="form-control" data-preview="#prev-gallery">
                    </div>
                    <div class="col-md-3">
                        <label class="form-label" for="evidence_type">Tipo</label>
                        <select id="evidence_type" name="evidence_type" class="form-select">
                            <option value="galeria">Galería (pública)</option>
                            <option value="evidencia">Evidencia de asistencia (privada)</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label" for="evidence_user_id">Corresponde a</label>
                        <select id="evidence_user_id" name="evidence_user_id" class="form-select">
                            <option value="">General / ambos</option>
                            @foreach ($users as $u)<option value="{{ $u->id }}">{{ $u->name }}</option>@endforeach
                        </select>
                    </div>
                    <div class="col-12">
                        <label class="form-label" for="caption">Descripción de la imagen (opcional)</label>
                        <input id="caption" name="caption" class="form-control" placeholder="Ej.: En la ponencia del Auditorio 1">
                    </div>
                </div>
                <div class="previews" id="prev-gallery"></div>

                @if ($p && $p->images->count())
                    <div class="thumbs">
                        @foreach ($p->images as $img)
                            <div class="thumb">
                                <img src="{{ $img->url }}" alt="{{ $img->caption ?: 'Imagen de la entrada' }}">
                                <div class="thumb-body">
                                    <span class="pill {{ $img->type === 'evidencia' ? 'pill-borrador' : 'pill-publicado' }}">{{ $img->type === 'evidencia' ? 'Evidencia' : 'Galería' }}</span>
                                    @if ($img->caption)<span>{{ $img->caption }}</span>@endif
                                    @if ($img->user)<span class="t-sub">{{ $img->user->name }}</span>@endif
                                    <button type="submit" form="del{{ $img->id }}" class="btn-danger-soft btn-sm-sds" onclick="return confirm('¿Eliminar esta imagen?')"><i class="bi bi-trash"></i> Quitar</button>
                                </div>
                            </div>
                        @endforeach
                    </div>
                @endif
            </section>
        </div>

        <div class="col-xl-4">
            <section class="form-section">
                <h2 class="sec-title"><i class="bi bi-people"></i> Autores</h2>
                @php $sel = old('authors', $p ? $p->authors->pluck('id')->all() : [auth()->id()]); @endphp
                <div class="d-flex flex-wrap gap-2">
                    @foreach ($users as $u)
                        <input class="btn-check" type="checkbox" name="authors[]" value="{{ $u->id }}" id="a{{ $u->id }}" autocomplete="off" @checked(in_array($u->id, $sel))>
                        <label class="chip-check" for="a{{ $u->id }}"><span class="avatar">{{ mb_strtoupper(mb_substr($u->name, 0, 1)) }}</span>{{ $u->name }}</label>
                    @endforeach
                </div>
            </section>

            <section class="form-section">
                <h2 class="sec-title"><i class="bi bi-image"></i> Imagen principal</h2>
                <input type="file" name="main_image" accept="image/*" class="form-control" data-preview="#prev-main" aria-label="Imagen principal">
                <p class="hint">Se muestra al inicio de la entrada y en su tarjeta. Máximo 5 MB.</p>
                <div class="previews" id="prev-main"></div>
                @if ($p && $p->image_url)
                    <img src="{{ $p->image_url }}" alt="Imagen principal actual" class="img-fluid rounded-3 mt-3">
                @endif
            </section>
        </div>
    </div>

    <div class="savebar">
        <a class="btn-ghost-dark" href="{{ route('admin.posts.index') }}">Cancelar</a>
        <button class="btn-sds"><i class="bi bi-check2"></i> Guardar entrada</button>
    </div>
</form>

@if ($p)
    @foreach ($p->images as $img)
        <form id="del{{ $img->id }}" method="POST" action="{{ route('admin.images.destroy', $img) }}">@csrf @method('DELETE')</form>
    @endforeach
@endif
@endsection
