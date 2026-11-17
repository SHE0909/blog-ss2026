@extends('layouts.app')
@section('title', 'Ingresar')
@section('content')
<div class="container" style="max-width:420px">
    <div class="card shadow-sm mt-4"><div class="card-body">
        <h4 class="mb-3">Iniciar sesión</h4>
        <form method="POST" action="{{ route('login') }}">
            @csrf
            <div class="mb-3">
                <label class="form-label">Correo</label>
                <input type="email" name="email" value="{{ old('email') }}" class="form-control @error('email') is-invalid @enderror" required autofocus>
                @error('email')<div class="invalid-feedback">{{ $message }}</div>@enderror
            </div>
            <div class="mb-3">
                <label class="form-label">Contraseña</label>
                <input type="password" name="password" class="form-control @error('password') is-invalid @enderror" required>
                @error('password')<div class="invalid-feedback">{{ $message }}</div>@enderror
            </div>
            <div class="form-check mb-3"><input class="form-check-input" type="checkbox" name="remember" id="r"><label class="form-check-label" for="r">Recordarme</label></div>
            <button class="btn btn-primary w-100">Entrar</button>
        </form>
    </div></div>
</div>
@endsection
