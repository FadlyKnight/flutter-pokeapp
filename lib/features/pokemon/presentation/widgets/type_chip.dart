import 'package:flutter/material.dart';

import '../../../../core/theme/pokemon_type_colors.dart';
import '../../../../core/utils/string_extensions.dart';

class TypeChip extends StatelessWidget {
  const TypeChip({super.key, required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    final color = PokemonTypeColors.of(type);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      child: Text(
        type.capitalize,
        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}
