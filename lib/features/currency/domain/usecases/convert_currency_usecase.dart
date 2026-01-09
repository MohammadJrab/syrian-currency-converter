import '../entities/currency_entity.dart';
import '../repositories/currency_repository.dart';

class ConvertCurrencyUseCase {
  final CurrencyRepository repository;

  ConvertCurrencyUseCase(this.repository);

  CurrencyConversionResult call({
    required double inputAmount,
    required ConversionMode mode,
    double exchangeRate = 120,
    List<int> selectedDenominations = const [500, 200, 100, 50, 25, 10],
    List<int> selectedOldDenominations = const [5000, 2000, 1000, 500],
  }) {
    return repository.convert(
      inputAmount: inputAmount,
      mode: mode,
      exchangeRate: exchangeRate,
      selectedDenominations: selectedDenominations,
      selectedOldDenominations: selectedOldDenominations,
    );
  }
}
