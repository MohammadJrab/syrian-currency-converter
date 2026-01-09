import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/currency_entity.dart';
import '../../domain/usecases/convert_currency_usecase.dart';
import 'currency_event.dart';
import 'currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  final ConvertCurrencyUseCase convertCurrencyUseCase;

  CurrencyBloc({required this.convertCurrencyUseCase}) : super(const CurrencyState()) {
    on<ChangeInputEvent>(_onChangeInput);
    on<ChangeModeEvent>(_onChangeMode);
    on<ClearEvent>(_onClear);
    on<ChangeExchangeRateEvent>(_onChangeExchangeRate);
    on<ChangeDenominationsEvent>(_onChangeDenominations);
    on<ChangeOldDenominationsEvent>(_onChangeOldDenominations);
  }

  void _onChangeInput(ChangeInputEvent event, Emitter<CurrencyState> emit) {
    final inputText = event.inputText;

    if (inputText.isEmpty) {
      emit(state.copyWith(
        inputText: '',
        oldAmount: 0,
        newAmount: 0,
        breakdown: [],
        clearWarning: true,
      ));
      return;
    }

    final inputAmount = double.tryParse(inputText);
    if (inputAmount == null || inputAmount < 0) {
      emit(state.copyWith(
        inputText: inputText,
        oldAmount: 0,
        newAmount: 0,
        breakdown: [],
        warning: 'الرجاء إدخال رقم صحيح',
      ));
      return;
    }

    final result = convertCurrencyUseCase(
      inputAmount: inputAmount,
      mode: state.mode,
      exchangeRate: state.exchangeRate,
      selectedDenominations: state.selectedDenominations,
      selectedOldDenominations: state.selectedOldDenominations,
    );

    emit(state.copyWith(
      inputText: inputText,
      oldAmount: result.oldAmount,
      newAmount: result.newAmount,
      dollarAmount: state.mode == ConversionMode.dollarToNewSyp ? inputAmount : 0,
      breakdown: result.breakdown,
      oldBreakdown: result.oldBreakdown,
      warning: result.warning,
      clearWarning: result.warning == null,
    ));
  }

  void _onChangeMode(ChangeModeEvent event, Emitter<CurrencyState> emit) {
    if (state.inputText.isEmpty) {
      emit(state.copyWith(mode: event.mode));
      return;
    }

    final inputAmount = double.tryParse(state.inputText);
    if (inputAmount == null || inputAmount < 0) {
      emit(state.copyWith(mode: event.mode));
      return;
    }

    final result = convertCurrencyUseCase(
      inputAmount: inputAmount,
      mode: event.mode,
      exchangeRate: state.exchangeRate,
      selectedDenominations: state.selectedDenominations,
      selectedOldDenominations: state.selectedOldDenominations,
    );

    emit(state.copyWith(
      mode: event.mode,
      oldAmount: result.oldAmount,
      newAmount: result.newAmount,
      dollarAmount: event.mode == ConversionMode.dollarToNewSyp ? inputAmount : 0,
      breakdown: result.breakdown,
      oldBreakdown: result.oldBreakdown,
      warning: result.warning,
      clearWarning: result.warning == null,
    ));
  }

  void _onClear(ClearEvent event, Emitter<CurrencyState> emit) {
    emit(const CurrencyState());
  }

  void _onChangeExchangeRate(ChangeExchangeRateEvent event, Emitter<CurrencyState> emit) {
    final rateText = event.rateText;

    if (rateText.isEmpty) {
      emit(state.copyWith(exchangeRate: 120));
      return;
    }

    final rate = double.tryParse(rateText);
    if (rate == null || rate <= 0) {
      return; // Invalid rate, don't update
    }

    emit(state.copyWith(exchangeRate: rate));

    // Re-run conversion if there's existing input in dollar mode
    if (state.inputText.isNotEmpty && state.mode == ConversionMode.dollarToNewSyp) {
      final inputAmount = double.tryParse(state.inputText);
      if (inputAmount != null && inputAmount >= 0) {
        final result = convertCurrencyUseCase(
          inputAmount: inputAmount,
          mode: state.mode,
          exchangeRate: rate,
          selectedDenominations: state.selectedDenominations,
        );

        emit(state.copyWith(
          oldAmount: result.oldAmount,
          newAmount: result.newAmount,
          dollarAmount: inputAmount,
          breakdown: result.breakdown,
          warning: result.warning,
          clearWarning: result.warning == null,
        ));
      }
    }
  }

  void _onChangeDenominations(ChangeDenominationsEvent event, Emitter<CurrencyState> emit) {
    // Update selected denominations
    emit(state.copyWith(selectedDenominations: event.denominations));

    // Re-run conversion if there's existing input
    if (state.inputText.isNotEmpty) {
      final inputAmount = double.tryParse(state.inputText);
      if (inputAmount != null && inputAmount >= 0) {
        final result = convertCurrencyUseCase(
          inputAmount: inputAmount,
          mode: state.mode,
          exchangeRate: state.exchangeRate,
          selectedDenominations: event.denominations,
        );

        emit(state.copyWith(
          oldAmount: result.oldAmount,
          newAmount: result.newAmount,
          breakdown: result.breakdown,
          warning: result.warning,
          clearWarning: result.warning == null,
        ));
      }
    }
  }

  void _onChangeOldDenominations(ChangeOldDenominationsEvent event, Emitter<CurrencyState> emit) {
    // Update selected old denominations
    emit(state.copyWith(selectedOldDenominations: event.denominations));

    // Re-run conversion if there's existing input
    if (state.inputText.isNotEmpty) {
      final inputAmount = double.tryParse(state.inputText);
      if (inputAmount != null && inputAmount >= 0) {
        final result = convertCurrencyUseCase(
          inputAmount: inputAmount,
          mode: state.mode,
          exchangeRate: state.exchangeRate,
          selectedDenominations: state.selectedDenominations,
          selectedOldDenominations: event.denominations,
        );

        emit(state.copyWith(
          oldAmount: result.oldAmount,
          newAmount: result.newAmount,
          breakdown: result.breakdown,
          oldBreakdown: result.oldBreakdown,
          warning: result.warning,
          clearWarning: result.warning == null,
        ));
      }
    }
  }
}
