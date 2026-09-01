import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:forui/forui.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_header.dart';

class MarkdownPage extends StatelessWidget {
  const MarkdownPage({
    required this.title,
    required this.assetPath,
    super.key,
  });

  final String title;
  final String assetPath;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return FScaffold(
      header: PokaHeader(
        title: title,
        showBack: true,
      ),
      child: FutureBuilder<String>(
        future: rootBundle
            .loadString(assetPath)
            .catchError(
              (_) => rootBundle.loadString('packages/poka_ce/$assetPath'),
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
          return Markdown(
            data: content,
            styleSheet: MarkdownStyleSheet(
              h1: theme.typography.display.lg.copyWith(color: theme.colors.foreground, fontWeight: FontWeight.bold),
              h2: theme.typography.display.md.copyWith(color: theme.colors.foreground, fontWeight: FontWeight.w600),
              h3: theme.typography.display.sm.copyWith(color: theme.colors.foreground, fontWeight: FontWeight.w600),
              h4: theme.typography.body.sm.copyWith(color: theme.colors.foreground, fontWeight: FontWeight.w600),
              h5: theme.typography.body.xs.copyWith(color: theme.colors.foreground, fontWeight: FontWeight.w600),
              h6: theme.typography.body.xs.copyWith(color: theme.colors.foreground, fontWeight: FontWeight.w600),
              p: theme.typography.body.sm.copyWith(color: theme.colors.mutedForeground, height: 1.6),
              listBullet: theme.typography.body.sm.copyWith(color: theme.colors.mutedForeground),
              a: theme.typography.body.sm.copyWith(color: theme.colors.primary, fontWeight: FontWeight.w600),
              strong: theme.typography.body.sm.copyWith(color: theme.colors.foreground, fontWeight: FontWeight.w700),
              em: theme.typography.body.sm.copyWith(color: theme.colors.mutedForeground, fontStyle: FontStyle.italic),
              pPadding: const EdgeInsets.only(bottom: 8),
              h1Padding: const EdgeInsets.only(top: 16, bottom: 4),
              h2Padding: const EdgeInsets.only(top: 16, bottom: 4),
              h3Padding: const EdgeInsets.only(top: 12, bottom: 2),
              h4Padding: const EdgeInsets.only(top: 12, bottom: 2),
              h5Padding: const EdgeInsets.only(top: 12, bottom: 2),
              h6Padding: const EdgeInsets.only(top: 12, bottom: 2),
              listIndent: 24,
              blockquote: theme.typography.body.sm.copyWith(
                color: theme.colors.mutedForeground,
                fontStyle: FontStyle.italic,
              ),
              blockquoteDecoration: BoxDecoration(
                border: Border(left: BorderSide(color: theme.colors.border, width: 4)),
              ),
              blockquotePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          );
        },
      ),
    );
  }
}
