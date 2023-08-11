import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_universe/features/characters/data/models/characters_model.dart';

import 'package:marvel_universe/features/characters/domain/entities/character.dart';

void main() {
  late CharactersModel result;

  setUp(() {
    final jsonString = File('test/fixtures/characters.json').readAsStringSync();
    final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
    result = CharactersModel.fromJson(jsonMap);
  });

  test(
    'should be a subclass of Character entity',
    () async {
      expect(result.data.results[0], isA<Character>());
    },
  );

  group('fromJson', () {
    test('CharactersModel should be parsed correctly', () async {
      expect(result, isA<CharactersModel>());
    });

    test(
      'data results should be parsed as CharacterModel and '
      'a subclass of Character entity',
      () async {
        expect(result.data.results[0], isA<CharacterModel>());
        expect(result.data.results[0], isA<Character>());
      },
    );
  });
}
