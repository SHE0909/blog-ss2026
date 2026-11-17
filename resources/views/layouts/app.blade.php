<!doctype html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>@yield('title', 'Blog Semana de Sistemas 2026')</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .hero { background: linear-gradient(135deg,#0d3b66,#1b6ca8); color:#fff; }
        .card-img-top { height: 200px; object-fit: cover; }
        .post-content { white-space: pre-line; line-height: 1.8; }
        .gallery img { height: 220px; object-fit: cover; width: 100%; }
    </style>
@include('layouts.theme')
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
<nav class="navbar navbar-expand-md navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand fw-bold" href="{{ route('home') }}">SDS<span style="color:var(--sds-green)">26</span> · Green IoT</a>
        <button class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#nav"><span class="navbar-toggler-icon"></span></button>
        <div id="nav" class="collapse navbar-collapse">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="{{ route('home') }}">Inicio</a></li>
                <li class="nav-item"><a class="nav-link" href="{{ route('blog.index') }}">Entradas</a></li>
                @auth
                    <li class="nav-item"><a class="nav-link" href="{{ route('admin.dashboard') }}">Panel</a></li>
                @else
                    <li class="nav-item"><a class="nav-link" href="{{ route('login') }}">Ingresar</a></li>
                @endauth
            </ul>
        </div>
    </div>
</nav>
<main class="flex-grow-1">
    <div class="container mt-3">@include('layouts.alerts')</div>
    @yield('content')
</main>
<footer class="bg-dark text-light py-3 mt-5">
    <div class="container small text-center">
        Universidad de El Salvador · Facultad Multidisciplinaria Oriental · Técnicas de Programación para Internet · 2026
    </div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
