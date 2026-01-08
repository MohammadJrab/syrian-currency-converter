import '../../domain/entities/currency_entity.dart';

class BreakdownItemModel extends BreakdownItem {
  const BreakdownItemModel({
    required super.denomination,
    required super.count,
    required super.imagePath,
  });

  factory BreakdownItemModel.fromEntity(BreakdownItem entity) {
    return BreakdownItemModel(
      denomination: entity.denomination,
      count: entity.count,
      imagePath: entity.imagePath,
    );
  }
}

class CurrencyConversionResultModel extends CurrencyConversionResult {
  const CurrencyConversionResultModel({
    required super.oldAmount,
    required super.newAmount,
    required super.breakdown,
    required super.remainder,
    super.warning,
  });

  factory CurrencyConversionResultModel.fromEntity(CurrencyConversionResult entity) {
    return CurrencyConversionResultModel(
      oldAmount: entity.oldAmount,
      newAmount: entity.newAmount,
      breakdown: entity.breakdown,
      remainder: entity.remainder,
      warning: entity.warning,
    );
  }
}
