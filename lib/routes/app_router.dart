import 'package:go_router/go_router.dart';

import '../features/favorites/presentation/pages/favorites_page.dart';
import '../features/auth/presentation/pages/profile_page.dart';
import '../features/pokemon/presentation/pages/home_page.dart';
import 'app_shell.dart';

final appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => AppShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(routes: [GoRoute(path: '/home', builder: (_, __) => const HomePage())]),
        StatefulShellBranch(routes: [GoRoute(path: '/favorites', builder: (_, __) => const FavoritesPage())]),
        StatefulShellBranch(routes: [GoRoute(path: '/profile', builder: (_, __) => const ProfilePage())]),
      ],
    ),
  ],
);
