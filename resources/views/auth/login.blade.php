<!doctype html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Ingresar · Admin SDS26</title>
    @include('layouts.assets')
</head>
<body>
@include('layouts.alerts')
<div class="auth">
    <aside class="auth-brand">
        <canvas data-mesh aria-hidden="true"></canvas>
        <div class="auth-brand-in">
            <a class="brand" href="{{ route('home') }}">@include('layouts.brandmark')<span>SDS26 Green IoT</span></a>
            <h1>Panel de la Semana de Sistemas</h1>
            <p>Registra las actividades, sube las evidencias de cada integrante y publica las entradas del blog.</p>
        </div>
    </aside>
    <main class="auth-form">
        <div class="auth-box">
            <h2>Iniciar sesión</h2>
            <p class="hint mb-4">Usa la cuenta de uno de los integrantes.</p>
            <form method="POST" action="{{ route('login') }}">
                @csrf
                <div class="mb-3">
                    <label class="form-label" for="email">Correo</label>
                    <input id="email" type="email" name="email" value="{{ old('email') }}" class="form-control @error('email') is-invalid @enderror" required autofocus autocomplete="username">
                    @error('email')<div class="invalid-feedback">{{ $message }}</div>@enderror
                </div>
                <div class="mb-3">
                    <label class="form-label" for="password">Contraseña</label>
                    <input id="password" type="password" name="password" class="form-control @error('password') is-invalid @enderror" required autocomplete="current-password">
                    @error('password')<div class="invalid-feedback">{{ $message }}</div>@enderror
                </div>
                <div class="form-check mb-4"><input class="form-check-input" type="checkbox" name="remember" id="r"><label class="form-check-label" for="r">Mantener la sesión iniciada</label></div>
                <button class="btn-sds w-100">Entrar al panel</button>
            </form>
            <p class="mt-4 mb-0"><a class="back" href="{{ route('home') }}"><i class="bi bi-arrow-left"></i> Volver al sitio</a></p>
        </div>
    </main>
</div>
<script src="{{ asset('js/sds.js') }}?v={{ filemtime(public_path('js/sds.js')) }}"></script>
</body>
</html>
