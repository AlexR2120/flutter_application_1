import 'package:flutter/material.dart';
import '../characters/character.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';

class CharacterDetailScreen extends StatelessWidget {
  final Character character;

  CharacterDetailScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final isFavorite = favoritesProvider.favorites.contains(character);

    return Scaffold(
      appBar: AppBar(
        title: Text(character.name.isNotEmpty ? character.name : 'Sin Nombre'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nombre: ${character.name.isNotEmpty ? character.name : 'Sin Nombre'}', style: TextStyle(fontSize: 20)),
            Text('Género: ${character.gender.isNotEmpty ? character.gender : 'Desconocido'}', style: TextStyle(fontSize: 18)),
            Text('Cultura: ${character.culture.isNotEmpty ? character.culture : 'Desconocida'}', style: TextStyle(fontSize: 18)),
            Text('Nacimiento: ${character.birth != null ? character.birth : 'Desconocido'}', style: TextStyle(fontSize: 18)),
            Text('Muerte: ${character.death != null ? character.death : 'Desconocida'}', style: TextStyle(fontSize: 18)),
            Text('Título: ${character.title != null ? character.title : 'Sin título'}', style: TextStyle(fontSize: 18)),
            Text('Alias: ${character.alias != null && character.alias!.isNotEmpty ? character.alias : 'Sin alias'}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
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
    );
  }
}