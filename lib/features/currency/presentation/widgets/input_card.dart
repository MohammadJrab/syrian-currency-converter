import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/currency_entity.dart';
import '../bloc/currency_bloc.dart';
import '../bloc/currency_event.dart';
import '../bloc/currency_state.dart';
import '../../../../core/theme/app_colors.dart';

class InputCard extends StatefulWidget {
  const InputCard({super.key});

  @override
  State<InputCard> createState() => _InputCardState();
}

class _InputCardState extends State<InputCard> {
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
      listenWhen: (previous, current) => previous.inputText != current.inputText && current.inputText.isEmpty,
      listener: (context, state) {
        if (state.inputText.isEmpty && _controller.text.isNotEmpty) {
          _controller.clear();
        }
      },
      buildWhen: (previous, current) => previous.mode != current.mode,
      builder: (context, state) {
        final labelText = state.mode == ConversionMode.oldToNew ? 'المبلغ بالليرة القديمة' : 'المبلغ بالليرة الجديدة';

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
                    Icons.attach_money,
                    color: AppColors.accentGold,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'أدخل المبلغ',
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
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppColors.whiteText,
                      fontWeight: FontWeight.bold,
                    ),
                decoration: InputDecoration(
                  labelText: labelText,
                  labelStyle: TextStyle(color: AppColors.lightSteel),
                  hintText: '0',
                  hintStyle: TextStyle(color: AppColors.steelGrey),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear, color: AppColors.lightSteel),
                    onPressed: () {
                      _controller.clear();
                      context.read<CurrencyBloc>().add(const ClearEvent());
                    },
                  ),
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
                  context.read<CurrencyBloc>().add(ChangeInputEvent(value));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
