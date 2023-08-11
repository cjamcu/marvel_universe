import '../entities/character.dart';

abstract class MarvelRepository {
  Future<List<Character> > findCharacters({required int limit});
}

