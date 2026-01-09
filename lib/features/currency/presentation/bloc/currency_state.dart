import 'package:equatable/equatable.dart';
import '../../domain/entities/currency_entity.dart';

class CurrencyState extends Equatable {
  final ConversionMode mode;
  final String inputText;
  final double oldAmount;
  final double newAmount;
  final double dollarAmount;
  final double exchangeRate;
  final List<BreakdownItem> breakdown;
  final List<BreakdownItem> oldBreakdown;
  final String? warning;
  final List<int> selectedDenominations;
  final List<int> selectedOldDenominations;

  const CurrencyState({
    this.mode = ConversionMode.oldToNew,
    this.inputText = '',
    this.oldAmount = 0,
    this.newAmount = 0,
    this.dollarAmount = 0,
    this.exchangeRate = 120,
    this.breakdown = const [],
    this.oldBreakdown = const [],
    this.warning,
    this.selectedDenominations = const [500, 200, 100, 50, 25, 10],
    this.selectedOldDenominations = const [5000, 2000, 1000, 500],
  });

  CurrencyState copyWith({
    ConversionMode? mode,
    String? inputText,
    double? oldAmount,
    double? newAmount,
    double? dollarAmount,
    double? exchangeRate,
    List<BreakdownItem>? breakdown,
    List<BreakdownItem>? oldBreakdown,
    String? warning,
    bool clearWarning = false,
    List<int>? selectedDenominations,
    List<int>? selectedOldDenominations,
  }) {
    return CurrencyState(
      mode: mode ?? this.mode,
      inputText: inputText ?? this.inputText,
      oldAmount: oldAmount ?? this.oldAmount,
      newAmount: newAmount ?? this.newAmount,
      dollarAmount: dollarAmount ?? this.dollarAmount,
      exchangeRate: exchangeRate ?? this.exchangeRate,
      breakdown: breakdown ?? this.breakdown,
      oldBreakdown: oldBreakdown ?? this.oldBreakdown,
      warning: clearWarning ? null : (warning ?? this.warning),
      selectedDenominations: selectedDenominations ?? this.selectedDenominations,
      selectedOldDenominations: selectedOldDenominations ?? this.selectedOldDenominations,
    );
  }

  @override
  List<Object?> get props => [
        mode,
        inputText,
        oldAmount,
        newAmount,
        dollarAmount,
        exchangeRate,
        breakdown,
        oldBreakdown,
        warning,
        selectedDenominations,
        selectedOldDenominations
      ];
}
