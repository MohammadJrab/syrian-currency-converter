import 'package:equatable/equatable.dart';
import '../../domain/entities/currency_entity.dart';

class CurrencyState extends Equatable {
  final ConversionMode mode;
  final String inputText;
  final double oldAmount;
  final double newAmount;
  final List<BreakdownItem> breakdown;
  final String? warning;

  const CurrencyState({
    this.mode = ConversionMode.oldToNew,
    this.inputText = '',
    this.oldAmount = 0,
    this.newAmount = 0,
    this.breakdown = const [],
    this.warning,
  });

  CurrencyState copyWith({
    ConversionMode? mode,
    String? inputText,
    double? oldAmount,
    double? newAmount,
    List<BreakdownItem>? breakdown,
    String? warning,
    bool clearWarning = false,
  }) {
    return CurrencyState(
      mode: mode ?? this.mode,
      inputText: inputText ?? this.inputText,
      oldAmount: oldAmount ?? this.oldAmount,
      newAmount: newAmount ?? this.newAmount,
      breakdown: breakdown ?? this.breakdown,
      warning: clearWarning ? null : (warning ?? this.warning),
    );
  }

  @override
  List<Object?> get props => [mode, inputText, oldAmount, newAmount, breakdown, warning];
}
