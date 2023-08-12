part of 'characters_bloc.dart';

abstract class CharactersEvent extends Equatable {
  const CharactersEvent();
}

class FindCharactersEvent extends CharactersEvent {
  final String timestamp;
  final int limit;

  const FindCharactersEvent({required this.timestamp, this.limit = 10});

  @override
  List<Object?> get props => [];
}

class SearchCharactersByNameEvent extends CharactersEvent {
  final String name;
  final String timestamp;
  final int limit;

  const SearchCharactersByNameEvent({
    required this.name,
    required this.timestamp,
    this.limit = 10,
  });

  @override
  List<Object?> get props => [name];
}

class LoadMoreCharactersEvent extends CharactersEvent {
  final String timestamp;
  final int limit;

  const LoadMoreCharactersEvent({required this.timestamp, required this.limit});

  @override
  List<Object?> get props => [];
}
