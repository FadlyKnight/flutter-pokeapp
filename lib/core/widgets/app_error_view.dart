import 'package:flutter/material.dart';

import '../network/app_exceptions.dart';

/// Dedicated error UI so raw exceptions never reach the user.
class AppErrorView extends StatelessWidget {
  const AppErrorView({super.key, required this.exception, this.onRetry});

  final AppException exception;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final isOffline = exception is NetworkException;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isOffline ? Icons.wifi_off_rounded : Icons.error_outline_rounded,
              size: 56,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              exception.message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
