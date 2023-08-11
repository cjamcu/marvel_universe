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
  List<Object> get props => [model];
}

class LoadedCharacters extends CharactersState {
  final Model model;

  const LoadedCharacters(this.model) : super(model);

  @override
  List<Object> get props => [model];
}

class ErrorLoadingCharacters extends CharactersState {
  final Model model;

  const ErrorLoadingCharacters(this.model) : super(model);

  @override
  List<Object> get props => [model];
}

class SearchingCharacters extends CharactersState {
  final Model model;

  const SearchingCharacters(this.model) : super(model);

  @override
  List<Object> get props => [model];
}

class NoResultsFound extends CharactersState {
  final Model model;

  const NoResultsFound(this.model) : super(model);

  @override
  List<Object> get props => [model];
}

class LoadingMoreCharacters extends CharactersState {
  final Model model;

  const LoadingMoreCharacters(this.model) : super(model);

  @override
  List<Object> get props => [model];
}


class Model extends Equatable {
  final List<Character> characters;
  final int totalPages;
  final int totalElements;
  final int page;
  final String searchQuery;

  const Model({
    this.characters = const <Character>[],
    this.page = 0,
    this.totalPages = 1,
    this.totalElements = 0,
    this.searchQuery = '',
  });

  Model copyWith({
    List<Character>? characters,
    int? totalPages,
    int? totalElements,
    int? page,
    String? searchQuery,
  }) {
    return Model(
      characters: characters ?? this.characters,
      totalPages: totalPages ?? this.totalPages,
      totalElements: totalElements ?? this.totalElements,
      page: page ?? this.page,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [characters, totalPages, page];
}


