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
    on<SearchCharactersByNameEvent>(_onSearchCharactersByNameEvent);
    on<LoadMoreCharactersEvent>(_onLoadMoreCharactersEvent);
  }

  Future<void> _onFindCharactersEvent(
    FindCharactersEvent event,
    Emitter<CharactersState> emit,
  ) async {
    emit(LoadingCharacters(state.model));

    try {
      final charactersResponse = await _fetchCharacters(FindCharactersParams());
      emit(_createLoadedCharactersState(charactersResponse));
    } catch (_) {
      _emitErrorState(emit);
    }
  }

  Future<void> _onSearchCharactersByNameEvent(
    SearchCharactersByNameEvent event,
    Emitter<CharactersState> emit,
  ) async {
    try {
      emit(LoadingCharacters(
        state.model.copyWith(searchQuery: event.name, page: 0),
      ));

      final charactersResponse = await _fetchCharacters(
          FindCharactersParams(name: event.name, page: state.model.page));

      if (charactersResponse.characters.isEmpty) {
        emit(NoResultsFound(state.model));
      } else {
        emit(_createLoadedCharactersState(charactersResponse));
      }
    } catch (_) {
      _emitErrorState(emit);
    }
  }

  Future<FutureOr<void>> _onLoadMoreCharactersEvent(
    LoadMoreCharactersEvent event,
    Emitter<CharactersState> emit,
  ) async {
    // If page is already the last one, do nothing
    if (state.model.page >= state.model.totalPages) {
      return 0;
    }

    emit(LoadingMoreCharacters(state.model));

    try {
      final charactersResponse = await _fetchCharacters(
        FindCharactersParams(
          name: state.model.searchQuery,
          page: state.model.page + 1,
        ),
      );

      emit(LoadedCharacters(state.model.copyWith(
        characters: state.model.characters + charactersResponse.characters,
        page: state.model.page + 1,
        totalPages: charactersResponse.totalPages,
        totalElements: charactersResponse.totalElements,
      )));
    } catch (_) {
      _emitErrorState(emit);
    }
  }

  Future<CharactersInfo> _fetchCharacters(
    FindCharactersParams params,
  ) async {
    return await findCharacters.execute(params);
  }

  void _emitErrorState(Emitter<CharactersState> emit) {
    emit(ErrorLoadingCharacters(state.model));
  }

  LoadedCharacters _createLoadedCharactersState(
      CharactersInfo charactersResponse) {
    return LoadedCharacters(state.model.copyWith(
      characters: charactersResponse.characters,
      totalPages: charactersResponse.totalPages,
      totalElements: charactersResponse.totalElements,
    ));
  }
}
