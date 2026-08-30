import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/extensions/string_extension.dart';
import 'package:poka_ce/features/settings/presentation/controllers/settings_notifier.dart';
import 'package:poka_ce/theme/theme.dart';

class TransactionAmountDisplay extends ConsumerWidget {
  const TransactionAmountDisplay({
    required this.amountExpression,
    this.historyExpression,
    this.currencyCode,
    super.key,
  });

  final String amountExpression;
  final String? currencyCode;

  /// Optional evaluated expression rendered as a muted history line under the
  /// result (e.g. "= 1+2+3+4"), so users can see what produced the amount.
  final String? historyExpression;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final localeFormat = ref.watch(settingsProvider).settings?.numberFormat ?? 'system';

    final raw = amountExpression.isEmpty ? '0' : amountExpression;

    final spans = <InlineSpan>[];
    final regex = RegExp(r'(\d+(?:\.\d*)?)|([+\-*/])');
    final matches = regex.allMatches(raw);

    for (final match in matches) {
      final text = match.group(0)!;
      if (text == '+' || text == '-' || text == '*' || text == '/') {
        IconData icon;
        if (text == '+') {
          icon = FPhosphorIcons.plus;
        } else if (text == '-') {
          icon = FPhosphorIcons.minus;
        } else if (text == '*') {
          icon = FPhosphorIcons.x;
        } else {
          icon = FPhosphorIcons.divide;
        }
        spans.add(
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Icon(
                icon,
                size: 24,
                color: theme.colors.foreground,
              ),
            ),
          ),
        );
      } else {
        spans.add(TextSpan(text: text.formatAsNumber(localeFormat: localeFormat)));
      }
    }

    if (currencyCode != null) {
      var startsWithOperator = false;
      if (matches.isNotEmpty) {
        final firstText = matches.first.group(0)!;
        if (firstText == '+' || firstText == '-') {
          startsWithOperator = true;
        }
      }

      if (startsWithOperator) {
        spans.insert(1, TextSpan(text: '$currencyCode '));
      } else {
        spans.insert(0, TextSpan(text: '$currencyCode '));
      }
    }

    return Padding(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: theme.typography.display.xl2.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colors.foreground,
              height: 1,
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerRight,
              child: Text.rich(
                TextSpan(children: spans),
                textAlign: TextAlign.end,
              ),
            ),
          ),
          SizedBox(
            height: 18,
            child: historyExpression != null && historyExpression!.isNotEmpty
                ? Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '= ${historyExpression!.formatMathExpression(localeFormat: localeFormat)}',
                      style: theme.typography.bodyPrimary.copyWith(
                        color: theme.colors.mutedForeground,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.end,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                : null,
          ),
          const FDivider(),
        ],
      ),
    );
  }
}
