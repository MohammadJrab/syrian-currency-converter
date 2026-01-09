import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/currency_bloc.dart';
import '../bloc/currency_event.dart';
import '../bloc/currency_state.dart';
import '../../domain/entities/currency_entity.dart';
import '../../../../core/theme/app_colors.dart';

class OldDenominationSelector extends StatelessWidget {
  const OldDenominationSelector({super.key});

  static const List<int> allOldDenominations = [5000, 2000, 1000, 500];

  static const Map<int, String> oldDenominationImages = {
    500: 'assets/images/old-500-sp.jpg',
    1000: 'assets/images/old-1000-sp.jpg',
    2000: 'assets/images/old-2000-sp.jpg',
    5000: 'assets/images/old-5000-sp.jpg',
  };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrencyBloc, CurrencyState>(
      builder: (context, state) {
        // إظهار فقط عند التحويل إلى العملة القديمة
        if (state.mode != ConversionMode.newToOld) {
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
                    Icons.account_balance,
                    color: AppColors.accentGold,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'الفئات القديمة المتوفرة',
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
                children: allOldDenominations.map((denom) {
                  final isSelected = state.selectedOldDenominations.contains(denom);

                  return InkWell(
                    onTap: () {
                      final newDenominations = List<int>.from(state.selectedOldDenominations);
                      if (isSelected) {
                        newDenominations.remove(denom);
                      } else {
                        newDenominations.add(denom);
                      }

                      // Sort in descending order
                      newDenominations.sort((a, b) => b.compareTo(a));

                      context.read<CurrencyBloc>().add(
                            ChangeOldDenominationsEvent(newDenominations),
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
                            '$denom ل.س.ق',
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
