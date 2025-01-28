import 'dart:math';
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../characters/character.dart';

class FeaturedScreen extends StatefulWidget {
  @override
  _FeaturedScreenState createState() => _FeaturedScreenState();
}

class _FeaturedScreenState extends State<FeaturedScreen> {
  final ApiService apiService = ApiService();
  Character? _randomCharacter;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchRandomCharacter();
  }

  // Obtener un personaje aleatorio
  Future<void> _fetchRandomCharacter() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Paso 1: Obtener el total de personajes
      final totalCharacters = await apiService.fetchTotalCharacters();

      // Paso 2: Seleccionar un índice aleatorio
      final randomIndex = Random().nextInt(totalCharacters);

      // Paso 3: Calcular la página y posición en esa página
      final pageSize = 10;
      final page = (randomIndex ~/ pageSize) + 1;
      final indexInPage = randomIndex % pageSize;

      // Paso 4: Obtener los personajes de la página seleccionada
      final characters = await apiService.fetchCharactersByPage(page);

      // Paso 5: Elegir el personaje aleatorio de esa página
      setState(() {
        _randomCharacter = characters[indexInPage];
        _isLoading = false;
      });
    } catch (error) {
      print('Error al obtener el personaje aleatorio: $error');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personaje Destacado'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backgroundGT.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _randomCharacter != null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _randomCharacter!.name.isNotEmpty
                              ? _randomCharacter!.name
                              : 'Sin Nombre',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Género: ${_randomCharacter!.gender.isNotEmpty ? _randomCharacter!.gender : 'Desconocido'}',
                          style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Cultura: ${_randomCharacter!.culture.isNotEmpty ? _randomCharacter!.culture : 'Desconocida'}',
                          style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _fetchRandomCharacter,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 211, 211, 228),
                          ),
                          child: const Text('Cambiar personaje'),
                        ),
                      ],
                    ),
                  )
                : const Center(
                    child: Text(
                      'No se pudo cargar un personaje destacado.',
                      style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
      ),
    );
  }
}