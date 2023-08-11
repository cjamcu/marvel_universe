import 'dart:convert';

import 'package:http/http.dart';
import 'package:marvel_universe/core/usecases/marvel_hash_generator.dart';
import 'package:marvel_universe/features/characters/data/models/characters_model.dart';
import 'package:marvel_universe/features/characters/domain/entities/character.dart';

abstract class MarvelRemoteDataSource {
  Future<CharactersInfo> findCharacters({
    required int page,
    required String timestamp,
    String? name,
  });
}

class MarvelRemoteDataSourceImpl implements MarvelRemoteDataSource {
  final Client client;
  final MarvelHashGenerator marvelHashGenerator;
  final String marvelPublicKey;
  final String marvelPrivateKey;

  MarvelRemoteDataSourceImpl({
    required this.client,
    required this.marvelHashGenerator,
    required this.marvelPublicKey,
    required this.marvelPrivateKey,
  });

  @override
  Future<CharactersInfo> findCharacters({
    required int page,
    required String timestamp,
    String? name,
  }) async {
    const limit = 10;
    final offset = page * limit;
    final marvelHashGeneratorParams = MarvelHashGeneratorParams(
      timestamp: timestamp,
      publicKey: marvelPublicKey,
      privateKey: marvelPrivateKey,
    );

    final marvelHash =
        await marvelHashGenerator.execute(marvelHashGeneratorParams);

    final params = {
      'apikey': marvelPublicKey,
      'ts': timestamp.toString(),
      'hash': marvelHash,
      'limit': limit.toString(),
      'offset': offset.toString(),
      if ((name ?? '').isNotEmpty) 'nameStartsWith': name,
    };

    final Uri uri =
        Uri.https('gateway.marvel.com', '/v1/public/characters', params);

    final response = await client.get(uri);
    final data = jsonDecode(response.body);

    final charactersResponse = CharactersModel.fromJson(data);
    return CharactersInfo(
      characters: charactersResponse.data.results,
      totalElements: charactersResponse.data.total,
      totalPages: (charactersResponse.data.total / limit).ceil(),
    );
  }
}
