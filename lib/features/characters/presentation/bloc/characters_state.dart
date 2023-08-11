part of 'characters_bloc.dart';

abstract class CharactersState extends Equatable {
  final Model model;

  const CharactersState(this.model);

  @override
  List<Object> get props => [model];
}

class CharactersInitial extends CharactersState {
  final Model model;

  const CharactersInitial(this.model) : super(model);

  @override
  List<Object> get props => [model];
}

class LoadingCharacters extends CharactersState {
  final Model model;

  const LoadingCharacters(this.model) : super(model);

  @override
  List<Object> get props => [];
}

class LoadedCharacters extends CharactersState {
  final Model model;

  const LoadedCharacters(this.model) : super(model);

  @override
  List<Object> get props => [];
}

class ErrorLoadingCharacters extends CharactersState {
  final Model model;

  const ErrorLoadingCharacters(this.model) : super(model);

  @override
  List<Object> get props => [];
}

class Model extends Equatable {
  final List<Character> characters;
  final int totalPages;
  final int page;

  const Model({
    this.characters = const <Character>[],
    this.page = 0,
    this.totalPages = 0,
  });

  Model copyWith({
    List<Character>? characters,
    int? totalPages,
    int? page,
  }) {
    return Model(
      characters: characters ?? this.characters,
      totalPages: totalPages ?? this.totalPages,
      page: page ?? this.page,
    );
  }

  @override
  List<Object?> get props => [characters, totalPages, page];
}
