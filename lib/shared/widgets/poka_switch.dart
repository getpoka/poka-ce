import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

/// A compact, scaled-down [FSwitch] for use inside menu rows and tight layouts.
///
/// Uses [Transform.scale] aligned to [Alignment.centerRight] so the surrounding
/// [FItem] row does not expand to accommodate the full-sized switch hitbox.
class PokaSwitch extends StatelessWidget {
  /// Creates a [PokaSwitch].
  ///
  /// [value] — the current toggle state.
  /// [onChange] — callback fired when the user taps the switch.
  /// [scale] — uniform scale factor applied to [FSwitch]; defaults to `0.7`.
  const PokaSwitch({
    required this.value,
    required this.onChange,
    this.scale = 0.7,
    super.key,
  });

  /// Current boolean state of the switch.
  final bool value;

  /// Called when the user toggles the switch.
  final ValueChanged<bool> onChange;

  /// Uniform scale applied to [FSwitch]. Smaller values produce a more
  /// compact switch that fits neatly inside [FItem] suffix slots.
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      // Align to the right so the invisible tap area doesn't bleed left.
      alignment: Alignment.centerRight,
      child: FSwitch(
        value: value,
        onChange: onChange,
      ),
    );
  }
}
