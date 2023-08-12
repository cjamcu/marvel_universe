import '../entities/character.dart';

abstract class MarvelRepository {
  Future<CharactersInfo> findCharacters({
    required int page,
    required String timestamp,
    String? name,
    required int limit,
  });
}
