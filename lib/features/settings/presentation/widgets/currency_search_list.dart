import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:poka_ce/features/settings/domain/currency_model.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_menu_group_card.dart';
import 'package:poka_ce/theme/theme.dart';

class CurrencySearchList extends HookWidget {
  const CurrencySearchList({
    required this.currencies,
    required this.onSelect,
    super.key,
    this.selectedCurrency,
  });

  final List<CurrencyModel> currencies;
  final CurrencyModel? selectedCurrency;
  final ValueChanged<CurrencyModel> onSelect;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final searchController = useTextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FTextField(
          hint: t.settings.search,
          clearable: (value) => value.text.isNotEmpty,
          control: FTextFieldControl.managed(
            controller: searchController,
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: HookBuilder(
            builder: (context) {
              useListenable(searchController);
              final query = searchController.text.toLowerCase();

              final filteredCurrencies = currencies.where((c) {
                return c.name.toLowerCase().contains(query) || c.code.toLowerCase().contains(query);
              }).toList();

              if (filteredCurrencies.isEmpty) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(theme.style.app.lg),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: theme.colors.primary.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Icon(
                              FPhosphorIcons.magnifyingGlass,
                              size: 32,
                              color: theme.colors.primary,
                            ),
                          ),
                        ),
                        SizedBox(height: theme.style.app.md),
                        Text(
                          t.settings.noResultsFound,
                          style: theme.typography.titleCard,
                        ),
                        SizedBox(height: theme.style.app.xs),
                        Text(
                          t.settings.weCouldntFindAnyCurrencyMatching,
                          style: theme.typography.bodyPrimary.copyWith(
                            color: theme.colors.mutedForeground,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }

              return PokaMenuGroupCard(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: filteredCurrencies.length,
                  itemBuilder: (context, index) {
                    final currency = filteredCurrencies[index];
                    return FItem(
                      prefix: _CurrencySymbol(
                        symbol: currency.symbol,
                        selected: currency.code == selectedCurrency?.code,
                      ),
                      title: Text(currency.code),
                      subtitle: Text(currency.name),
                      suffix: currency.code == selectedCurrency?.code
                          ? Icon(FPhosphorIcons.check, color: theme.colors.primary)
                          : null,
                      onPress: () => onSelect(currency),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Displays a compact currency symbol and selected state.
class _CurrencySymbol extends StatelessWidget {
  const _CurrencySymbol({required this.symbol, required this.selected});

  final String symbol;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final accentColor = selected ? theme.colors.primary : theme.colors.mutedForeground;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: theme.style.app.iconBgOpacity),
        borderRadius: theme.style.borderRadius.md,
      ),
      child: Padding(
        padding: EdgeInsets.all(theme.style.app.sm),
        child: SizedBox(
          width: 20,
          height: 20,
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                symbol,
                maxLines: 1,
                style: theme.typography.bodyPrimary.copyWith(
                  color: accentColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
