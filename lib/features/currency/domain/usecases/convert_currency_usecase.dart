import '../entities/currency_entity.dart';
import '../repositories/currency_repository.dart';

class ConvertCurrencyUseCase {
  final CurrencyRepository repository;

  ConvertCurrencyUseCase(this.repository);

  CurrencyConversionResult call({
    required double inputAmount,
    required ConversionMode mode,
    double exchangeRate = 120,
  }) {
    return repository.convert(
      inputAmount: inputAmount,
      mode: mode,
      exchangeRate: exchangeRate,
    );
  }
}
