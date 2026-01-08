import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/currency_local_datasource.dart';
import '../../data/repositories/currency_repository_impl.dart';
import '../../domain/usecases/convert_currency_usecase.dart';
import '../bloc/currency_bloc.dart';
import '../widgets/mode_selector.dart';
import '../widgets/input_card.dart';
import '../widgets/result_card.dart';
import '../widgets/breakdown_card.dart';
import '../widgets/warning_card.dart';
import '../widgets/exchange_rate_input.dart';
import '../../../../core/theme/app_colors.dart';

class CurrencyPage extends StatelessWidget {
  const CurrencyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final dataSource = CurrencyLocalDataSource();
        final repository = CurrencyRepositoryImpl(dataSource);
        final useCase = ConvertCurrencyUseCase(repository);
        return CurrencyBloc(convertCurrencyUseCase: useCase);
      },
      child: const CurrencyPageContent(),
    );
  }
}

class CurrencyPageContent extends StatelessWidget {
  const CurrencyPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.appBarGradient,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.currency_exchange,
                  color: AppColors.accentGold,
                  size: 28,
                ),
                const SizedBox(width: 12),
                const Text(
                  'محول الليرة السورية',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteText,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.metalGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                ModeSelector(),
                SizedBox(height: 20),
                ExchangeRateInput(),
                SizedBox(height: 20),
                InputCard(),
                SizedBox(height: 20),
                WarningCard(),
                SizedBox(height: 20),
                ResultCard(),
                SizedBox(height: 20),
                BreakdownCard(),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
