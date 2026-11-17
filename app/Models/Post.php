<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Str;

class Post extends Model
{
    protected $fillable = [
        'user_id', 'category_id', 'title', 'slug', 'activity_date',
        'content', 'reflection', 'main_image', 'status',
    ];

    protected $casts = ['activity_date' => 'date'];

    public function category()
    {
        return $this->belongsTo(Category::class);
    }

    public function creator()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function authors()
    {
        return $this->belongsToMany(User::class, 'post_user');
    }

    public function images()
    {
        return $this->hasMany(PostImage::class);
    }

    public function attendances()
    {
        return $this->hasMany(Attendance::class);
    }

    public function scopePublished($q)
    {
        return $q->where('status', 'publicado');
    }

    public function getImageUrlAttribute(): ?string
    {
        return $this->main_image ? asset('storage/' . $this->main_image) : null;
    }

    public function getExcerptAttribute(): string
    {
        return Str::limit(strip_tags($this->content), 160);
    }
}
