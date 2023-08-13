import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_universe/features/character_detail/presentation/character_detail_page.dart';
import 'package:marvel_universe/features/characters/domain/entities/character.dart';
import 'package:marvel_universe/features/characters/domain/usecases/calculate_limit_items.dart';
import 'package:marvel_universe/features/characters/presentation/bloc/characters_bloc.dart';
import 'package:marvel_universe/features/characters/presentation/widgets/centered_text.dart';
import 'package:marvel_universe/features/characters/presentation/widgets/characters_grid.dart';
import 'package:marvel_universe/features/characters/presentation/widgets/placeholder/characters_grid_placeholder.dart';
import 'package:marvel_universe/features/characters/presentation/widgets/search_text_field.dart';
import '../../../injection_container.dart';
import 'package:marvel_universe/core/extensions/dimens.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final charactersBloc = getIt<CharactersBloc>();

    final screenWidth = MediaQuery.of(context).size.width;
    final limit = getIt<CalculateLimitItems>()
        .execute(CalculateLimitItemsParams(screenWidth: screenWidth));

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Characters'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchTextField(
              hintText: 'Search by character name',
              onChanged: (value) {
                charactersBloc.add(SearchCharactersByNameEvent(
                    name: value, timestamp: _getTimestamp(), limit: limit));
              },
            ),
            10.height,
            BlocBuilder<CharactersBloc, CharactersState>(
              bloc: charactersBloc
                ..add(FindCharactersEvent(
                    timestamp: _getTimestamp(), limit: limit)),
              builder: (context, state) {
                if (state is ErrorLoadingCharacters) {
                  return Column(
                    children: [
                      const CenteredText(text: "Error fetching characters"),
                      10.height,
                      ElevatedButton(
                        onPressed: () {
                          charactersBloc.add(
                            FindCharactersEvent(
                                timestamp: _getTimestamp(), limit: limit),
                          );
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
                  return Expanded(
                      child: CharactersGridPlaceholder(itemCount: limit));
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
                        '''
Loaded ${state.model.characters.length} of ${state.model.totalElements} characters''',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Expanded(
                        child: CharactersGrid(
                          characters: state.model.characters,
                          onTap: (Character character) {
                            FocusScope.of(context).unfocus();
                            Navigator.push(
                              context,
                              CharacterDetailPage.route(character),
                            );
                          },
                          onEndOfList: (void value) {
                            charactersBloc.add(
                              LoadMoreCharactersEvent(
                                  timestamp: _getTimestamp(), limit: limit),
                            );
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

  String _getTimestamp() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}
