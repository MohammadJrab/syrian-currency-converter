import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/currency_bloc.dart';
import '../bloc/currency_state.dart';
import '../../domain/entities/currency_entity.dart';
import '../../../../core/theme/app_colors.dart';

class BreakdownCard extends StatelessWidget {
  const BreakdownCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrencyBloc, CurrencyState>(
      builder: (context, state) {
        // إخفاء عند التحويل إلى العملة القديمة (جديد → قديم)
        if (state.mode == ConversionMode.newToOld) {
          return const SizedBox.shrink();
        }

        if (state.breakdown.isEmpty) {
          return const SizedBox.shrink();
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: Container(
            key: ValueKey(state.breakdown.hashCode),
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
                      Icons.account_balance_wallet,
                      color: AppColors.accentGold,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'تفكيك الفئات',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.whiteText,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ...state.breakdown.map((item) => _buildBreakdownItem(context, item)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBreakdownItem(BuildContext context, dynamic item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.metalGrey,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.steelGrey.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              item.imagePath,
              width: 80,
              height: 50,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 80,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.darkCard,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.image_not_supported,
                    color: AppColors.steelGrey,
                    size: 24,
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${item.denomination} ليرة',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.accentGold,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'فئة نقدية',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.lightSteel,
                      ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.accentBlue.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.accentBlue),
            ),
            child: Text(
              '× ${item.count}',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.accentBlue,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
