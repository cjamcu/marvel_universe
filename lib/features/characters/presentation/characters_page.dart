import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_universe/features/character_detail/presentation/character_detail_page.dart';

import 'package:marvel_universe/features/characters/domain/entities/character.dart';
import 'package:marvel_universe/features/characters/presentation/bloc/characters_bloc.dart';
import 'package:marvel_universe/features/characters/presentation/widgets/character_grid.dart';
import 'package:marvel_universe/features/characters/presentation/widgets/search_text_field.dart';

import '../../../injection_container.dart';
import 'widgets/placeholder/character_grid_placeholder.dart';

final charactersBloc = getIt<CharactersBloc>();

class CharactersPage extends StatelessWidget {
  const CharactersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('All Characters'),
          centerTitle: true,
        ),
        body: BlocBuilder<CharactersBloc, CharactersState>(
          bloc: charactersBloc..add(const FindCharactersEvent()),
          builder: (context, state) {
            if (state is Error) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Error to fetch characters"),
                    ElevatedButton(
                        onPressed: () {
                          charactersBloc.add(const FindCharactersEvent());
                        },
                        child: const Text("Retry"))
                  ],
                ),
              );
            }

            final isLoading = state is LoadingCharacters;

            return Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Column(
                children: [
                  SearchTextField(
                    hintText: 'Search by character name',
                    enabled: !isLoading,
                    controller: TextEditingController(),
                    onChanged: (value) {
                      print(value);
                    },
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                      child: isLoading
                          ? const CharacterGridPlaceholder()
                          : CharacterGrid(
                              characters: state.model.characters,
                              onTap: (Character character) {
                                // Navigator with transition animation to CharacterDetailPage
                                Navigator.push(context,
                                    CharacterDetailPage.route(character));
                              },
                            )),
                ],
              ),
            );
          },
        ));
  }
}
