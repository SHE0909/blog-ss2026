<style>
    :root {
        --sds-green: #8DC63F; --sds-green-dark: #6FA82A; --sds-ink: #0F1D2E; --sds-soft: #F0F9E0;
        --bs-primary: #6FA82A; --bs-primary-rgb: 111,168,42;
        --bs-link-color: #4d7d17; --bs-link-hover-color: #3b6010;
    }
    body { background: #f7fbef !important; color: var(--sds-ink); }
    .navbar.bg-dark, .navbar.bg-primary, footer.bg-dark { background: var(--sds-ink) !important; }
    .navbar { border-bottom: 4px solid var(--sds-green); }
    .btn-primary { --bs-btn-bg: var(--sds-green); --bs-btn-border-color: var(--sds-green); --bs-btn-color: var(--sds-ink);
        --bs-btn-hover-bg: var(--sds-green-dark); --bs-btn-hover-border-color: var(--sds-green-dark); --bs-btn-hover-color: #fff;
        --bs-btn-active-bg: var(--sds-green-dark); --bs-btn-active-border-color: var(--sds-green-dark); --bs-btn-active-color: #fff; font-weight: 600; }
    .btn-outline-primary { --bs-btn-color: #4d7d17; --bs-btn-border-color: var(--sds-green-dark);
        --bs-btn-hover-bg: var(--sds-green); --bs-btn-hover-border-color: var(--sds-green); --bs-btn-hover-color: var(--sds-ink);
        --bs-btn-active-bg: var(--sds-green); --bs-btn-active-color: var(--sds-ink); }
    .text-bg-primary { background-color: var(--sds-green) !important; color: var(--sds-ink) !important; }
    .text-primary { color: #4d7d17 !important; }
    .border-primary { border-color: var(--sds-green) !important; }
    .hero { background: var(--sds-ink) !important; border-bottom: 8px solid var(--sds-green); }
    .card { border-radius: .75rem; border-color: #dcebc4; }
    .card-header { background: var(--sds-soft); }
    .sds-day .card-header { background: var(--sds-green); color: var(--sds-ink); }
    .page-item.active .page-link { background: var(--sds-green); border-color: var(--sds-green); color: var(--sds-ink); }
    .page-link { color: #4d7d17; }
    .form-control:focus, .form-select:focus { border-color: var(--sds-green); box-shadow: 0 0 0 .25rem rgba(141,198,63,.25); }
</style>
