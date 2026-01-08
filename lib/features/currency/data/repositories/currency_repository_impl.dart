import '../../domain/entities/currency_entity.dart';
import '../../domain/repositories/currency_repository.dart';
import '../datasources/currency_local_datasource.dart';

class CurrencyRepositoryImpl implements CurrencyRepository {
  final CurrencyLocalDataSource dataSource;

  CurrencyRepositoryImpl(this.dataSource);

  @override
  CurrencyConversionResult convert({
    required double inputAmount,
    required ConversionMode mode,
    double exchangeRate = 15000.0,
  }) {
    double oldAmount;
    double newAmount;

    if (mode == ConversionMode.oldToNew) {
      oldAmount = inputAmount;
      newAmount = dataSource.convertOldToNew(inputAmount);
    } else if (mode == ConversionMode.newToOld) {
      newAmount = inputAmount;
      oldAmount = dataSource.convertNewToOld(inputAmount);
    } else {
      // dollarToNewSyp mode
      oldAmount = 0; // Not applicable for dollar conversion
      newAmount = dataSource.convertDollarToNewSyp(inputAmount, exchangeRate);
    }

    final breakdownList = dataSource.calculateBreakdown(newAmount);
    final remainder = dataSource.calculateRemainder(newAmount);

    String? warning;
    if (remainder > 0) {
      warning = 'يوجد باقي غير قابل للتفكيك: $remainder ليرة جديدة';
    }

    return CurrencyConversionResult(
      oldAmount: oldAmount,
      newAmount: newAmount,
      breakdown: breakdownList,
      remainder: remainder,
      warning: warning,
    );
  }

  @override
  List<BreakdownItem> breakdown(double newAmount) {
    return dataSource.calculateBreakdown(newAmount);
  }
}
