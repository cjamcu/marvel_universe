import 'package:get_it/get_it.dart';
import 'package:marvel_universe/features/characters/data/repositories/marvel_repository_impl.dart';
import 'package:marvel_universe/features/characters/domain/repositories/marvel_repository.dart';
import 'package:marvel_universe/features/characters/domain/usecases/find_characters.dart';
import 'package:marvel_universe/features/characters/presentation/bloc/characters_bloc.dart';
import 'package:http/http.dart' as http;
final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerFactory(() => CharactersBloc(getIt()));

  getIt.registerLazySingleton(() => FindCharacters(getIt()));
  getIt.registerLazySingleton<MarvelRepository>(() => MarvelRepositoryImpl(getIt()));
  getIt.registerLazySingleton(() => http.Client());

}
