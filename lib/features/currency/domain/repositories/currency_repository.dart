import '../entities/currency_entity.dart';

abstract class CurrencyRepository {
  CurrencyConversionResult convert({
    required double inputAmount,
    required ConversionMode mode,
    double exchangeRate = 120,
    List<int> selectedDenominations = const [500, 200, 100, 50, 25, 10],
    List<int> selectedOldDenominations = const [5000, 2000, 1000, 500],
  });

  List<BreakdownItem> breakdown(double newAmount,
      {List<int> selectedDenominations = const [500, 200, 100, 50, 25, 10]});
}
