import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Bottom-nav shell hosting the Pokédex, Favorites, and Profile tabs.
/// Each branch keeps its own navigation stack alive (StatefulShellRoute),
/// so switching tabs preserves scroll position and in-flight state.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.catching_pokemon_outlined), selectedIcon: Icon(Icons.catching_pokemon), label: 'Pokédex'),
          NavigationDestination(icon: Icon(Icons.favorite_border), selectedIcon: Icon(Icons.favorite), label: 'Favorites'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
