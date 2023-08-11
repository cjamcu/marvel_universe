part of 'characters_bloc.dart';

abstract class CharactersEvent extends Equatable {
  const CharactersEvent();
}

class FindCharactersEvent extends CharactersEvent {
  const FindCharactersEvent();

  @override
  List<Object?> get props => [];
}

class SearchCharactersByNameEvent extends CharactersEvent {
  final String name;

  const SearchCharactersByNameEvent(this.name);

  @override
  List<Object?> get props => [name];
}

class LoadMoreCharactersEvent extends CharactersEvent {
  const LoadMoreCharactersEvent();

  @override
  List<Object?> get props => [];
}