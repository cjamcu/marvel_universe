import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_universe/features/characters/domain/entities/character.dart';
import 'package:marvel_universe/features/characters/domain/usecases/find_characters.dart';
import 'package:marvel_universe/features/characters/presentation/bloc/characters_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockFindCharacters extends Mock implements FindCharacters {}

void main() {
  group('CharactersBloc', () {
    late CharactersBloc charactersBloc;
    late Model model;
    late MockFindCharacters findCharacters;

    setUp(() {
      findCharacters = MockFindCharacters();
      charactersBloc = CharactersBloc(findCharacters);
      model = const Model();
    });

    test('initial state is CharactersInitial', () {
      expect(charactersBloc.state, const CharactersInitial(Model()));
    });
    const charactersInfo = CharactersInfo(
      characters: [
        Character(
          id: 1,
          name: '',
          image: '',
        )
      ],
      totalElements: 1,
      totalPages: 1,
    );

    blocTest<CharactersBloc, CharactersState>(
      '''
     emits LoadingCharacters and LoadedCharacters 
     when FindCharactersEvent is added''',
      build: () => charactersBloc,
      act: (bloc) {
        final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
        final params = FindCharactersParams(timestamp: timestamp);

        when(() => findCharacters.execute(params)).thenAnswer(
          (_) async => charactersInfo,
        );

        bloc.add(FindCharactersEvent(timestamp: timestamp));
      },
      expect: () => [
        const LoadingCharacters(Model()),
        LoadedCharacters(
          model.copyWith(
              characters: charactersInfo.characters,
              totalPages: 1,
              totalElements: 1,
              page: 0),
        ),
      ],
    );
    blocTest<CharactersBloc, CharactersState>(
      '''
    emits LoadingCharacters and NoResultsFound when 
    SearchCharactersByNameEvent yields empty results''',
      build: () => charactersBloc,
      act: (bloc) {
        final timestamp = DateTime.now().millisecondsSinceEpoch.toString();

        final params = FindCharactersParams(timestamp: timestamp, name: 'abc');

        when(() => findCharacters.execute(params)).thenAnswer(
          (_) async => const CharactersInfo(
            characters: [],
            totalElements: 0,
            totalPages: 0,
          ),
        );

        bloc.add(
            SearchCharactersByNameEvent(timestamp: timestamp, name: 'abc'));
      },
      expect: () => [
        LoadingCharacters(model.copyWith(
            searchQuery: '', page: 0, totalElements: 0, totalPages: 1)),
        const NoResultsFound(Model()),
      ],
    );

    blocTest<CharactersBloc, CharactersState>(
      '''
emits LoadingMoreCharacters and LoadedCharacters 
when LoadMoreCharactersEvent is added''',
      build: () => charactersBloc,
      act: (bloc) {
        final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
        const charactersInfo = CharactersInfo(
          characters: [
            Character(
              id: 2,
              name: 'Character 2',
              image: 'image_url_2',
            ),
          ],
          totalElements: 2,
          totalPages: 2,
        );
        registerFallbackValue(
            FindCharactersParams(timestamp: timestamp, limit: 0));
        when(() => findCharacters.execute(any())).thenAnswer(
          (_) async => charactersInfo,
        );

        bloc.add(LoadMoreCharactersEvent(timestamp: timestamp, limit: 0));
      },
      expect: () => [
        const LoadingMoreCharacters(Model()),
        LoadedCharacters(
          model.copyWith(
            characters: [
              const Character(id: 2, name: 'Character 2', image: 'image_url_2'),
            ],
            page: 1,
            totalPages: 2,
            totalElements: 2,
          ),
        ),
      ],
    );

    blocTest<CharactersBloc, CharactersState>(
      '''
      emits LoadingCharacters and ErrorLoadingCharacters when 
      FindCharactersEvent throws an error''',
      build: () => charactersBloc,
      act: (bloc) {
        final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
        final params = FindCharactersParams(timestamp: timestamp, name: 'abc');
        when(() => findCharacters.execute(params))
            .thenThrow(Exception('Test error'));

        bloc.add(FindCharactersEvent(timestamp: timestamp));
      },
      expect: () => [
        const LoadingCharacters(Model()),
        const ErrorLoadingCharacters(Model()),
      ],
    );
  });
}
