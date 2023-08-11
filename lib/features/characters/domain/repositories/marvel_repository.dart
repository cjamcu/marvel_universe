import '../entities/character.dart';

abstract class MarvelRepository {
  Future<CharactersInfo> findCharacters({
    required int page,
    String? name,
  });
}
