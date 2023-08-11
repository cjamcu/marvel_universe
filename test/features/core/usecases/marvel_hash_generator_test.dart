import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_universe/core/usecases/marvel_hash_generator.dart';

void main() {
  test('Should generate Marvel hash correctly', () async {
    const expectedResult = '411ab03b7f9c2a01c73c63e6127b4604';

    const MarvelHashGeneratorParams marvelHashGeneratorParams =
        MarvelHashGeneratorParams(
      timestamp: '1691792837597',
      publicKey: 'publicKey',
      privateKey: 'privateKey',
    );

    final result =
        await MarvelHashGenerator().execute(marvelHashGeneratorParams);

    expect(result, expectedResult);
  });
}
