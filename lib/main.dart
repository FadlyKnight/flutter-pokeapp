import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'core/constants/hive_constants.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Hive.initFlutter();
  await Future.wait([
    Hive.openBox<String>(HiveBoxes.favorites),
    Hive.openBox(HiveBoxes.settings),
    Hive.openBox<String>(HiveBoxes.pokemonListCache),
    Hive.openBox<String>(HiveBoxes.pokemonDetailCache),
  ]);

  runApp(const ProviderScope(child: MyApp()));
}
