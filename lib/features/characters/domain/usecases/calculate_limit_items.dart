import 'package:equatable/equatable.dart';
import 'package:marvel_universe/core/usecases/usecase.dart';

class CalculateLimitItems
    implements BaseUseCase<int, CalculateLimitItemsParams> {
  @override
  int execute(CalculateLimitItemsParams params) {
    final screenWidth = params.screenWidth;
    final isDesktop = screenWidth >= 1024;
    final isTablet = screenWidth >= 768 && screenWidth <= 1024;

    var countItems = 10;

    if (isDesktop) {
      countItems = 50;
    }

    if (isTablet) {
      countItems = 20;
    }

    return countItems;
  }
}

class CalculateLimitItemsParams extends Equatable {
  final double screenWidth;

  const CalculateLimitItemsParams({
    required this.screenWidth,
  });

  @override
  List<Object?> get props => [screenWidth];
}
