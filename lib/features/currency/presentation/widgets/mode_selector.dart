import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/currency_entity.dart';
import '../bloc/currency_bloc.dart';
import '../bloc/currency_event.dart';
import '../bloc/currency_state.dart';
import '../../../../core/theme/app_colors.dart';

class ModeSelector extends StatelessWidget {
  const ModeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrencyBloc, CurrencyState>(
      buildWhen: (previous, current) => previous.mode != current.mode,
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            gradient: AppColors.cardGradient,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.steelGrey, width: 1),
          ),
          padding: const EdgeInsets.all(4),
          child: SegmentedButton<ConversionMode>(
            segments: const [
              ButtonSegment<ConversionMode>(
                value: ConversionMode.oldToNew,
                label: Text('قديم ← جديد'),
                icon: Icon(Icons.arrow_back),
              ),
              ButtonSegment<ConversionMode>(
                value: ConversionMode.newToOld,
                label: Text('جديد ← قديم'),
                icon: Icon(Icons.arrow_forward),
              ),
              ButtonSegment<ConversionMode>(
                value: ConversionMode.dollarToNewSyp,
                label: Text('دولار ← جديد'),
                icon: Icon(Icons.attach_money),
              ),
            ],
            selected: {state.mode},
            onSelectionChanged: (Set<ConversionMode> selection) {
              context.read<CurrencyBloc>().add(ChangeModeEvent(selection.first));
            },
            showSelectedIcon: false,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return AppColors.accentBlue;
                }
                return Colors.transparent;
              }),
              foregroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return AppColors.whiteText;
                }
                return AppColors.lightSteel;
              }),
              side: WidgetStateProperty.all(BorderSide.none),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
