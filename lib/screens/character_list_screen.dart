import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../characters/character.dart';
import 'character_detail_screen.dart';

class CharacterListScreen extends StatefulWidget {
  @override
  _CharacterListScreenState createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  final ApiService apiService = ApiService();
  int _currentPage = 1; // Página actual
  List<Character> _characters = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCharacters();
  }

  // Obtener personajes para la página actual
  Future<void> _fetchCharacters() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final characters = await apiService.fetchCharactersByPage(_currentPage);
      setState(() {
        _characters = characters;
        _isLoading = false;
      });
    } catch (error) {
      print('Error al cargar personajes: $error');
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Cambiar a la página anterior
  void _previousPage() {
    if (_currentPage > 1) {
      setState(() {
        _currentPage--;
      });
      _fetchCharacters();
    }
  }

  // Cambiar a la página siguiente
  void _nextPage() {
    setState(() {
      _currentPage++;
    });
    _fetchCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de Personajes'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _characters.length,
                    itemBuilder: (context, index) {
                      final character = _characters[index];
                      return ListTile(
                        title: Text(character.name.isNotEmpty ? character.name : 'Sin Nombre'),
                        subtitle: Text(character.culture.isNotEmpty
                            ? 'Cultura: ${character.culture}'
                            : 'Cultura: Desconocida'),
                        onTap: () {
                          // Navegación a la pantalla de detalles
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: _currentPage > 1 ? _previousPage : null,
                      icon: const Icon(Icons.arrow_back),
                      tooltip: 'Página anterior',
                    ),
                    Text('Página $_currentPage'),
                    IconButton(
                      onPressed: _characters.isNotEmpty ? _nextPage : null,
                      icon: const Icon(Icons.arrow_forward),
                      tooltip: 'Página siguiente',
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}