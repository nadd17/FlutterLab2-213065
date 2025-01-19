import 'package:flutter/material.dart';
import '../services/api_services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.shuffle, color: Colors.white),
              onPressed: () async {
                final randomJoke = await ApiService.getRandomJoke();
                Navigator.pushNamed(context, '/randomJoke',
                    arguments: randomJoke);
              },
              tooltip: 'Get a Random Joke',
            ),
            const SizedBox(width: 4),
            const Text(
              'Click here for a random joke',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Info Box
          Container(
            width: double.infinity,
            color: Colors.green.shade100,
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              'Have a good day! Read a good joke :)',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.black87),
            ),
          ),
          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.favorite, color: Colors.white),
              label: const Text('Favorite Jokes'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade300,
                padding: const EdgeInsets.all(12),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/favoriteJokes');
              },
            ),
          ),
          const SizedBox(height: 10),

          // Categories Grid
          Expanded(
            child: FutureBuilder<List<String>>(
              future: ApiService.getJokeTypes(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Failed to load joke types'));
                } else {
                  final jokeTypes = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, 
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 2.5, 
                      ),
                      itemCount: jokeTypes.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          color: Colors.green.shade50,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/jokesByType',
                                arguments: jokeTypes[index],
                              );
                            },
                            child: Center(
                              child: Text(
                                jokeTypes[index],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
