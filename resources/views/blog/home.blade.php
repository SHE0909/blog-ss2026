@extends('layouts.app')
@section('content')
@php
    $dias = [
        '2026-11-16' => ['Lun 16', 'Lunes 16 de noviembre', [
            ['8:00 a. m.', 'Inauguración', 'Auditorio 1'],
            ['10:00 a. m.', 'Ponencia 1: Investigación aplicada en IoT para la agricultura en El Salvador', 'Auditorio 1'],
            ['1:00 p. m.', 'Ponencia 2: Energías alternativas y eficiencia energética', 'Auditorio 1']]],
        '2026-11-17' => ['Mar 17', 'Martes 17 de noviembre', [
            ['8:00 a. m.', 'Ponencia 3: Eficiencia energética, optimización de recursos y sostenibilidad aplicada a soluciones tecnológicas', 'Auditorio 1'],
            ['1:00 p. m.', 'Taller: Sostenibilidad digital y análisis energético mediante Electricity Map', 'Auditorio 1']]],
        '2026-11-18' => ['Mié 18', 'Miércoles 18 de noviembre', [
            ['Desde las 8:00 a. m.', 'Bingo', 'Auditorio 1']]],
        '2026-11-19' => ['Jue 19', 'Jueves 19 de noviembre', [
            ['8:00 a. m.', 'Expo Systems: los proyectos más innovadores de los estudiantes de Ingeniería de Sistemas Informáticos', 'Plaza Minerva'],
            ['12:00 p. m.', 'Comelona de pizza', 'Plaza Minerva']]],
        '2026-11-20' => ['Vie 20', 'Viernes 20 de noviembre', [
            ['8:00 a. m.', 'Torneo de fútbol sala, 5 jugadores por equipo', 'Cancha de futsal'],
            ['12:00 p. m.', 'Parrillada', 'Alrededores de la cancha']]],
    ];
@endphp

<section class="hero">
    <canvas data-mesh aria-hidden="true"></canvas>
    <div class="container hero-inner">
        <h1 class="rise" style="--d:.05s">Semana de Sistemas 2026 <span>Green IoT</span></h1>
        <p class="lead rise" style="--d:.2s">Lo que vivimos en la Facultad Multidisciplinaria Oriental de la Universidad de El Salvador: ponencias, talleres, feria de proyectos y convivencia, contado por quienes estuvieron ahí.</p>
        <div class="hero-cta rise" style="--d:.35s">
            <a class="btn-sds" href="{{ route('blog.index') }}">Leer las entradas</a>
            <a class="btn-ghost" href="#cronograma">Ver el cronograma</a>
        </div>
        <div class="specs rise" style="--d:.5s">
            <div class="spec"><b>5</b><span>días de actividades</span></div>
            <div class="spec"><b>10</b><span>actividades registradas</span></div>
            <div class="spec"><b>2</b><span>integrantes con evidencias propias</span></div>
        </div>
    </div>
</section>

<section class="section" id="cronograma">
    <div class="container">
        <div class="row g-4">
            <div class="col-lg-4">
                <div class="section-head">
                    <h2>Cronograma de la semana</h2>
                    <p>Del 16 al 20 de noviembre, según el itinerario oficial. Elige un día para ver sus horarios y lugares.</p>
                </div>
            </div>
            <div class="col-lg-8">
                <div class="sched-card" data-days>
                    <div class="day-tabs" role="tablist">
                        @foreach ($dias as $iso => [$corto, $largo, $items])
                            <button type="button" class="day-tab" role="tab" data-day="{{ $iso }}">{{ $corto }}</button>
                        @endforeach
                    </div>
                    @foreach ($dias as $iso => [$corto, $largo, $items])
                        <div class="day-panel" data-panel="{{ $iso }}">
                            <h3>{{ $largo }}</h3>
                            <ol class="timeline">
                                @foreach ($items as [$hora, $actividad, $lugar])
                                    <li class="tl-item">
                                        <div class="tl-time">{{ $hora }}</div>
                                        <div class="tl-title">{{ $actividad }}</div>
                                        <div class="tl-place"><i class="bi bi-geo-alt"></i>{{ $lugar }}</div>
                                    </li>
                                @endforeach
                            </ol>
                        </div>
                    @endforeach
                </div>
            </div>
        </div>
    </div>
</section>

<section class="section pt-0">
    <div class="container">
        <div class="d-flex flex-wrap justify-content-between align-items-end gap-3 section-head">
            <div><h2>Últimas entradas</h2><p>Las más recientes del blog.</p></div>
            <a class="btn-ghost-dark" href="{{ route('blog.index') }}">Ver todas las entradas</a>
        </div>
        <div class="row g-4">
            @forelse ($latest as $post)
                @include('blog._card')
            @empty
                <div class="col-12"><div class="empty"><i class="bi bi-hourglass-split"></i>Todavía no hay entradas publicadas. Vuelve pronto.</div></div>
            @endforelse
        </div>
    </div>
</section>
@endsection
