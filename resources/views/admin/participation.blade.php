@extends('layouts.admin')
@section('title', 'Control de participación')
@section('content')
@php $labels = ['presente' => 'Presente', 'ausente' => 'Ausente', 'justificada' => 'Justificada', 'pendiente' => 'Pendiente']; @endphp
<div class="page-head">
    <div><h1>Control de participación</h1><p>Asistencia y evidencias de cada integrante, actividad por actividad.</p></div>
</div>
<div class="legend">@foreach ($labels as $k => $l)<span class="pill pill-{{ $k }}">{{ $l }}</span>@endforeach</div>

<div class="panel">
    <div class="table-responsive">
        <table class="table table-sds">
            <thead>
                <tr>
                    <th class="sticky-col">Actividad</th><th>Fecha</th>
                    @foreach ($users as $u)<th class="text-center">{{ $u->name }}</th>@endforeach
                </tr>
            </thead>
            <tbody>
            @foreach ($posts as $p)
                <tr>
                    <td class="sticky-col" style="min-width:260px"><a class="t-title" href="{{ route('admin.posts.edit', $p) }}">{{ $p->title }}</a><div class="t-sub">{{ $p->category->name }}</div></td>
                    <td class="text-nowrap">{{ $p->activity_date->format('d/m/Y') }}</td>
                    @foreach ($users as $u)
                        @php
                            $st = optional($p->attendances->firstWhere('user_id', $u->id))->status ?? 'pendiente';
                            $ev = $p->images->where('type', 'evidencia')->where('user_id', $u->id)->count();
                        @endphp
                        <td class="text-center">
                            <span class="pill pill-{{ $st }}">{{ $labels[$st] }}</span>
                            <div class="t-sub mt-1"><i class="bi bi-paperclip"></i> {{ $ev }} {{ $ev === 1 ? 'evidencia' : 'evidencias' }}</div>
                        </td>
                    @endforeach
                </tr>
            @endforeach
            </tbody>
            <tfoot>
                <tr class="fw-bold" style="background:var(--mint)">
                    <td class="sticky-col" style="background:var(--mint)">Actividades con asistencia presente</td><td></td>
                    @foreach ($users as $u)
                        @php $n = $posts->filter(fn ($p) => optional($p->attendances->firstWhere('user_id', $u->id))->status === 'presente')->count(); @endphp
                        <td class="text-center">{{ $n }} de {{ $posts->count() }}</td>
                    @endforeach
                </tr>
            </tfoot>
        </table>
    </div>
</div>
@endsection
