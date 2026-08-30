import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:poka_ce/features/settings/domain/currency_model.dart';
import 'package:poka_ce/features/settings/presentation/widgets/currency_search_list.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/sheets/poka_sheet.dart';

Future<CurrencyModel?> showCurrencyPickerSheet(
  BuildContext context,
  List<CurrencyModel> currencies,
  CurrencyModel? currentCurrency,
) async {
  return showPokaSheet<CurrencyModel>(
    context: context,
    builder: (context) => _CurrencyPickerSheet(
      currencies: currencies,
      currentCurrency: currentCurrency,
    ),
  );
}

class _CurrencyPickerSheet extends HookWidget {
  const _CurrencyPickerSheet({
    required this.currencies,
    this.currentCurrency,
  });

  final List<CurrencyModel> currencies;
  final CurrencyModel? currentCurrency;

  @override
  Widget build(BuildContext context) {
    return PokaSheet(
      title: t.settings.selectCurrency,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: CurrencySearchList(
              currencies: currencies,
              selectedCurrency: currentCurrency,
              onSelect: (currency) {
                Navigator.of(context).pop(currency);
              },
            ),
          ),
        ],
      ),
    );
  }
}
