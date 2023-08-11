import 'package:marvel_universe/core/usecases/usecase.dart';
import 'package:marvel_universe/features/characters/domain/entities/character.dart';
import 'package:marvel_universe/features/characters/domain/repositories/marvel_repository.dart';

class FindCharacters extends UseCase<List<Character>, FindCharactersParams> {
  final MarvelRepository repository;

  FindCharacters(this.repository);

  @override
  Future<List<Character>> execute(FindCharactersParams params) async {
    return await repository.findCharacters(limit: params.limit);
  }
}

class FindCharactersParams {
  final int limit;
  FindCharactersParams(this.limit);
}
