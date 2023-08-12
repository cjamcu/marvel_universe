import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:marvel_universe/core/usecases/marvel_hash_generator.dart';
import 'package:marvel_universe/features/characters/data/datasources/marvel_remote_data_source.dart';
import 'package:marvel_universe/features/characters/data/repositories/marvel_repository_impl.dart';
import 'package:marvel_universe/features/characters/domain/repositories/marvel_repository.dart';
import 'package:marvel_universe/features/characters/domain/usecases/find_characters.dart';
import 'package:marvel_universe/features/characters/presentation/bloc/characters_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:marvel_universe/features/characters/domain/usecases/calculate_limit_items.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerFactory(() => CharactersBloc(getIt()));

  getIt.registerLazySingleton(() => FindCharacters(getIt()));
  getIt.registerLazySingleton(() => MarvelHashGenerator());
  getIt.registerLazySingleton<MarvelRemoteDataSource>(
      () => MarvelRemoteDataSourceImpl(
            client: getIt(),
            marvelHashGenerator: getIt(),
            marvelPrivateKey: dotenv.env['MARVEL_PRIVATE_KEY'] ?? '',
            marvelPublicKey: dotenv.env['MARVEL_PUBLIC_KEY'] ?? '',
          ));

  getIt.registerLazySingleton<MarvelRepository>(
      () => MarvelRepositoryImpl(marvelRemoteDataSource: getIt()));

  getIt.registerLazySingleton(() => CalculateLimitItems());

  getIt.registerLazySingleton(() => http.Client());
}
