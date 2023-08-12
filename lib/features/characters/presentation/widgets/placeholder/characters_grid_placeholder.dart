import 'package:flutter/material.dart';

import 'package:marvel_universe/features/characters/presentation/widgets/placeholder/character_card_placeholder.dart';
import 'package:responsive_grid/responsive_grid.dart';

class CharactersGridPlaceholder extends StatelessWidget {
  const CharactersGridPlaceholder({super.key, required this.itemCount});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ResponsiveGridList(
      desiredItemWidth: 150,
      minSpacing: 10,
      children:
          List.generate(itemCount, (index) => const CharacterCardPlaceholder()),
    );
  }
}
