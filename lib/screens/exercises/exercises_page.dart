import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExercisesPage extends StatefulWidget {
  const ExercisesPage({super.key});

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  final SupabaseClient _supabase = Supabase.instance.client;

  late Future<List<Map<String, dynamic>>> _exercisesFuture;

  @override
  void initState() {
    super.initState();
    _exercisesFuture = _fetchExercises();
  }

  Future<List<Map<String, dynamic>>> _fetchExercises() async {
    final response = await _supabase
        .from('exercises')
        .select()
        .order('name', ascending: true);

    return List<Map<String, dynamic>>.from(response);
  }

  Future<void> _refresh() async {
    setState(() {
      _exercisesFuture = _fetchExercises();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercises'),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _exercisesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No exercises found'),
              );
            }

            final exercises = snapshot.data!;

            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                final ex = exercises[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    title: Text(ex['name'] ?? ''),
                    subtitle: Text(
                      '${ex['type'] ?? ''} • ${ex['active_muscles'] ?? ''}',
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // opcional: navegar a detalle
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}