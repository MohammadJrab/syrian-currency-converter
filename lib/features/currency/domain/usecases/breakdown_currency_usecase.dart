import '../entities/currency_entity.dart';
import '../repositories/currency_repository.dart';

class BreakdownCurrencyUseCase {
  final CurrencyRepository repository;

  BreakdownCurrencyUseCase(this.repository);

  List<BreakdownItem> call(double newAmount) {
    return repository.breakdown(newAmount);
  }
}
