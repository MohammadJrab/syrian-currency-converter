import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/currency_bloc.dart';
import '../bloc/currency_state.dart';
import '../../../../core/theme/app_colors.dart';

class ResultCard extends StatelessWidget {
  const ResultCard({super.key});

  String _formatNumber(double number) {
    if (number == number.roundToDouble()) {
      return number.toInt().toString();
    }
    return number.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrencyBloc, CurrencyState>(
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.1),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: Container(
            key: ValueKey('${state.oldAmount}_${state.newAmount}'),
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
              children: [
                _buildResultRow(
                  context,
                  'الليرة القديمة',
                  _formatNumber(state.oldAmount),
                  Icons.money_off,
                ),
                const SizedBox(height: 16),
                Container(
                  height: 1,
                  color: AppColors.steelGrey,
                ),
                const SizedBox(height: 16),
                _buildResultRow(
                  context,
                  'الليرة الجديدة',
                  _formatNumber(state.newAmount),
                  Icons.monetization_on,
                  isHighlighted: true,
                ),
                const SizedBox(height: 16),
                _buildCopyButton(context, state),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildResultRow(
    BuildContext context,
    String label,
    String value,
    IconData icon, {
    bool isHighlighted = false,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isHighlighted ? AppColors.accentGold.withValues(alpha: 0.2) : AppColors.metalGrey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: isHighlighted ? AppColors.accentGold : AppColors.lightSteel,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.lightSteel,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: isHighlighted ? AppColors.accentGold : AppColors.whiteText,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCopyButton(BuildContext context, CurrencyState state) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: state.newAmount > 0
            ? () {
                final textToCopy =
                    'القديم: ${_formatNumber(state.oldAmount)} | الجديد: ${_formatNumber(state.newAmount)}';
                Clipboard.setData(ClipboardData(text: textToCopy));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        Icon(Icons.check_circle, color: AppColors.successGreen),
                        const SizedBox(width: 12),
                        const Text('تم نسخ النتيجة'),
                      ],
                    ),
                    backgroundColor: AppColors.darkCard,
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            : null,
        icon: const Icon(Icons.copy),
        label: const Text('نسخ النتيجة'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accentBlue,
          foregroundColor: AppColors.whiteText,
          disabledBackgroundColor: AppColors.metalGrey,
          disabledForegroundColor: AppColors.steelGrey,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
