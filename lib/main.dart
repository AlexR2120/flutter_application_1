import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'providers/favorites_provider.dart';
import 'screens/featured_screen.dart';
import 'screens/character_list_screen.dart';
import 'screens/favorites_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()), 
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtiene una instancia del ThemeProvider
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Game of Thrones App',
      theme: themeProvider.currentTheme,
      home: AppWithBottomNav(),
    );
  }
}

class AppWithBottomNav extends StatefulWidget {
  @override
  _AppWithBottomNavState createState() => _AppWithBottomNavState();
}

class _AppWithBottomNavState extends State<AppWithBottomNav> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    FeaturedScreen(),
    CharacterListScreen(),
    FavoritesScreen(),
  ];

  // Maneja la navegación entre pestañas
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Obtiene una instancia del ThemeProvider
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, 
        title: Center(
          child: Text(
            'Game of Thrones App',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white, 
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Destacado',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Listado',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
        ],
      ),
    );
  }
}