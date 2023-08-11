import 'package:flutter/material.dart';
import 'package:marvel_universe/features/characters/domain/entities/character.dart';
import 'package:marvel_universe/features/characters/presentation/widgets/character_card.dart';

class CharacterGrid extends StatelessWidget {
  const CharacterGrid({
    super.key,
    required this.characters,
    required this.onTap,
  });

  final List<Character> characters;
  final ValueChanged<Character> onTap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.9,
        mainAxisSpacing: 5,
        crossAxisSpacing: 0,
      ),
      itemCount: characters.length,
      itemBuilder: (context, index) {
        final character = characters[index];
        return CharacterCard(
            character: character, onTap: () => onTap(character));
      },
    );
  }
}
