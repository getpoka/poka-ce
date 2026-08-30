import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/shared/widgets/poka_header.dart';
import 'package:poka_ce/theme/theme.dart';

/// Known license names keyed by their identifying substring, ordered
/// most-specific first so longer phrases win over short overlaps.
const List<(String, String)> _licenseNames = [
  ('GNU AFFERO GENERAL PUBLIC LICENSE', 'GNU AGPL'),
  ('GNU LESSER GENERAL PUBLIC LICENSE', 'GNU LGPL'),
  ('GNU GENERAL PUBLIC LICENSE', 'GNU GPL'),
  ('Mozilla Public License', 'Mozilla Public License (MPL)'),
  ('Eclipse Public License', 'Eclipse Public License (EPL)'),
  ('Creative Commons', 'Creative Commons (CC)'),
  ('The Apache Software License', 'Apache License 2.0'),
  ('Apache License', 'Apache License 2.0'),
  ('Simplified BSD', 'Simplified BSD License'),
  ('New BSD', 'New BSD License'),
  ('Boost Software License', 'Boost Software License'),
  ('ISC License', 'ISC License'),
  ('zlib License', 'zlib License'),
  ('Artistic License', 'Artistic License'),
  ('BSD', 'BSD License'),
  ('MIT License', 'MIT License'),
  ('DO WHAT THE FUCK YOU WANT', 'WTFPL'),
  ('The Unlicense', 'The Unlicense'),
  ('unencumbered software', 'The Unlicense'),
];

/// Represents the Open Source Licenses screen.
///
/// Lists every license registered via [LicenseRegistry] grouped by package,
/// so a package with several distinct license texts (e.g. the ANGLE engine
/// library) appears as a single collapsible card instead of many cards.
///
/// Long texts stay collapsed to keep the screen scannable, and the default
/// "Powered by Flutter" footer is omitted.
class LicensesScreen extends StatelessWidget {
  /// Creates a [LicensesScreen].
  const LicensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return FScaffold(
      header: PokaHeader(
        title: t.settings.openSourceLicenses,
        showBack: true,
      ),
      child: FutureBuilder<List<LicenseEntry>>(
        future: LicenseRegistry.licenses.toList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: FCircularProgress());
          }

          final licenses = snapshot.data ?? const <LicenseEntry>[];
          if (licenses.isEmpty) {
            return Center(
              child: Text(
                t.settings.noLicensesFound,
                style: theme.typography.bodyPrimary.copyWith(
                  color: theme.colors.mutedForeground,
                ),
              ),
            );
          }

          // Group entries by package, keeping only distinct license texts per
          // package so identical texts are never shown twice.
          final byPackage = <String, List<_LicenseText>>{};
          for (final entry in licenses) {
            final text = _licenseText(entry);
            for (final pkg in entry.packages) {
              final list = byPackage.putIfAbsent(pkg, () => []);
              if (!list.any((t) => t.text == text.text)) {
                list.add(text);
              }
            }
          }

          final packages = byPackage.keys.toList()..sort();

          return ListView.separated(
            padding: EdgeInsets.symmetric(vertical: theme.style.app.lg),
            itemCount: packages.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final package = packages[index];
              return _LicenseTile(
                package: package,
                texts: byPackage[package]!,
              );
            },
          );
        },
      ),
    );
  }
}

/// A distinct license text together with its detected license name.
class _LicenseText {
  const _LicenseText({required this.name, required this.text});

  /// Detected license name (e.g. "BSD License"), empty when unknown.
  final String name;

  /// Full normalized license text.
  final String text;
}

/// Normalizes a license entry and detects its license name.
_LicenseText _licenseText(LicenseEntry entry) {
  final text = entry.paragraphs.map((p) => p.text).join('\n\n').trim();
  var name = '';
  for (final (pattern, label) in _licenseNames) {
    if (text.contains(pattern)) {
      name = label;
      break;
    }
  }
  return _LicenseText(name: name, text: text);
}

/// A collapsible card showing one package and all of its license texts.
///
/// Tapping the header toggles the license bodies via [FCollapsible].
class _LicenseTile extends StatefulWidget {
  /// Creates a [_LicenseTile] for the given [package] and [texts].
  const _LicenseTile({
    required this.package,
    required this.texts,
  });

  /// The package name.
  final String package;

  /// All distinct license texts belonging to this package.
  final List<_LicenseText> texts;

  @override
  State<_LicenseTile> createState() => _LicenseTileState();
}

class _LicenseTileState extends State<_LicenseTile> {
  bool _expanded = false;

  /// Unique license names, used as the collapsed subtitle.
  String _names() {
    final names = widget.texts.map((t) => t.name).where((n) => n.isNotEmpty).toSet();
    if (names.isEmpty) {
      return widget.texts.length > 1 ? '${widget.texts.length} licenses' : '1 license';
    }
    return names.join(' · ');
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final showCount = widget.texts.length > 1;

    return FCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Tappable header with expand/collapse caret ──────────────────
          GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: EdgeInsets.all(theme.style.app.lg),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.package,
                          style: theme.typography.bodyPrimary.copyWith(
                            color: theme.colors.foreground,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _names(),
                          style: theme.typography.bodySecondary.copyWith(
                            color: theme.colors.mutedForeground,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (showCount) ...[
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: theme.style.app.xs,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        '${widget.texts.length}',
                        style: theme.typography.bodySecondary.copyWith(
                          color: theme.colors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  Icon(
                    _expanded ? FPhosphorIcons.caretUp : FPhosphorIcons.caretDown,
                    size: 16,
                    color: theme.colors.mutedForeground,
                  ),
                ],
              ),
            ),
          ),
          // ── Animated collapsible license body ───────────────────────────
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: _expanded ? 1.0 : 0.0),
            duration: const Duration(milliseconds: 280),
            curve: Curves.easeInOut,
            builder: (context, value, child) {
              if (value == 0) return const SizedBox.shrink();
              return FCollapsible(value: value, child: child!);
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                theme.style.app.lg,
                0,
                theme.style.app.lg,
                theme.style.app.lg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < widget.texts.length; i++) ...[
                    if (i > 0) const FDivider(),
                    const SizedBox(height: 8),
                    Text(
                      widget.texts[i].name.isNotEmpty ? widget.texts[i].name : 'License ${i + 1}',
                      style: theme.typography.bodyPrimary.copyWith(
                        color: theme.colors.foreground,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    for (final paragraph in widget.texts[i].text.split('\n\n')) ...[
                      Text(
                        paragraph,
                        style: theme.typography.bodySecondary.copyWith(
                          color: theme.colors.mutedForeground,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
