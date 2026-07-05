import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../../core/constants/hive_constants.dart';

/// Persists the chosen [ThemeMode] in Hive so it survives app restarts.
class ThemeModeNotifier extends Notifier<ThemeMode> {
  Box get _box => Hive.box(HiveBoxes.settings);

  @override
  ThemeMode build() {
    final stored = _box.get(SettingsKeys.themeMode) as String?;
    return switch (stored) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    await _box.put(SettingsKeys.themeMode, mode.name);
  }
}

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(ThemeModeNotifier.new);
