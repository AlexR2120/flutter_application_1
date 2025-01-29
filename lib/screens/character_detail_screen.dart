import 'package:flutter/material.dart';
import '../characters/character.dart';
import '../providers/favorites_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/background_container.dart';

class CharacterDetailScreen extends StatelessWidget {
  final Character character;

  CharacterDetailScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final isFavorite = favoritesProvider.favorites.contains(character);

    return BackgroundContainer(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        appBar: AppBar(
          title: Text(character.name.isNotEmpty ? character.name : 'Sin Nombre'),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.7),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nombre: ${character.name.isNotEmpty ? character.name : 'Sin Nombre'}',
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              Text(
                'Género: ${character.gender.isNotEmpty ? character.gender : 'Desconocido'}',
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
              Text(
                'Cultura: ${character.culture.isNotEmpty ? character.culture : 'Desconocida'}',
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
              Text(
                'Nacimiento: ${character.birth != null ? character.birth : 'Desconocido'}',
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
              Text(
                'Muerte: ${character.death != null ? character.death : 'Desconocida'}',
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
              Text(
                'Título: ${character.title != null ? character.title : 'Sin título'}',
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
              Text(
                'Alias: ${character.alias != null && character.alias!.isNotEmpty ? character.alias : 'Sin alias'}',
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(height: 20),
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey,
                ),
                onPressed: () {
                  if (isFavorite) {
                    favoritesProvider.removeFavorite(character);
                  } else {
                    favoritesProvider.addFavorite(character);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}