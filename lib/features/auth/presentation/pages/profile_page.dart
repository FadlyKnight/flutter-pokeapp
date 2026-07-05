import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../settings/presentation/theme_mode_selector.dart';
import '../providers/auth_providers.dart';
import 'login_page.dart';
import 'register_page.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  bool _showRegister = false;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: authState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Center(child: Text('Something went wrong')),
        data: (user) {
          if (user == null) {
            return _showRegister
                ? RegisterPage(onNavigateToLogin: () => setState(() => _showRegister = false))
                : LoginPage(onNavigateToRegister: () => setState(() => _showRegister = true));
          }
          return _AccountView(email: user.email ?? '');
        },
      ),
    );
  }
}

class _AccountView extends ConsumerWidget {
  const _AccountView({required this.email});

  final String email;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.account_circle, size: 40),
                const SizedBox(width: 12),
                Expanded(child: Text(email, style: Theme.of(context).textTheme.titleMedium)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text('Appearance', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        const ThemeModeSelector(),
        const SizedBox(height: 24),
        FilledButton.icon(
          style: FilledButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error),
          onPressed: () => ref.read(authRepositoryProvider).signOut(),
          icon: const Icon(Icons.logout),
          label: const Text('Logout'),
        ),
      ],
    );
  }
}
