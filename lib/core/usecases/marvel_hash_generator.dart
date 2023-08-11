import 'package:crypto/crypto.dart';
import 'dart:convert';

import 'package:marvel_universe/core/usecases/usecase.dart';

class MarvelHashGenerator
    implements UseCase<String, MarvelHashGeneratorParams> {
  @override
  Future<String> execute(MarvelHashGeneratorParams params) async {
    return _generateMarvelHash(
        timestamp: params.timestamp,
        publicKey: params.publicKey,
        privateKey: params.privateKey);
  }

  String _generateMarvelHash({
    required String timestamp,
    required String publicKey,
    required String privateKey,
  }) {
    String input = '$timestamp$privateKey$publicKey';
    var bytes = utf8.encode(input);
    var digest = md5.convert(bytes);
    return digest.toString();
  }
}

class MarvelHashGeneratorParams {
  final String timestamp;
  final String publicKey;
  final String privateKey;

  MarvelHashGeneratorParams(
      {required this.timestamp,
      required this.publicKey,
      required this.privateKey});
}
