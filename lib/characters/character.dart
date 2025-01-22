class Character {
  final String name;
  final String gender;
  final String culture;
  final String? birth;
  final String? death;
  final String? title;
  final String? alias;

  Character({
    required this.name,
    required this.gender,
    required this.culture,
    this.birth,
    this.death,
    this.title,
    this.alias,
  });

  // Esta función mapea los datos que vienen de la API a los atributos de la clase Character
  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      name: json['name'] ?? 'Sin Nombre',
      gender: json['gender'] ?? 'Desconocido',
      culture: json['culture'] ?? 'Desconocida',
      birth: json['born'], // Puede estar vacío en algunos personajes
      death: json['died'], // Puede estar vacío en algunos personajes
      title: json['titles'] != null && json['titles'].isNotEmpty ? json['titles'][0] : null, // Título (si hay)
      alias: json['aliases'] != null && json['aliases'].isNotEmpty ? json['aliases'][0] : null, // Alias (si hay)
    );
  }
}