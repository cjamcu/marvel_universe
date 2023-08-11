import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:marvel_universe/features/characters/domain/entities/character.dart';
import 'package:marvel_universe/features/characters/domain/usecases/find_characters.dart';

part 'characters_event.dart';

part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final FindCharacters findCharacters;

  CharactersBloc(this.findCharacters)
      : super(const CharactersInitial(Model())) {
    on<FindCharactersEvent>(_onFindCharactersEvent);
  }

  Future<FutureOr<void>> _onFindCharactersEvent(
      FindCharactersEvent event, Emitter<CharactersState> emit) async {
    try {
      emit(LoadingCharacters(state.model));
      final params = FindCharactersParams(10);
      final characters = await findCharacters.execute(params);
      emit(LoadedCharacters(state.model.copyWith(characters: characters)));
    } catch (e) {
      emit(ErrorLoadingCharacters(state.model));
    }
  }
}
