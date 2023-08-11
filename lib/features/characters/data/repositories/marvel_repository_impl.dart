import 'package:marvel_universe/features/characters/data/datasources/marvel_remote_data_source.dart';
import 'package:marvel_universe/features/characters/domain/entities/character.dart';
import 'package:marvel_universe/features/characters/domain/repositories/marvel_repository.dart';

class MarvelRepositoryImpl implements MarvelRepository {
  final MarvelRemoteDataSource marvelRemoteDataSource;

  MarvelRepositoryImpl({
    required this.marvelRemoteDataSource,
  });

  @override
  Future<CharactersInfo> findCharacters({
    required int page,
    required String timestamp,
    String? name,
  }) async {
    return await marvelRemoteDataSource.findCharacters(
        page: page, timestamp: timestamp, name: name);
  }
}
