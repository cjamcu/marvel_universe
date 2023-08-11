import 'package:flutter/material.dart';
import 'package:marvel_universe/features/character_detail/presentation/character_detail_page.dart';

import 'package:marvel_universe/features/characters/domain/entity/character.dart';
import 'package:marvel_universe/features/characters/presentation/widgets/character_grid.dart';
import 'package:marvel_universe/features/characters/presentation/widgets/search_text_field.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO - remove this mock data
    const characters = [
      Character(
        id: 1009368,
        name: "Iron Man",
        image: "https://i.annihil.us/u/prod/marvel/i/mg/9/c0/527bb7b37ff55.jpg",
        description:
            'Inventor Tony Stark applies his genius for high-tech solutions to problems as Iron Man, the armored Avenger.',
      ),
      Character(
        id: 1009610,
        name: "Spider-Man",
        image: "https://cdn.marvel.com/content/1x/005smp_com_crd_01.jpg",
        description: '',
      ),
      Character(
        id: 1009220,
        name: "Captain America",
        image: "https://i.annihil.us/u/prod/marvel/i/mg/3/50/537ba56d31087.jpg",
        description: '',
      ),
      Character(
        id: 1009664,
        name: "Thor",
        image: "https://i.annihil.us/u/prod/marvel/i/mg/5/a0/537bc7036ab02.jpg",
        description: '',
      ),
      Character(
        id: 1009351,
        name: "Hulk",
        image: "https://i.annihil.us/u/prod/marvel/i/mg/5/a0/538615ca33ab0.jpg",
        description: '',
      ),
      Character(
        id: 1009610,
        name: "Black Widow",
        image: "https://i.annihil.us/u/prod/marvel/i/mg/6/30/537ba61b764b4.jpg",
        description: '',
      ),
      Character(
        id: 1009189,
        name: "Hawkeye",
        image: "https://i.annihil.us/u/prod/marvel/i/mg/e/90/50fecaf4f101b.jpg",
        description: '',
      ),
      Character(
        id: 1009662,
        name: "Black Panther",
        image: "https://i.annihil.us/u/prod/marvel/i/mg/6/60/5261a80a67e7d.jpg",
        description: '',
      ),
      Character(
        id: 1009282,
        name: "Captain Marvel",
        image: "https://i.annihil.us/u/prod/marvel/i/mg/6/80/5269608c1be7a.jpg",
        description: '',
      ),
    ];

    return Scaffold(
        appBar: AppBar(
          title: const Text('All Characters'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            children: [
              SearchTextField(
                hintText: 'Search by character name',
                controller: TextEditingController(),
                onChanged: (value) {
                  print(value);
                },
              ),
              const SizedBox(height: 10),
              Expanded(
                  child: CharacterGrid(
                characters: characters,
                onTap: (Character character) {
                  // Navigator with transition animation to CharacterDetailPage
                  Navigator.push(context, CharacterDetailPage.route(character));
                },
              )),
            ],
          ),
        ));
  }
}
