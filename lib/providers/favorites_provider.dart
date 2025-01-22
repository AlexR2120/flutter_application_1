import 'package:flutter/material.dart';
import '../characters/character.dart';

class FavoritesProvider with ChangeNotifier {
  final List<Character> _favorites = [];

  List<Character> get favorites => _favorites;

  void addFavorite(Character character) {
    _favorites.add(character);
    notifyListeners();
  }

  void removeFavorite(Character character) {
    _favorites.remove(character);
    notifyListeners();
  }
}