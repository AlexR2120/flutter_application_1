import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
import '../screens/character_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
      ),
      body: favoritesProvider.favorites.isEmpty
          ? const Center(child: Text('No tienes personajes favoritos.'))
          : ListView.builder(
              itemCount: favoritesProvider.favorites.length,
              itemBuilder: (context, index) {
                final character = favoritesProvider.favorites[index];
                return ListTile(
                  title: Text(character.name.isNotEmpty ? character.name : 'Sin Nombre'),
                  subtitle: Text(character.culture.isNotEmpty ? character.culture : 'Cultura desconocida'),
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
    );
  }
}