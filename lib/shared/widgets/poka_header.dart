import 'package:flutter/material.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:go_router/go_router.dart';
import 'package:poka_ce/theme/theme.dart';

/// PokaHeader is a custom wrapper around Forui's FHeader.
/// It ensures consistent header usage across Poka CE screens.
class PokaHeader extends StatelessWidget {
  /// Creates a PokaHeader.
  const PokaHeader({
    required this.title,
    this.subtitle,
    this.suffixes = const [],
    this.showBack = false,
    super.key,
  });

  /// The text title of the header.
  final String title;

  /// Optional subtitle to display above the title.
  final String? subtitle;

  /// A list of widgets to display after the title.
  final List<Widget> suffixes;

  /// Whether to show a back button and center the title.
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    Widget titleWidget = Text(
      title,
      style: context.theme.typography.titleScreen,
    );

    if (subtitle != null) {
      titleWidget = Column(
        crossAxisAlignment: showBack ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Text(
            subtitle!,
            style: context.theme.typography.bodyPrimary.copyWith(
              color: context.theme.colors.mutedForeground,
            ),
          ),
          titleWidget,
        ],
      );
    }

    if (showBack) {
      return FHeader.nested(
        title: titleWidget,
        prefixes: [
          GestureDetector(
            onTap: () {
              if (context.canPop()) {
                context.pop();
              }
            },
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Icon(FPhosphorIcons.caretLeft, color: context.theme.colors.foreground, size: 24),
            ),
          ),
        ],
        suffixes: suffixes,
      );
    }

    return FHeader(
      title: titleWidget,
      suffixes: suffixes,
    );
  }
}
