@extends('layouts.admin')
@section('title', 'Control de participación')
@section('content')
<h3>Control de participación</h3>
<p class="text-muted">Asistencia y evidencias de cada integrante, actividad por actividad.</p>
@php $badge = ['presente' => 'success', 'ausente' => 'danger', 'justificada' => 'info', 'pendiente' => 'secondary']; @endphp
<div class="table-responsive">
<table class="table bg-white align-middle">
    <thead>
        <tr>
            <th>Actividad</th><th>Fecha</th>
            @foreach ($users as $u)<th class="text-center">{{ $u->name }}</th>@endforeach
        </tr>
    </thead>
    <tbody>
    @foreach ($posts as $p)
        <tr>
            <td><a href="{{ route('admin.posts.edit', $p) }}">{{ $p->title }}</a><div class="small text-muted">{{ $p->category->name }}</div></td>
            <td>{{ $p->activity_date->format('d/m/Y') }}</td>
            @foreach ($users as $u)
                @php
                    $st = optional($p->attendances->firstWhere('user_id', $u->id))->status ?? 'pendiente';
                    $ev = $p->images->where('type', 'evidencia')->where('user_id', $u->id)->count();
                @endphp
                <td class="text-center">
                    <span class="badge text-bg-{{ $badge[$st] }}">{{ ucfirst($st) }}</span>
                    <div class="small text-muted">{{ $ev }} evidencia(s)</div>
                </td>
            @endforeach
        </tr>
    @endforeach
    </tbody>
    <tfoot>
        <tr class="table-light fw-bold">
            <td colspan="2">Actividades con asistencia «presente»</td>
            @foreach ($users as $u)
                @php $n = $posts->filter(fn ($p) => optional($p->attendances->firstWhere('user_id', $u->id))->status === 'presente')->count(); @endphp
                <td class="text-center">{{ $n }} de {{ $posts->count() }}</td>
            @endforeach
        </tr>
    </tfoot>
</table>
</div>
@endsection
