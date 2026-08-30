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
        future: rootBundle.loadString(assetPath),
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
              h1: theme.typography.display.sm.copyWith(color: theme.colors.foreground, fontWeight: FontWeight.bold),
              h2: theme.typography.display.xs.copyWith(color: theme.colors.foreground, fontWeight: FontWeight.w600),
              h3: theme.typography.body.lg.copyWith(color: theme.colors.foreground, fontWeight: FontWeight.w600),
              p: theme.typography.body.md.copyWith(color: theme.colors.mutedForeground, height: 1.6),
              listBullet: theme.typography.body.md.copyWith(color: theme.colors.mutedForeground),
              a: theme.typography.body.md.copyWith(color: theme.colors.primary, fontWeight: FontWeight.w600),
              strong: theme.typography.body.md.copyWith(color: theme.colors.foreground, fontWeight: FontWeight.bold),
              pPadding: const EdgeInsets.only(bottom: 12),
              listIndent: 24,
            ),
          );
        },
      ),
    );
  }
}
