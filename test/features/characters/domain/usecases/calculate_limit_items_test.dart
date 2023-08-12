import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_universe/features/characters/domain/usecases/calculate_limit_items.dart';


void main() {
  group('CalculateLimitItems', () {
    late CalculateLimitItems calculateLimitItems;

    setUp(() {
      calculateLimitItems = CalculateLimitItems();
    });

    test('should return 50 items for desktop', () {
      const params = CalculateLimitItemsParams(screenWidth: 1200);
      final result = calculateLimitItems.execute(params);
      expect(result, 50);
    });

    test('should return 20 items for tablet', () {
      const params = CalculateLimitItemsParams(screenWidth: 800);
      final result = calculateLimitItems.execute(params);
      expect(result, 20);
    });

    test('should return 10 items for mobile', () {
      const params = CalculateLimitItemsParams(screenWidth: 600);
      final result = calculateLimitItems.execute(params);
      expect(result, 10);
    });
  });
}
