<!doctype html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>@yield('title', 'Administración') · Admin SDS26</title>
    @include('layouts.assets')
</head>
<body class="admin">
@include('layouts.alerts')
<aside class="sidebar offcanvas-lg offcanvas-start" tabindex="-1" id="sidebar" aria-label="Menú de administración">
    <div class="side-head">
        <a class="brand" href="{{ route('admin.dashboard') }}">@include('layouts.brandmark')<span>Admin SDS26<small>Panel de control</small></span></a>
        <button type="button" class="btn-close btn-close-white d-lg-none" data-bs-dismiss="offcanvas" data-bs-target="#sidebar" aria-label="Cerrar"></button>
    </div>
    <nav class="side-nav">
        <a class="side-link {{ request()->routeIs('admin.dashboard') ? 'is-active' : '' }}" href="{{ route('admin.dashboard') }}"><i class="bi bi-speedometer2"></i> Panel</a>
        <a class="side-link {{ request()->routeIs('admin.posts.*') ? 'is-active' : '' }}" href="{{ route('admin.posts.index') }}"><i class="bi bi-journal-richtext"></i> Entradas</a>
        <a class="side-link {{ request()->routeIs('admin.participation') ? 'is-active' : '' }}" href="{{ route('admin.participation') }}"><i class="bi bi-person-check"></i> Participación</a>
        <a class="side-link {{ request()->routeIs('admin.categories.*') ? 'is-active' : '' }}" href="{{ route('admin.categories.index') }}"><i class="bi bi-tags"></i> Categorías</a>
    </nav>
    <div class="side-foot">
        <a class="side-link" href="{{ route('home') }}" target="_blank"><i class="bi bi-box-arrow-up-right"></i> Ver sitio público</a>
        <div class="side-user"><span class="avatar">{{ mb_strtoupper(mb_substr(auth()->user()->name, 0, 1)) }}</span> {{ auth()->user()->name }}</div>
        <form method="POST" action="{{ route('logout') }}">@csrf
            <button class="btn-ghost w-100"><i class="bi bi-box-arrow-left"></i> Cerrar sesión</button>
        </form>
    </div>
</aside>

<div class="admin-main">
    <header class="admin-top d-lg-none">
        <button class="btn-ghost btn-icon" type="button" data-bs-toggle="offcanvas" data-bs-target="#sidebar" aria-label="Abrir menú"><i class="bi bi-list fs-5"></i></button>
        <span class="brand">Admin SDS26</span>
    </header>
    <div class="admin-content">@yield('content')</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="{{ asset('js/sds.js') }}?v={{ filemtime(public_path('js/sds.js')) }}"></script>
</body>
</html>
