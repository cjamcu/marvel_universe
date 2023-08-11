import 'dart:convert';

import 'package:marvel_universe/core/usecases/marvel_hash_generator.dart';
import 'package:marvel_universe/features/characters/data/models/characters_response.dart';
import 'package:marvel_universe/features/characters/domain/entities/character.dart';
import 'package:marvel_universe/features/characters/domain/repositories/marvel_repository.dart';
import 'package:http/http.dart' as http;

class MarvelRepositoryImpl implements MarvelRepository {
  final http.Client client;
  final MarvelHashGenerator marvelHashGenerator;
  final String marvelPublicKey;
  final String marvelPrivateKey;

  MarvelRepositoryImpl({
    required this.client,
    required this.marvelHashGenerator,
    required this.marvelPublicKey,
    required this.marvelPrivateKey,
  });

  final baseUrl = 'https://gateway.marvel.com:443/v1/public/';

  @override
  Future<CharactersInfo> findCharacters({
    required int page,
    String? name,
  }) async {
    const limit = 10;
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
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

    final response = await http.get(uri);
    final data = jsonDecode(response.body);

    final charactersResponse = CharactersResponse.fromJson(data);
    return CharactersInfo(
      characters: charactersResponse.data.results,
      totalElements: charactersResponse.data.total,
      totalPages: (charactersResponse.data.total / limit).ceil(),
    );
  }
}
