import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/jokes_by_type_screen.dart';
import 'screens/random_joke_screen.dart';
import 'models/joke_model.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Jokes',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/jokesByType': (context) {
          final jokeType = ModalRoute.of(context)!.settings.arguments as String;
          return JokesByTypeScreen(jokeType: jokeType);
        },
        '/randomJoke': (context) {
          final joke = ModalRoute.of(context)!.settings.arguments as Joke;
          return RandomJokeScreen(joke: joke);
        },
      },
    );
  }
}
