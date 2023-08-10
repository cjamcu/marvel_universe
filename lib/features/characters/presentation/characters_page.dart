import 'package:flutter/material.dart';

import 'package:marvel_universe/features/characters/domain/entity/character.dart';
import 'package:marvel_universe/features/characters/presentation/widgets/character_grid.dart';
import 'package:marvel_universe/features/characters/presentation/widgets/search_text_field.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO - remove this mock data
    final characters = [
      Character(
          name: "Iro-Man",
          image:
              "https://i.annihil.us/u/prod/marvel/i/mg/9/c0/527bb7b37ff55.jpg"),
      Character(
          name: "Spider-Man",
          image: "https://cdn.marvel.com/content/1x/005smp_com_crd_01.jpg"),
      Character(
          name: "Captain America",
          image:
              "https://i.annihil.us/u/prod/marvel/i/mg/3/50/537ba56d31087.jpg"),
      Character(
          name: "Thor",
          image:
              "https://i.annihil.us/u/prod/marvel/i/mg/5/a0/537bc7036ab02.jpg"),
      Character(
          name: "Hulk",
          image:
              "https://i.annihil.us/u/prod/marvel/i/mg/5/a0/538615ca33ab0.jpg"),
      Character(
          name: "Black Widow",
          image:
              "https://i.annihil.us/u/prod/marvel/i/mg/6/30/537ba61b764b4.jpg"),
      Character(
          name: "Hawkeye",
          image:
              "https://i.annihil.us/u/prod/marvel/i/mg/e/90/50fecaf4f101b.jpg"),
      Character(
          name: "Black Panther",
          image:
              "https://i.annihil.us/u/prod/marvel/i/mg/6/60/5261a80a67e7d.jpg"),
      Character(
          name: "Captain Marvel",
          image:
              "https://i.annihil.us/u/prod/marvel/i/mg/6/80/5269608c1be7a.jpg"),
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
              Expanded(child: CharacterGrid(characters: characters)),
            ],
          ),
        ));
  }
}
