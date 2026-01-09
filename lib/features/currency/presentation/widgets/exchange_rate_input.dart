import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/currency_entity.dart';
import '../bloc/currency_bloc.dart';
import '../bloc/currency_event.dart';
import '../bloc/currency_state.dart';
import '../../../../core/theme/app_colors.dart';

class ExchangeRateInput extends StatefulWidget {
  const ExchangeRateInput({super.key});

  @override
  State<ExchangeRateInput> createState() => _ExchangeRateInputState();
}

class _ExchangeRateInputState extends State<ExchangeRateInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CurrencyBloc, CurrencyState>(
      listenWhen: (previous, current) =>
          previous.mode != current.mode ||
          (previous.exchangeRate != current.exchangeRate && current.mode == ConversionMode.dollarToNewSyp),
      listener: (context, state) {
        if (state.mode == ConversionMode.dollarToNewSyp) {
          // Update controller when exchange rate changes externally
          if (_controller.text.isEmpty || double.tryParse(_controller.text) != state.exchangeRate) {
            _controller.text = state.exchangeRate.toInt().toString();
          }
        }
      },
      buildWhen: (previous, current) => previous.mode != current.mode,
      builder: (context, state) {
        if (state.mode != ConversionMode.dollarToNewSyp) {
          return const SizedBox.shrink();
        }

        return Container(
          decoration: BoxDecoration(
            gradient: AppColors.cardGradient,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.steelGrey, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.currency_exchange_rounded,
                    color: AppColors.accentGold,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'سعر الصرف',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.whiteText,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _controller,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.whiteText,
                      fontWeight: FontWeight.bold,
                    ),
                decoration: InputDecoration(
                  labelText: 'سعر الدولار بالليرة الجديدة',
                  labelStyle: TextStyle(color: AppColors.lightSteel),
                  hintText: '120',
                  hintStyle: TextStyle(color: AppColors.steelGrey),
                  filled: true,
                  fillColor: AppColors.metalGrey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.steelGrey, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.accentBlue, width: 2),
                  ),
                ),
                onChanged: (value) {
                  context.read<CurrencyBloc>().add(ChangeExchangeRateEvent(value));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
