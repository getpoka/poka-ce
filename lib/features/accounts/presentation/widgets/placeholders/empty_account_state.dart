import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

class EmptyAccountState extends StatelessWidget {
  const EmptyAccountState({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Center(
        child: Column(
          children: [
            Icon(FPhosphorIcons.wallet, size: 48, color: theme.colors.mutedForeground)
                .animate()
                .fade(duration: 300.ms, delay: 100.ms)
                .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1), curve: Curves.easeOutBack),
            const SizedBox(height: 12),
            Text(
              t.accounts.noAccountsYet,
              style: theme.typography.titleScreen.copyWith(color: theme.colors.mutedForeground),
            ).animate().fade(duration: 300.ms, delay: 150.ms).slideY(begin: 0.1, end: 0),
            const SizedBox(height: 8),
            Text(
              t.accounts.tapTheButtonBelowToAddYourFirstAccount,
              textAlign: TextAlign.center,
              style: theme.typography.bodySecondary.copyWith(color: theme.colors.mutedForeground),
            ).animate().fade(duration: 300.ms, delay: 200.ms),
          ],
        ),
      ),
    );
  }
}
