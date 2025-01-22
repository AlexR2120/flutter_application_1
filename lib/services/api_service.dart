import 'dart:convert';
import 'package:http/http.dart' as http;
import '../characters/character.dart';

class ApiService {
  // Obtener el número total de personajes
  Future<int> fetchTotalCharacters() async {
    final response = await http.get(
      Uri.parse('https://anapioficeandfire.com/api/characters?page=1&pageSize=1'),
    );

    if (response.statusCode == 200) {
      final totalCharacters = 2138; // Número conocido según la API
      return totalCharacters;
    } else {
      throw Exception('Error al obtener el total de personajes');
    }
  }

  // Obtener personajes de una página específica
  Future<List<Character>> fetchCharactersByPage(int page) async {
    final response = await http.get(
      Uri.parse('https://anapioficeandfire.com/api/characters?page=$page&pageSize=10'),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Character.fromJson(e)).toList();
    } else {
      throw Exception('Error al cargar personajes: ${response.statusCode}');
    }
  }
}