<?php

namespace Database\Seeders;

use App\Models\Category;
use App\Models\Post;
use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Str;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        $u1 = User::updateOrCreate(['email' => 'cq22003@ues.edu.sv'], [
            'name' => 'Estudiante Uno', 'password' => 'password',
        ]);
        $u2 = User::updateOrCreate(['email' => 'estudiante2@ues.edu.sv'], [
            'name' => 'Estudiante Dos', 'password' => 'password',
        ]);

        $cats = [];
        foreach ([
            'Inauguración' => 'Ceremonia de apertura de la Semana de Sistemas 2026.',
            'Ponencias' => 'Charlas y conferencias de expositores.',
            'Talleres' => 'Talleres prácticos de herramientas tecnológicas.',
            'Bingo' => 'Dinámica de bingo.',
            'Feria de proyectos' => 'Expo Systems: proyectos estudiantiles e innovación.',
            'Comelona de pizza' => 'Convivencia con pizza.',
            'Torneo de fútbol sala' => 'Torneo deportivo.',
            'Parrillada' => 'Convivencia de cierre.',
        ] as $name => $desc) {
            $cats[$name] = Category::firstOrCreate(['slug' => Str::slug($name)], ['name' => $name, 'description' => $desc]);
        }

        $ponencia = "Tema: \nExpositor: \nIdeas centrales: \nAprendizajes: \n\n[Reemplaza con lo que realmente viste y escuchaste]";

        // Cronograma oficial (itinerario SDS26 Green IoT)
        $actividades = [
            ['Inauguración de la Semana de Sistemas 2026', 'Inauguración', '2026-11-16', "Lugar: Auditorio 1, 8:00 a. m.\nDescribe la ceremonia: quién habló, qué se anunció y el ambiente del evento.\n\n[Reemplaza con tu descripción real]"],
            ['Ponencia 1: Investigación aplicada en IoT para la agricultura en El Salvador', 'Ponencias', '2026-11-16', "Lugar: Auditorio 1, 10:00 a. m.\n" . $ponencia],
            ['Ponencia 2: Energías alternativas y eficiencia energética', 'Ponencias', '2026-11-16', "Lugar: Auditorio 1, 1:00 p. m.\n" . $ponencia],
            ['Ponencia 3: Eficiencia energética, optimización de recursos y sostenibilidad aplicada a soluciones tecnológicas', 'Ponencias', '2026-11-17', "Lugar: Auditorio 1, 8:00 a. m.\n" . $ponencia],
            ['Taller: Sostenibilidad digital y análisis energético mediante Electricity Map', 'Talleres', '2026-11-17', "Lugar: Auditorio 1, 1:00 p. m.\nHerramientas: \nProcedimiento: \nPráctica: \nResultados: \n\n[Completa con lo que realmente hiciste]"],
            ['Bingo', 'Bingo', '2026-11-18', "Lugar: Auditorio 1, desde las 8:00 a. m.\nDinámica: \nExperiencia: \nParticipación: "],
            ['Expo Systems: feria de proyectos', 'Feria de proyectos', '2026-11-19', "Lugar: Plaza Minerva, 8:00 a. m.\nProyectos visitados: \nTecnologías: \nInnovación: "],
            ['Comelona de pizza', 'Comelona de pizza', '2026-11-19', "Lugar: Plaza Minerva, 12:00 p. m.\nDesarrollo: \nConvivencia: \nExperiencia: "],
            ['Torneo de fútbol sala', 'Torneo de fútbol sala', '2026-11-20', "Lugar: Cancha de futsal, 8:00 a. m.\nDesarrollo: \nEquipos: \nParticipación (jugador o espectador): "],
            ['Parrillada', 'Parrillada', '2026-11-20', "Lugar: Alrededores de la cancha, 12:00 p. m.\nDescripción: \nConvivencia: \nReflexión: "],
        ];

        foreach ($actividades as [$title, $cat, $date, $content]) {
            $post = Post::firstOrCreate(['title' => $title], [
                'user_id' => $u1->id,
                'category_id' => $cats[$cat]->id,
                'slug' => Str::slug($title) . '-' . Str::lower(Str::random(5)),
                'activity_date' => $date,
                'content' => $content,
                'reflection' => '',
                'status' => 'borrador',
            ]);
            $post->authors()->syncWithoutDetaching([$u1->id, $u2->id]);
            foreach ([$u1, $u2] as $u) {
                $post->attendances()->firstOrCreate(['user_id' => $u->id], ['status' => 'pendiente']);
            }
        }
    }
}
