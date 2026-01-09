import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/currency_bloc.dart';
import '../bloc/currency_event.dart';
import '../bloc/currency_state.dart';
import '../../domain/entities/currency_entity.dart';
import '../../../../core/theme/app_colors.dart';

class DenominationSelector extends StatelessWidget {
  const DenominationSelector({super.key});

  static const List<int> allDenominations = [500, 200, 100, 50, 25, 10];

  static const Map<int, String> denominationImages = {
    10: 'assets/images/10-lira.png',
    25: 'assets/images/25-lira.jpg',
    50: 'assets/images/50-lira.jpg',
    100: 'assets/images/100-lira.jpg',
    200: 'assets/images/200-lira.jpg',
    500: 'assets/images/500-lira.jpg',
  };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrencyBloc, CurrencyState>(
      builder: (context, state) {
        // إظهار فقط عند التحويل إلى العملة الجديدة
        if (state.mode == ConversionMode.newToOld) {
          return const SizedBox.shrink();
        }

        return Container(
          decoration: BoxDecoration(
            gradient: AppColors.cardGradient,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.accentGold.withOpacity(0.1),
                blurRadius: 15,
                spreadRadius: 1,
                offset: const Offset(0, 5),
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
                    Icons.account_balance_wallet,
                    color: AppColors.accentGold,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'الفئات المتوفرة',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.whiteText,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: allDenominations.map((denom) {
                  final isSelected = state.selectedDenominations.contains(denom);

                  return InkWell(
                    onTap: () {
                      final newDenominations = List<int>.from(state.selectedDenominations);
                      if (isSelected) {
                        newDenominations.remove(denom);
                      } else {
                        newDenominations.add(denom);
                      }

                      // Sort in descending order
                      newDenominations.sort((a, b) => b.compareTo(a));

                      context.read<CurrencyBloc>().add(
                            ChangeDenominationsEvent(newDenominations),
                          );
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        gradient: isSelected
                            ? LinearGradient(
                                colors: [
                                  AppColors.accentGold.withOpacity(0.8),
                                  AppColors.accentGold.withOpacity(0.6),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : LinearGradient(
                                colors: [
                                  AppColors.darkSurface.withOpacity(0.5),
                                  AppColors.darkSurface.withOpacity(0.3),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? AppColors.accentGold : AppColors.whiteText.withOpacity(0.2),
                          width: 2,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (isSelected)
                            Icon(
                              Icons.check_circle,
                              color: AppColors.darkBackground,
                              size: 20,
                            ),
                          if (isSelected) const SizedBox(width: 6),
                          Text(
                            '$denom ل.س',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? AppColors.darkBackground : AppColors.whiteText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
