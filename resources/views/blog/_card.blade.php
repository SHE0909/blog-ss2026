<div class="col-md-6 col-lg-4">
    <div class="card h-100 shadow-sm">
        @if ($post->image_url)
            <img src="{{ $post->image_url }}" class="card-img-top" alt="{{ $post->title }}">
        @endif
        <div class="card-body d-flex flex-column">
            <span class="badge text-bg-primary align-self-start mb-2">{{ $post->category->name }}</span>
            <h5 class="card-title">{{ $post->title }}</h5>
            <p class="card-text text-muted small">{{ $post->excerpt }}</p>
            <div class="mt-auto small text-secondary">
                {{ $post->activity_date->format('d/m/Y') }} · {{ $post->authors->pluck('name')->join(', ') }}
            </div>
            <a href="{{ route('blog.show', $post) }}" class="stretched-link"></a>
        </div>
    </div>
</div>
