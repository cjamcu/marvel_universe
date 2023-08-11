import 'package:flutter/material.dart';
import 'package:marvel_universe/features/characters/domain/entities/character.dart';
import 'package:marvel_universe/features/characters/presentation/widgets/character_card.dart';
import 'package:marvel_universe/features/characters/presentation/widgets/placeholder/character_card_placeholder.dart';

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
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (!widget.isLoadingMore) {
          widget.onEndOfList(null);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      controller: scrollController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.9,
        mainAxisSpacing: 5,
        crossAxisSpacing: 0,
      ),
      itemCount: widget.characters.length + (widget.isLoadingMore ? 2 : 0),
      itemBuilder: (context, index) {
        if (index < widget.characters.length) {
          final character = widget.characters[index];
          return CharacterCard(
            character: character,
            onTap: () => widget.onTap(character),
          );
        } else if (widget.isLoadingMore) {
          return const Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: CharacterCardPlaceholder(),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
