import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_header.dart';
import 'package:poka_ce/theme/theme.dart';

class FaqItem {
  FaqItem(this.question, this.answer);

  final String question;
  final String answer;
}

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return FScaffold(
      header: PokaHeader(
        title: t.settings.faq,
        showBack: true,
      ),
      child: FutureBuilder<String>(
        future: rootBundle
            .loadString('assets/data/faq.md')
            .catchError(
              (_) => rootBundle.loadString('packages/poka_ce/assets/data/faq.md'),
            ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: FCircularProgress());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                t.settings.errorLoadingContent,
                style: theme.typography.body.lg,
              ),
            );
          }

          final content = snapshot.data ?? '';
          final items = _parseFaq(content);

          return SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: theme.colors.primary.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          FPhosphorIcons.question,
                          size: 48,
                          color: theme.colors.primary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        t.settings.faq,
                        style: theme.typography.display.sm.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colors.foreground,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        t.settings.faqDesc,
                        style: theme.typography.bodyPrimary.copyWith(
                          color: theme.colors.mutedForeground,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const FDivider(),
                FAccordion(
                  children: items.map((item) {
                    return FAccordionItem(
                      title: Text(
                        item.question,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      child: MarkdownBody(
                        data: item.answer,
                        styleSheet: MarkdownStyleSheet(
                          p: theme.typography.bodyPrimary.copyWith(color: theme.colors.mutedForeground, height: 1.6),
                          listBullet: theme.typography.bodyPrimary.copyWith(color: theme.colors.mutedForeground),
                          strong: theme.typography.bodyPrimary.copyWith(
                            color: theme.colors.foreground,
                            fontWeight: FontWeight.bold,
                          ),
                          pPadding: const EdgeInsets.only(bottom: 8),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  List<FaqItem> _parseFaq(String content) {
    final items = <FaqItem>[];
    final parts = content.split(RegExp(r'(?:^|\n)##\s+'));
    for (final part in parts) {
      if (part.trim().isEmpty) continue;
      final lines = part.split('\n');
      final question = lines.first.trim();
      final answer = lines.skip(1).join('\n').trim();
      items.add(FaqItem(question, answer));
    }
    return items;
  }
}
