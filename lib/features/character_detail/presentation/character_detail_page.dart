import 'package:flutter/material.dart';
import 'package:marvel_universe/features/characters/domain/entities/character.dart';
import 'package:marvel_universe/features/characters/presentation/widgets/character_cache_image.dart';

class CharacterDetailPage extends StatelessWidget {
  static route(Character character) {
    return MaterialPageRoute(
        builder: (context) => CharacterDetailPage(
              character: character,
            ));
  }

  final Character character;

  const CharacterDetailPage({Key? key, required this.character})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: Stack(
            children: [
              CharacterCacheImage(
                imageUrl: character.image,
                heroTag: character.id,
              ),
              Positioned(
                left: 10,
                top: 10,
                child: SafeArea(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: const BackButton(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                character.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (character.description != null)
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    character.description ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              Wrap(
                spacing: 15,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  if (character.detailLink != null)
                    ElevatedButton(
                        onPressed: () {}, child: Text("Detail".toUpperCase())),
                  if (character.wikiUrl != null)
                    ElevatedButton(
                        onPressed: () {}, child: Text("Wiki".toUpperCase())),
                  if (character.comicLink != null)
                    ElevatedButton(
                        onPressed: () {},
                        child: Text("ComicLink".toUpperCase())),
                ],
              )
            ],
          ),
        ),
      ],
    ));
  }
}
