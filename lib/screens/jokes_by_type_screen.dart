import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../favorites_context.dart';
import '../services/api_services.dart';
import '../models/joke_model.dart';


class JokesByTypeScreen extends StatelessWidget {
  final String jokeType;

  const JokesByTypeScreen({super.key, required this.jokeType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jokes: $jokeType'),
        backgroundColor: Colors.green.shade700,
      ),
      body: FutureBuilder<List<Joke>>(
        future: ApiService.getJokesByType(jokeType),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load jokes'));
          } else {
            final jokes = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: jokes.length,
                itemBuilder: (context, index) {
                  final joke = jokes[index];
                  return Card(
                    color: Colors.green.shade50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 6,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Joke #${index + 1}',
                            style: TextStyle(
                              color: Colors.green.shade700,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Joke setup
                          Text(
                            joke.setup,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            joke.punchline,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green.shade200,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                              ),
                              onPressed: () {
                                context
                                    .read<FavoritesProvider>()
                                    .favoriteJoke(joke);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Added to Favorites: Joke #${index + 1}'),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.favorite, size: 18),
                              label: const Text('Add to Favorites'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
