<!doctype html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>@yield('title', 'Semana de Sistemas 2026 · Green IoT')</title>
    @include('layouts.assets')
</head>
<body class="site">
@include('layouts.alerts')
<nav class="navbar navbar-expand-md navbar-dark sds-nav">
    <div class="container">
        <a class="brand" href="{{ route('home') }}">
            @include('layouts.brandmark')
            <span>SDS26 Green IoT<small>Semana de Sistemas 2026</small></span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#nav" aria-label="Abrir menú"><span class="navbar-toggler-icon"></span></button>
        <div id="nav" class="collapse navbar-collapse">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link {{ request()->routeIs('home') ? 'active' : '' }}" href="{{ route('home') }}">Inicio</a></li>
                <li class="nav-item"><a class="nav-link {{ request()->routeIs('blog.*') ? 'active' : '' }}" href="{{ route('blog.index') }}">Entradas</a></li>
                @auth
                    <li class="nav-item"><a class="nav-link" href="{{ route('admin.dashboard') }}">Panel</a></li>
                @else
                    <li class="nav-item"><a class="nav-link" href="{{ route('login') }}">Ingresar</a></li>
                @endauth
            </ul>
        </div>
    </div>
</nav>

<main>@yield('content')</main>

<footer class="sds-footer">
    <div class="container d-flex flex-wrap justify-content-between gap-3">
        <div><strong>Semana de Sistemas 2026</strong><br>Universidad de El Salvador, Facultad Multidisciplinaria Oriental</div>
        <div class="text-md-end">Técnicas de Programación para Internet<br>Blog hecho con Laravel 12</div>
    </div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="{{ asset('js/sds.js') }}?v={{ filemtime(public_path('js/sds.js')) }}"></script>
</body>
</html>
