<div class="col-md-6 col-xl-4">
    <article class="post-card h-100">
        <div class="post-card-media">
            @if ($post->image_url)
                <img src="{{ $post->image_url }}" alt="" loading="lazy">
            @else
                <div class="media-ph"><i class="bi bi-broadcast"></i></div>
            @endif
        </div>
        <div class="post-card-body">
            <span class="tag">{{ $post->category->name }}</span>
            <h3 class="post-card-title"><a class="stretched-link" href="{{ route('blog.show', $post) }}">{{ $post->title }}</a></h3>
            <p class="post-card-excerpt">{{ $post->excerpt }}</p>
            <div class="post-card-meta">
                <span><i class="bi bi-calendar-event"></i>{{ $post->activity_date->format('d/m/Y') }}</span>
                <span><i class="bi bi-people"></i>{{ $post->authors->pluck('name')->join(', ') }}</span>
            </div>
        </div>
    </article>
</div>
