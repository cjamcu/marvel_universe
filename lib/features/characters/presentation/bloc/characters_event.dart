part of 'characters_bloc.dart';

abstract class CharactersEvent extends Equatable {
  const CharactersEvent();
}

class FindCharactersEvent extends CharactersEvent {
  const FindCharactersEvent(this.timestamp);

  final String timestamp;

  @override
  List<Object?> get props => [];
}

class SearchCharactersByNameEvent extends CharactersEvent {
  final String name;
  final String timestamp;

  const SearchCharactersByNameEvent({required this.name, required this.timestamp});

  @override
  List<Object?> get props => [name];
}

class LoadMoreCharactersEvent extends CharactersEvent {
  final String timestamp;

  const LoadMoreCharactersEvent(this.timestamp);

  @override
  List<Object?> get props => [];
}
