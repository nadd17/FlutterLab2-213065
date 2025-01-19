import 'package:flutter/material.dart';
import '../models/joke_model.dart';

class RandomJokeScreen extends StatelessWidget {
  final Joke joke;
  const RandomJokeScreen({super.key, required this.joke});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Joke'),
        backgroundColor: Colors.green, 
      ),
      body: Center( 
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, 
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                joke.setup,
                textAlign: TextAlign.center, 
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                joke.punchline,
                textAlign: TextAlign.center, 
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green, 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
