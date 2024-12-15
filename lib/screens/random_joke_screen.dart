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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(joke.setup, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text(joke.punchline, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
