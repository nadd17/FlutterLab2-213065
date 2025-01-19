import 'package:flutter/material.dart';
import 'package:lab2/models/joke_model.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Joke> _favoriteJokes = [];

  List<Joke> get favoriteJokes => List.unmodifiable(_favoriteJokes);

  void favoriteJoke(Joke joke) {
    if (!_favoriteJokes.contains(joke)) {
      _favoriteJokes.add(joke);
      notifyListeners();
    }
  }

  void unFavoriteJoke(Joke joke) {
    if (_favoriteJokes.contains(joke)) {
      _favoriteJokes.remove(joke);
      notifyListeners();
    }
  }

  bool isFavoriteJoke(Joke joke) {
    return _favoriteJokes.contains(joke);
  }
}
