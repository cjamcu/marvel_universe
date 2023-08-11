import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

import 'package:http/http.dart' as http;
import 'package:marvel_universe/core/usecases/marvel_hash_generator.dart';
import 'package:marvel_universe/features/characters/data/datasources/marvel_remote_data_source.dart';
import 'package:marvel_universe/features/characters/domain/entities/character.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockMarvelHashGenerator extends Mock implements MarvelHashGenerator {}

void main() {
  late MockHttpClient mockHttpClient;
  late String jsonString;
  late MarvelHashGenerator marvelHashGenerator;

  setUp(() {
    jsonString = File('test/fixtures/characters.json').readAsStringSync();
    mockHttpClient = MockHttpClient();
    marvelHashGenerator = MockMarvelHashGenerator();
  });

  test("Find Characters", () async {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    const marvelHash = 'hash';

    final paramsUri = {
      'apikey': '',
      'ts': timestamp.toString(),
      'hash': marvelHash,
      'limit': 10.toString(),
      'offset': 0.toString(),
    };
    final uri =
        Uri.https('gateway.marvel.com', '/v1/public/characters', paramsUri);
    final params = MarvelHashGeneratorParams(
      timestamp: timestamp,
      publicKey: '',
      privateKey: '',
    );

    when(() => marvelHashGenerator.execute(params)).thenAnswer(
      (_) async => marvelHash,
    );

    when(() => mockHttpClient.get(uri))
        .thenAnswer((_) async => http.Response(jsonString, 200));

    final repository = MarvelRemoteDataSourceImpl(
      client: mockHttpClient,
      marvelHashGenerator: marvelHashGenerator,
      marvelPublicKey: '',
      marvelPrivateKey: '',
    );

    final result =
        await repository.findCharacters(page: 0, timestamp: timestamp);

    expect(result, isA<CharactersInfo>());
  });
}
