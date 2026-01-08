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
    );

    emit(state.copyWith(
      inputText: inputText,
      oldAmount: result.oldAmount,
      newAmount: result.newAmount,
      breakdown: result.breakdown,
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
    );

    emit(state.copyWith(
      mode: event.mode,
      oldAmount: result.oldAmount,
      newAmount: result.newAmount,
      breakdown: result.breakdown,
      warning: result.warning,
      clearWarning: result.warning == null,
    ));
  }

  void _onClear(ClearEvent event, Emitter<CurrencyState> emit) {
    emit(const CurrencyState());
  }
}
