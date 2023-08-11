import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_universe/features/character_detail/presentation/character_detail_page.dart';
import 'package:marvel_universe/features/characters/domain/entities/character.dart';
import 'package:marvel_universe/features/characters/presentation/bloc/characters_bloc.dart';
import 'package:marvel_universe/features/characters/presentation/widgets/centered_text.dart';
import 'package:marvel_universe/features/characters/presentation/widgets/character_grid.dart';
import 'package:marvel_universe/features/characters/presentation/widgets/placeholder/character_grid_placeholder.dart';
import 'package:marvel_universe/features/characters/presentation/widgets/search_text_field.dart';
import '../../../injection_container.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final charactersBloc = getIt<CharactersBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Characters'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchTextField(
              hintText: 'Search by character name',
              onChanged: (value) {
                charactersBloc.add(SearchCharactersByNameEvent(value));
              },
            ),
            const SizedBox(height: 10),
            BlocBuilder<CharactersBloc, CharactersState>(
              bloc: charactersBloc..add(const FindCharactersEvent()),
              builder: (context, state) {
                if (state is ErrorLoadingCharacters) {
                  return Column(
                    children: [
                      const CenteredText(text: "Error fetching characters"),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          charactersBloc.add(const FindCharactersEvent());
                        },
                        child: const Text("Retry"),
                      ),
                    ],
                  );
                }

                final isLoading = state is LoadingCharacters;
                final searchIsEmpty = state is NoResultsFound;
                final isLoadingMore = state is LoadingMoreCharacters;

                if (isLoading) {
                  return const Expanded(
                      child: CharacterGridPlaceholder(itemCount: 10));
                }
                if (searchIsEmpty) {
                  return const CenteredText(
                      text: "No results found. Please try again.");
                }

                return Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Loaded ${state.model.characters.length} of ${state.model.totalElements} characters',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Expanded(
                        child: CharacterGrid(
                          characters: state.model.characters,
                          onTap: (Character character) {
                            FocusScope.of(context).unfocus();
                            Navigator.push(
                              context,
                              CharacterDetailPage.route(character),
                            );
                          },
                          onEndOfList: (void value) {
                            charactersBloc.add(const LoadMoreCharactersEvent());
                          },
                          isLoadingMore: isLoadingMore,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
