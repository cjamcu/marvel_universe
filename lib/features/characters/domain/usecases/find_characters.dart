import 'package:equatable/equatable.dart';
import 'package:marvel_universe/core/usecases/usecase.dart';
import 'package:marvel_universe/features/characters/domain/entities/character.dart';
import 'package:marvel_universe/features/characters/domain/repositories/marvel_repository.dart';

class FindCharacters extends UseCase<CharactersInfo, FindCharactersParams> {
  final MarvelRepository repository;

  FindCharacters(this.repository);

  @override
  Future<CharactersInfo> execute(FindCharactersParams params) async {
    return await repository.findCharacters(
      page: params.page,
      name: params.name,
      timestamp: params.timestamp,
      limit: params.limit,
    );
  }
}

class FindCharactersParams extends Equatable {
  final int page;
  final String? name;
  final String timestamp;
  final int limit;

  const FindCharactersParams({
    this.page = 0,
    this.name,
    required this.timestamp,
    this.limit = 10,
  });

  @override
  List<Object?> get props => [page, name, timestamp];
}
