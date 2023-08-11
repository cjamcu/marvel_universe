part of 'characters_bloc.dart';

abstract class CharactersEvent extends Equatable {
  const CharactersEvent();
}

class FindCharactersEvent extends CharactersEvent {
  const FindCharactersEvent();

  @override
  List<Object?> get props => [];
}
