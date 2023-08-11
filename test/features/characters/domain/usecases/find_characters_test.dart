import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:marvel_universe/features/characters/domain/usecases/find_characters.dart';
import 'package:marvel_universe/features/characters/domain/entities/character.dart';
import 'package:marvel_universe/features/characters/domain/repositories/marvel_repository.dart';

class MockMarvelRepository extends Mock implements MarvelRepository {}

void main() {
  late FindCharacters useCase;
  late MockMarvelRepository mockRepository;

  setUp(() {
    mockRepository = MockMarvelRepository();
    useCase = FindCharacters(mockRepository);
  });

  test('should fetch characters from the repository', () async {
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
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final params = FindCharactersParams(timestamp: timestamp);

    when(() => mockRepository.findCharacters(
          page: params.page,
          name: params.name,
          timestamp: timestamp,
        )).thenAnswer((_) async => charactersInfo);

    // Act
    final result = await useCase.execute(params);

    // Assert
    expect(result, equals(charactersInfo));
  });
}
