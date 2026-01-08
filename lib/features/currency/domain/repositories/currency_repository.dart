import '../entities/currency_entity.dart';

abstract class CurrencyRepository {
  CurrencyConversionResult convert({
    required double inputAmount,
    required ConversionMode mode,
  });

  List<BreakdownItem> breakdown(double newAmount);
}
