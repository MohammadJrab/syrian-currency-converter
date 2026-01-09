import '../../domain/entities/currency_entity.dart';

class CurrencyLocalDataSource {
  static const List<int> denominations = [500, 200, 100, 50, 25, 10];
  static const List<int> oldDenominations = [5000, 2000, 1000, 500];

  static const Map<int, String> denominationImages = {
    10: 'assets/images/10-lira.png',
    25: 'assets/images/25-lira.jpg',
    50: 'assets/images/50-lira.jpg',
    100: 'assets/images/100-lira.jpg',
    200: 'assets/images/200-lira.jpg',
    500: 'assets/images/500-lira.jpg',
  };

  static const Map<int, String> oldDenominationImages = {
    500: 'assets/images/old-500-sp.jpg',
    1000: 'assets/images/old-1000-sp.jpg',
    2000: 'assets/images/old-2000-sp.jpg',
    5000: 'assets/images/old-5000-sp.jpg',
  };

  double convertOldToNew(double oldAmount) {
    return oldAmount / 100;
  }

  double convertNewToOld(double newAmount) {
    return newAmount * 100;
  }

  static const double defaultUsdToNewSypRate = 120;

  double convertDollarToNewSyp(double dollarAmount, [double? exchangeRate]) {
    final rate = exchangeRate ?? defaultUsdToNewSypRate;
    return dollarAmount * rate;
  }

  List<BreakdownItem> calculateBreakdown(double newAmount, [List<int>? selectedDenominations]) {
    final List<BreakdownItem> result = [];
    int remainingAmount = newAmount.floor();

    // Use selected denominations or all denominations
    final availableDenoms = selectedDenominations ?? denominations;

    // Sort in descending order to ensure largest denominations first
    final sortedDenoms = List<int>.from(availableDenoms)..sort((a, b) => b.compareTo(a));

    for (final denom in sortedDenoms) {
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

  double calculateRemainder(double newAmount, [List<int>? selectedDenominations]) {
    int remainingAmount = newAmount.floor();

    // Use selected denominations or all denominations
    final availableDenoms = selectedDenominations ?? denominations;

    // Sort in descending order
    final sortedDenoms = List<int>.from(availableDenoms)..sort((a, b) => b.compareTo(a));

    for (final denom in sortedDenoms) {
      if (remainingAmount >= denom) {
        remainingAmount = remainingAmount % denom;
      }
    }

    final fractionalPart = newAmount - newAmount.floor();
    return remainingAmount + fractionalPart;
  }

  List<BreakdownItem> calculateOldBreakdown(double oldAmount, [List<int>? selectedOldDenominations]) {
    final List<BreakdownItem> result = [];
    int remainingAmount = oldAmount.floor();

    // Use selected denominations or all old denominations
    final availableDenoms = selectedOldDenominations ?? oldDenominations;

    // Sort in descending order to ensure largest denominations first
    final sortedDenoms = List<int>.from(availableDenoms)..sort((a, b) => b.compareTo(a));

    for (final denom in sortedDenoms) {
      if (remainingAmount >= denom) {
        final count = remainingAmount ~/ denom;
        remainingAmount = remainingAmount % denom;

        result.add(BreakdownItem(
          denomination: denom,
          count: count,
          imagePath: oldDenominationImages[denom]!,
        ));
      }
    }

    return result;
  }

  double calculateOldRemainder(double oldAmount, [List<int>? selectedOldDenominations]) {
    int remainingAmount = oldAmount.floor();

    // Use selected denominations or all old denominations
    final availableDenoms = selectedOldDenominations ?? oldDenominations;

    // Sort in descending order
    final sortedDenoms = List<int>.from(availableDenoms)..sort((a, b) => b.compareTo(a));

    for (final denom in sortedDenoms) {
      if (remainingAmount >= denom) {
        remainingAmount = remainingAmount % denom;
      }
    }

    final fractionalPart = oldAmount - oldAmount.floor();
    return remainingAmount + fractionalPart;
  }
}
