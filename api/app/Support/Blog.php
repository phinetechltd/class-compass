<?php

namespace App\Support;

use Illuminate\Support\Carbon;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Str;

/**
 * Blog posts for the product website. Each post is a Markdown file in resources/blog with a
 * front-matter block:
 *
 *   ---
 *   title: Collecting school fees with M-Pesa
 *   slug: mpesa-school-fees              (optional, defaults to the file name)
 *   date: 2026-10-20
 *   excerpt: One or two sentences for the index page and search results.
 *   cover: blog/mpesa.jpg                (under public/assets/classcompass)
 *   tags: Fees, M-Pesa
 *   author: Class Compass Team
 *   ---
 *
 * Posts dated in the future stay hidden until that day.
 */
class Blog
{
    public static function all(): Collection
    {
        $dir = resource_path('blog');
        $files = is_dir($dir) ? glob($dir.'/*.md') : [];
        $key = 'blog.posts.'.md5(implode('|', array_map(fn ($f) => $f.filemtime($f), $files)));

        return Cache::remember($key, now()->addDay(), function () use ($files) {
            return collect($files)->map(fn ($file) => self::parse($file))->filter()
                ->sortByDesc('date')->values();
        })->filter(fn ($p) => $p['date']->lte(now()))->values();
    }

    public static function find(string $slug): ?array
    {
        return self::all()->firstWhere('slug', $slug);
    }

    public static function latest(int $count = 3): Collection
    {
        return self::all()->take($count);
    }

    private static function parse(string $file): ?array
    {
        $raw = str_replace("\r\n", "\n", (string) file_get_contents($file));
        if (! preg_match('/^---\n(.*?)\n---\n(.*)$/s', $raw, $m)) {
            return null;
        }
        $meta = [];
        foreach (explode("\n", $m[1]) as $line) {
            if (preg_match('/^([a-z_]+):\s*(.*)$/i', trim($line), $kv)) {
                $meta[strtolower($kv[1])] = trim($kv[2], " \"'");
            }
        }
        if (empty($meta['title']) || empty($meta['date'])) {
            return null;
        }
        $body = trim($m[2]);
        $words = str_word_count(strip_tags($body));

        return [
            'title' => $meta['title'],
            'slug' => $meta['slug'] ?? Str::slug(pathinfo($file, PATHINFO_FILENAME)),
            'date' => Carbon::parse($meta['date']),
            'excerpt' => $meta['excerpt'] ?? Str::limit(strip_tags(Str::markdown($body)), 180),
            'cover' => $meta['cover'] ?? null,
            'tags' => array_values(array_filter(array_map('trim', explode(',', $meta['tags'] ?? '')))),
            'author' => $meta['author'] ?? 'Class Compass Team',
            'minutes' => max(1, (int) ceil($words / 220)),
            'html' => Str::markdown($body, ['html_input' => 'allow', 'allow_unsafe_links' => false]),
        ];
    }
}
