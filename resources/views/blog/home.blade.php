@extends('layouts.app')
@section('content')
<section class="hero py-5 mt-3">
    <div class="container py-4">
        <p class="text-uppercase fw-semibold mb-1" style="color:var(--sds-green);letter-spacing:.15em">ASEIS · Universidad de El Salvador</p>
        <h1 class="display-4 fw-bold">Semana de Sistemas 2026 <span style="color:var(--sds-green)">· Green IoT</span></h1>
        <p class="lead">Crónica de nuestras experiencias en la Facultad Multidisciplinaria Oriental, Universidad de El Salvador: ponencias, talleres, feria de proyectos y convivencia.</p>
        <a href="{{ route('blog.index') }}" class="btn btn-light btn-lg">Ver entradas</a>
    </div>
</section>
<div class="container mt-4">
    <div class="row g-4 mb-4">
        <div class="col-md-6">
            <h3>Sobre el proyecto</h3>
            <p>Blog desarrollado con Laravel 12 para la asignatura Técnicas de Programación para Internet. Documentamos con hechos reales, reflexiones propias y evidencias las actividades de la Semana de Sistemas 2026.</p>
        </div>
        <div class="col-md-6">
            <h3>Actividades</h3>
            <p class="mb-0">Ponencias · Talleres · Bingo · Feria de proyectos · Comelona de pizza · Torneo de fútbol sala · Parrillada</p>
        </div>
    </div>
    @php
        $cronograma = [
            'Lunes 16 de noviembre' => [['8:00 a. m.', 'Inauguración', 'Auditorio 1'], ['10:00 a. m.', 'Ponencia 1: Investigación aplicada en IoT para la agricultura en El Salvador', 'Auditorio 1'], ['1:00 p. m.', 'Ponencia 2: Energías alternativas y eficiencia energética', 'Auditorio 1']],
            'Martes 17 de noviembre' => [['8:00 a. m.', 'Ponencia 3: Eficiencia energética, optimización de recursos y sostenibilidad aplicada a soluciones tecnológicas', 'Auditorio 1'], ['1:00 p. m.', 'Taller: Sostenibilidad digital y análisis energético mediante Electricity Map', 'Auditorio 1']],
            'Miércoles 18 de noviembre' => [['Desde las 8:00 a. m.', 'Bingo', 'Auditorio 1']],
            'Jueves 19 de noviembre' => [['8:00 a. m.', 'Expo Systems: los proyectos más innovadores de los estudiantes de Ingeniería de Sistemas Informáticos', 'Plaza Minerva'], ['12:00 p. m.', 'Comelona de pizza', 'Plaza Minerva']],
            'Viernes 20 de noviembre' => [['8:00 a. m.', 'Torneo de fútbol sala (5 jugadores por equipo)', 'Cancha de futsal'], ['12:00 p. m.', 'Parrillada', 'Alrededores de la cancha']],
        ];
    @endphp
    <h3 class="mb-3">Cronograma</h3>
    <div class="row g-3 mb-5">
        @foreach ($cronograma as $dia => $items)
            <div class="col-md-6 col-lg-4">
                <div class="card h-100 sds-day">
                    <div class="card-header fw-bold">{{ $dia }}</div>
                    <ul class="list-group list-group-flush">
                        @foreach ($items as [$hora, $actividad, $lugar])
                            <li class="list-group-item">
                                <span class="badge text-bg-primary">{{ $hora }}</span>
                                <div class="fw-semibold mt-1">{{ $actividad }}</div>
                                <div class="small text-muted">{{ $lugar }}</div>
                            </li>
                        @endforeach
                    </ul>
                </div>
            </div>
        @endforeach
    </div>

    <h3 class="mb-3">Últimas entradas</h3>
    <div class="row g-4">
        @forelse ($latest as $post)
            @include('blog._card')
        @empty
            <p class="text-muted">Aún no hay entradas publicadas.</p>
        @endforelse
    </div>
</div>
@endsection
