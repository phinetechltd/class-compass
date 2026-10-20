<?php

namespace Modules\Frontend\Database\Seeders;

use Illuminate\Database\Seeder;
use Modules\Frontend\Models\Theme;

class ThemesTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $themes = [
            // 🏫 Core Academic Institutions
            ['category' => 'Core Academic', 'name' => 'Elementary School', 'icon' => '🏫', 'description' => 'Bright, engaging design for young learners'],
            ['category' => 'Core Academic', 'name' => 'Middle School', 'icon' => '🎒', 'description' => 'Balanced design for transitional years'],
            ['category' => 'Core Academic', 'name' => 'High School', 'icon' => '🎓', 'description' => 'Dynamic, aspirational design for teens'],
            ['category' => 'Core Academic', 'name' => 'College', 'icon' => '🎓', 'description' => 'Modern, sophisticated design'],
            ['category' => 'Core Academic', 'name' => 'University', 'icon' => '🏛️', 'description' => 'Academic, prestigious design'],

            // 👶 Early Childhood
            ['category' => 'Early Childhood', 'name' => 'Kindergarten', 'icon' => '🌈', 'description' => 'Bright, playful design for young children'],

            // 🔧 Specialized Training
            ['category' => 'Specialized Training', 'name' => 'Vocational School', 'icon' => '🔧', 'description' => 'Practical, hands-on design'],
            ['category' => 'Specialized Training', 'name' => 'Culinary School', 'icon' => '👨‍🍳', 'description' => 'Warm, appetizing design'],

            // 🎨 Arts & Creative
            ['category' => 'Arts & Creative', 'name' => 'Music School', 'icon' => '🎵', 'description' => 'Creative, artistic design'],
            ['category' => 'Arts & Creative', 'name' => 'Art School', 'icon' => '🎨', 'description' => 'Inspiring, expressive design'],

            // 💪 Physical Training
            ['category' => 'Physical Training', 'name' => 'Fitness School', 'icon' => '💪', 'description' => 'Energetic, motivational design'],
            ['category' => 'Physical Training', 'name' => 'Karate School', 'icon' => '🥋', 'description' => 'Disciplined, traditional design'],
            ['category' => 'Physical Training', 'name' => 'Swimming School', 'icon' => '🏊', 'description' => 'Aquatic, refreshing design'],

            // 🌍 Language & Communication
            ['category' => 'Language & Communication', 'name' => 'Language School', 'icon' => '🌍', 'description' => 'Global, communicative design'],

            // 🚗 Transportation
            ['category' => 'Transportation', 'name' => 'Driving School', 'icon' => '🚗', 'description' => 'Dynamic, safety-focused design'],

            // 🎯 Specialized Programs
            ['category' => 'Specialized Programs', 'name' => 'Diploma Programs', 'icon' => '🏆', 'description' => 'Achievement-focused design'],
            ['category' => 'Specialized Programs', 'name' => 'Generic School', 'icon' => '🏫', 'description' => 'Default professional design'],
        ];

        foreach ($themes as $theme) {
            Theme::create($theme);
        }
    }
}
