import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/app/router/router.dart';
import 'package:poka_ce/features/settings/domain/currency_model.dart';
import 'package:poka_ce/features/settings/presentation/controllers/settings_notifier.dart';
import 'package:poka_ce/features/settings/presentation/widgets/currency_search_list.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_header.dart';
import 'package:poka_ce/theme/theme.dart';

class OnboardingPage extends HookConsumerWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final selectedCurrency = useState<CurrencyModel?>(null);

    final availableCurrenciesFuture = useFuture(
      useMemoized(() => ref.read(settingsProvider.notifier).getAvailableCurrencies()),
    );
    final currencies = availableCurrenciesFuture.data ?? <CurrencyModel>[];

    return FScaffold(
      header: PokaHeader(
        title: t.onboarding.chooseYourBaseCurrency,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FCard(
            child: Padding(
              padding: EdgeInsets.all(theme.style.app.lg),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: theme.colors.primary.withValues(alpha: 0.12),
                      borderRadius: theme.style.borderRadius.lg,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(theme.style.app.sm),
                      child: Icon(
                        FPhosphorIcons.currencyCircleDollar,
                        color: theme.colors.primary,
                        size: 24,
                      ),
                    ),
                  ),
                  SizedBox(width: theme.style.app.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.onboarding.chooseYourBaseCurrency,
                          style: theme.typography.titleCard,
                        ),
                        SizedBox(height: theme.style.app.xs),
                        Text(
                          t
                              .onboarding
                              .thisCurrencyWillBeUsedForAllAccountsPocketsAndTransactionsYouCanChangeThisLaterInSettings,
                          style: context.theme.typography.bodyPrimary.copyWith(color: theme.colors.mutedForeground),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: CurrencySearchList(
              currencies: currencies,
              selectedCurrency: selectedCurrency.value,
              onSelect: (currency) => selectedCurrency.value = currency,
            ),
          ),
          const SizedBox(height: 12),
          FButton(
            onPress: selectedCurrency.value == null
                ? null
                : () async {
                    await ref.read(settingsProvider.notifier).setBaseCurrency(selectedCurrency.value!.id);
                    if (context.mounted) {
                      const DashboardRoute().go(context);
                    }
                  },
            child: Text(t.onboarding.continueWithCurrency),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
