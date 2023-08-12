import 'package:flutter/material.dart';
import 'package:marvel_universe/features/characters/domain/entities/character.dart';
import 'package:marvel_universe/features/characters/presentation/widgets/character_card.dart';
import 'package:marvel_universe/features/characters/presentation/widgets/placeholder/character_card_placeholder.dart';
import 'package:responsive_grid/responsive_grid.dart';

class CharacterGrid extends StatefulWidget {
  const CharacterGrid({
    Key? key,
    required this.characters,
    required this.onTap,
    required this.onEndOfList,
    required this.isLoadingMore,
  }) : super(key: key);

  final List<Character> characters;
  final ValueChanged<Character> onTap;
  final ValueChanged<void> onEndOfList;
  final bool isLoadingMore;

  @override
  State<CharacterGrid> createState() => _CharacterGridState();
}

class _CharacterGridState extends State<CharacterGrid> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.extentAfter < 0.1 * scrollController.position.extentInside) {
        if (!widget.isLoadingMore) {
          widget.onEndOfList(null);
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return ResponsiveGridList(

      controller: scrollController,
      desiredItemWidth: 150,
      minSpacing: 10,
      children: [
        ...widget.characters.map(
          (character) => CharacterCard(
            character: character,
            onTap: () => widget.onTap(character),
          ),
        ),
        if (widget.isLoadingMore)
          ...List.generate(
            4,
            (index) => const Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: CharacterCardPlaceholder(),
            ),
          ),
      ],
    );
  }
}
