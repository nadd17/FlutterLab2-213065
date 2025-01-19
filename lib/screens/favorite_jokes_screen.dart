import 'package:flutter/material.dart';
import 'package:lab2/favorites_context.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Jokes'),
        backgroundColor: Colors.green.shade700,
      ),
      body: favoritesProvider.favoriteJokes.isEmpty
          ? const Center(
              child: Text(
                'No favorites yet! Add some jokes to your favorites.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Two cards per row
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1, // Square cards
              ),
              itemCount: favoritesProvider.favoriteJokes.length,
              itemBuilder: (context, index) {
                final joke = favoritesProvider.favoriteJokes[index];
                return GestureDetector(
                  onLongPress: () {
                    _showDeleteDialog(context, joke, favoritesProvider);
                  },
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            joke.setup,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const Divider(color: Colors.grey),
                          Text(
                            joke.punchline,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _showDeleteDialog(
      BuildContext context, joke, FavoritesProvider favoritesProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove Favorite'),
          content: const Text('Are you sure you want to remove this joke?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                favoritesProvider.unFavoriteJoke(joke);
                Navigator.of(context).pop();
              },
              child: const Text('Remove', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
