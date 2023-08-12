import 'package:flutter_test/flutter_test.dart';

import 'package:http/http.dart' as http;
import 'package:marvel_universe/core/usecases/marvel_hash_generator.dart';
import 'package:marvel_universe/features/characters/data/datasources/marvel_remote_data_source.dart';
import 'package:marvel_universe/features/characters/data/repositories/marvel_repository_impl.dart';
import 'package:marvel_universe/features/characters/domain/entities/character.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockMarvelHashGenerator extends Mock implements MarvelHashGenerator {}

class MockMarvelRemoteDataSource extends Mock
    implements MarvelRemoteDataSource {}

void main() {
  late MarvelRemoteDataSource remoteDataSource;

  setUp(() {
    remoteDataSource = MockMarvelRemoteDataSource();
  });

  test("Find Characters", () async {
    when(() =>
        remoteDataSource.findCharacters(
            page: any(named: 'page'),
            timestamp: any(named: 'timestamp'),
            limit: any(named: 'limit'),
            name: any(named: 'name'))).thenAnswer((_) async =>
        const CharactersInfo(totalElements: 1, totalPages: 1, characters: []));

    final repository = MarvelRepositoryImpl(
      marvelRemoteDataSource: remoteDataSource,
    );

    final result =
        await repository.findCharacters(page: 0, timestamp: '', limit: 10);

    expect(result, isA<CharactersInfo>());
  });
}
