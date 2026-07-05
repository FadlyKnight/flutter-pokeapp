import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:pokedex/core/constants/hive_constants.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_card.dart';

void main() {
  setUpAll(() async {
    final dir = await Directory.systemTemp.createTemp('hive_test');
    Hive.init(dir.path);
    await Hive.openBox<String>(HiveBoxes.favorites);
  });

  testWidgets('PokemonCard shows name, id and types', (WidgetTester tester) async {
    const pokemon = Pokemon(id: 1, name: 'bulbasaur', imageUrl: '', types: ['grass', 'poison']);

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(body: PokemonCard(pokemon: pokemon, onTap: () {})),
        ),
      ),
    );

    expect(find.text('bulbasaur'), findsOneWidget);
    expect(find.text('#001'), findsOneWidget);
    expect(find.text('Grass'), findsOneWidget);
    expect(find.text('Poison'), findsOneWidget);
  });
}
