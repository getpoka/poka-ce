import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:poka_ce/shared/widgets/poka_icon.dart';

class PokaSlidableAction extends StatelessWidget {
  const PokaSlidableAction({
    required this.icon,
    required this.color,
    required this.onPressed,
    this.isDestructive = false,
    super.key,
  });

  final IconData icon;
  final Color color;
  final VoidCallback onPressed;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    return CustomSlidableAction(
      onPressed: (ctx) {
        unawaited(
          isDestructive ? HapticFeedback.mediumImpact() : HapticFeedback.lightImpact(),
        );
        onPressed();
      },
      backgroundColor: Colors.transparent,
      foregroundColor: color,
      child: PokaIcon(
        icon: icon,
        color: color,
        size: PokaIconSize.small,
      ),
    );
  }
}
