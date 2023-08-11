import 'package:flutter/material.dart';

import 'package:marvel_universe/features/characters/presentation/widgets/placeholder/character_card_placeholder.dart';

class CharacterGridPlaceholder extends StatelessWidget {
  const CharacterGridPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.9,
        mainAxisSpacing: 5,
        crossAxisSpacing: 0,
      ),
      itemCount: 4, // You can adjust the number of placeholder items
      itemBuilder: (context, index) {
        return const CharacterCardPlaceholder(); // Placeholder for individual character
      },
    );
  }
}
