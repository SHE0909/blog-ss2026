<!doctype html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>@yield('title', 'Administración') · Blog SS2026</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
@include('layouts.theme')
</head>
<body class="bg-light">
<nav class="navbar navbar-expand-md navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand" href="{{ route('admin.dashboard') }}">Admin SS2026</a>
        <button class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#nav"><span class="navbar-toggler-icon"></span></button>
        <div id="nav" class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="{{ route('admin.dashboard') }}">Panel</a></li>
                <li class="nav-item"><a class="nav-link" href="{{ route('admin.posts.index') }}">Entradas</a></li>
                <li class="nav-item"><a class="nav-link" href="{{ route('admin.participation') }}">Participación</a></li>
                <li class="nav-item"><a class="nav-link" href="{{ route('admin.categories.index') }}">Categorías</a></li>
                <li class="nav-item"><a class="nav-link" href="{{ route('home') }}" target="_blank">Ver sitio</a></li>
            </ul>
            <span class="navbar-text me-3">{{ auth()->user()->name }}</span>
            <form method="POST" action="{{ route('logout') }}">@csrf
                <button class="btn btn-sm btn-outline-light">Cerrar sesión</button>
            </form>
        </div>
    </div>
</nav>
<div class="container py-4">
    @include('layouts.alerts')
    @yield('content')
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
