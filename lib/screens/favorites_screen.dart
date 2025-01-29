import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
import '../screens/character_detail_screen.dart';
import '../widgets/background_container.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return BackgroundContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Favoritos'),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.7),
        ),
        body: favoritesProvider.favorites.isEmpty
            ? const Center(
                child: Text(
                  'No tienes personajes favoritos.',
                  style: TextStyle(color: Colors.white),
                ),
              )
            : ListView.builder(
                itemCount: favoritesProvider.favorites.length,
                itemBuilder: (context, index) {
                  final character = favoritesProvider.favorites[index];
                  return ListTile(
                    title: Text(
                      character.name.isNotEmpty ? character.name : 'Sin Nombre',
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      character.culture.isNotEmpty
                          ? character.culture
                          : 'Cultura desconocida',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CharacterDetailScreen(character: character),
                        ),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}