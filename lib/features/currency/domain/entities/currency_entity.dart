import 'package:equatable/equatable.dart';

enum ConversionMode { oldToNew, newToOld }

class BreakdownItem extends Equatable {
  final int denomination;
  final int count;
  final String imagePath;

  const BreakdownItem({
    required this.denomination,
    required this.count,
    required this.imagePath,
  });

  @override
  List<Object?> get props => [denomination, count, imagePath];
}

class CurrencyConversionResult extends Equatable {
  final double oldAmount;
  final double newAmount;
  final List<BreakdownItem> breakdown;
  final double remainder;
  final String? warning;

  const CurrencyConversionResult({
    required this.oldAmount,
    required this.newAmount,
    required this.breakdown,
    required this.remainder,
    this.warning,
  });

  @override
  List<Object?> get props => [oldAmount, newAmount, breakdown, remainder, warning];
}
