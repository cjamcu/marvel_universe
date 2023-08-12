part of 'characters_bloc.dart';

abstract class CharactersState extends Equatable {
  final Model model;

  const CharactersState(this.model);

  @override
  List<Object> get props => [model];
}

class CharactersInitial extends CharactersState {
  const CharactersInitial(Model model) : super(model);
}

class LoadingCharacters extends CharactersState {
  const LoadingCharacters(Model model) : super(model);
}

class LoadedCharacters extends CharactersState {
  const LoadedCharacters(Model model) : super(model);
}

class ErrorLoadingCharacters extends CharactersState {
  const ErrorLoadingCharacters(Model model) : super(model);
}

class SearchingCharacters extends CharactersState {
  const SearchingCharacters(Model model) : super(model);
}

class NoResultsFound extends CharactersState {
  const NoResultsFound(Model model) : super(model);
}

class LoadingMoreCharacters extends CharactersState {
  const LoadingMoreCharacters(Model model) : super(model);
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
