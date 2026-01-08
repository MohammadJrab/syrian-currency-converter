import '../entities/currency_entity.dart';

abstract class CurrencyRepository {
  CurrencyConversionResult convert({
    required double inputAmount,
    required ConversionMode mode,
    double exchangeRate = 15000.0,
  });

  List<BreakdownItem> breakdown(double newAmount);
}
