import '../../domain/entities/currency_entity.dart';

class CurrencyLocalDataSource {
  static const List<int> denominations = [500, 200, 100, 50, 25, 10];

  static const Map<int, String> denominationImages = {
    10: 'assets/images/10-lira.png',
    25: 'assets/images/25-lira.jpg',
    50: 'assets/images/50-lira.jpg',
    100: 'assets/images/100-lira.jpg',
    200: 'assets/images/200-lira.jpg',
    500: 'assets/images/500-lira.jpg',
  };

  double convertOldToNew(double oldAmount) {
    return oldAmount / 100;
  }

  double convertNewToOld(double newAmount) {
    return newAmount * 100;
  }

  List<BreakdownItem> calculateBreakdown(double newAmount) {
    final List<BreakdownItem> result = [];
    int remainingAmount = newAmount.floor();

    for (final denom in denominations) {
      if (remainingAmount >= denom) {
        final count = remainingAmount ~/ denom;
        remainingAmount = remainingAmount % denom;

        result.add(BreakdownItem(
          denomination: denom,
          count: count,
          imagePath: denominationImages[denom]!,
        ));
      }
    }

    return result;
  }

  double calculateRemainder(double newAmount) {
    int remainingAmount = newAmount.floor();

    for (final denom in denominations) {
      if (remainingAmount >= denom) {
        remainingAmount = remainingAmount % denom;
      }
    }

    final fractionalPart = newAmount - newAmount.floor();
    return remainingAmount + fractionalPart;
  }
}
