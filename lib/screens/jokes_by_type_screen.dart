import 'package:flutter/material.dart';
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
        backgroundColor: Colors.green.shade700, // Green app bar
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
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Two items per row
                crossAxisSpacing: 10, // Space between columns
                mainAxisSpacing: 10, // Space between rows
                childAspectRatio: 3, // Aspect ratio for each item
              ),
              itemCount: jokes.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.green.shade50, // Light green background for cards
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Display joke number
                        Text(
                          'Joke #${index + 1}',
                          style: TextStyle(
                            color: Colors.green.shade700, // Green text
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        // Joke setup
                        Text(
                          jokes[index].setup,
                          style: TextStyle(
                            color: Colors.green.shade700, // Green text
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        // Joke punchline
                        Text(
                          jokes[index].punchline,
                          style: TextStyle(
                            color: Colors.green.shade500, // Lighter green punchline
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
