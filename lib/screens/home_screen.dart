import 'package:flutter/material.dart';
import '../services/api_services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Joke Categories'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shuffle),
            onPressed: () async {
              final randomJoke = await ApiService.getRandomJoke();
              Navigator.pushNamed(context, '/randomJoke', arguments: randomJoke);
            },
          ),
        ],
      ),
      body: FutureBuilder<List<String>>(
        future: ApiService.getJokeTypes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load joke types'));
          } else {
            final jokeTypes = snapshot.data!;
            return ListView.builder(
              itemCount: jokeTypes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(jokeTypes[index]),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/jokesByType',
                      arguments: jokeTypes[index],
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
