@if (session('ok') || session('error'))
    <div class="toasts" role="status" aria-live="polite">
        @if (session('ok'))
            <div class="toast-sds" data-toast><i class="bi bi-check-circle-fill"></i><div>{{ session('ok') }}</div></div>
        @endif
        @if (session('error'))
            <div class="toast-sds is-error" data-toast><i class="bi bi-exclamation-octagon-fill"></i><div>{{ session('error') }}</div></div>
        @endif
    </div>
@endif
