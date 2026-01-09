import 'package:equatable/equatable.dart';
import '../../domain/entities/currency_entity.dart';

abstract class CurrencyEvent extends Equatable {
  const CurrencyEvent();

  @override
  List<Object?> get props => [];
}

class ChangeInputEvent extends CurrencyEvent {
  final String inputText;

  const ChangeInputEvent(this.inputText);

  @override
  List<Object?> get props => [inputText];
}

class ChangeModeEvent extends CurrencyEvent {
  final ConversionMode mode;

  const ChangeModeEvent(this.mode);

  @override
  List<Object?> get props => [mode];
}

class ClearEvent extends CurrencyEvent {
  const ClearEvent();
}

class ChangeExchangeRateEvent extends CurrencyEvent {
  final String rateText;

  const ChangeExchangeRateEvent(this.rateText);

  @override
  List<Object?> get props => [rateText];
}

class ChangeDenominationsEvent extends CurrencyEvent {
  final List<int> denominations;

  const ChangeDenominationsEvent(this.denominations);

  @override
  List<Object?> get props => [denominations];
}

class ChangeOldDenominationsEvent extends CurrencyEvent {
  final List<int> denominations;

  const ChangeOldDenominationsEvent(this.denominations);

  @override
  List<Object?> get props => [denominations];
}
