import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
import 'package:poka_ce/core/extensions/string_extension.dart';
import 'package:poka_ce/core/utils/color_util.dart';
import 'package:poka_ce/i18n/strings.g.dart';

class PokaColorPicker extends StatelessWidget {
  const PokaColorPicker({
    required this.selectedColor,
    required this.onColorSelected,
    super.key,
  });

  final String? selectedColor;
  final ValueChanged<String> onColorSelected;

  @override
  Widget build(BuildContext context) {
    // Determine if the selected color is custom
    final isCustomColor = selectedColor != null && !ColorUtil.premiumColors.contains(selectedColor);

    // Create the standard 9 colors
    final items =
        ColorUtil.premiumColors.map<Widget>((hex) {
          return _ColorItem(
            hex: hex,
            isSelected: selectedColor == hex,
            onTap: () => onColorSelected(hex),
          );
        }).toList()..add(
          _CustomColorItem(
            selectedHex: isCustomColor ? selectedColor : null,
            onTap: () => _showVisualColorPickerSheet(context),
          ),
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: _buildRowWithSpacing(items.sublist(0, 6)),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: _buildRowWithSpacing(items.sublist(6, 12)),
        ),
      ],
    );
  }

  List<Widget> _buildRowWithSpacing(List<Widget> children) {
    final result = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      result.add(children[i]);
      if (i < children.length - 1) {
        result.add(const SizedBox(width: 8));
      }
    }
    return result;
  }

  void _showVisualColorPickerSheet(BuildContext context) {
    showFDialog<void>(
      context: context,
      builder: (context, style, animation) => _VisualColorPickerSheet(
        animation: animation,
        initialColor: selectedColor,
        onColorSelected: onColorSelected,
      ),
    );
  }
}

class _ColorItem extends StatelessWidget {
  const _ColorItem({
    required this.hex,
    required this.isSelected,
    required this.onTap,
  });

  final String hex;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: hex.toColor(),
          shape: BoxShape.circle,
          border: isSelected ? Border.all(color: context.theme.colors.foreground, width: 2) : null,
        ),
        child: isSelected
            ? const Center(
                child: Icon(
                  FPhosphorIcons.check,
                  color: Colors.white,
                  size: 16,
                ),
              )
            : null,
      ),
    );
  }
}

class _CustomColorItem extends StatelessWidget {
  const _CustomColorItem({
    required this.selectedHex,
    required this.onTap,
  });

  final String? selectedHex;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isSelected = selectedHex != null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: isSelected ? selectedHex!.toColor() : theme.colors.primary.withValues(alpha: 0.1),
          shape: BoxShape.circle,
          border: isSelected
              ? Border.all(color: theme.colors.foreground, width: 2)
              : Border.all(color: theme.colors.border),
        ),
        child: Center(
          child: isSelected
              ? const Icon(
                  FPhosphorIcons.check,
                  color: Colors.white,
                  size: 16,
                )
              : Icon(
                  FPhosphorIcons.palette,
                  size: 16,
                  color: theme.colors.primary,
                ),
        ),
      ),
    );
  }
}

class _VisualColorPickerSheet extends HookWidget {
  const _VisualColorPickerSheet({
    required this.onColorSelected,
    required this.animation,
    this.initialColor,
  });

  final String? initialColor;
  final ValueChanged<String> onColorSelected;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final initialHex = (initialColor ?? '#3B82F6').replaceAll('#', '');
    final hexController = useTextEditingController(text: initialHex);
    final hsvColor = useState<HSVColor>(HSVColor.fromColor(initialHex.toColor()));

    // Sync HSV to Hex
    useEffect(() {
      final hexString = hsvColor.value.toColor().toARGB32().toRadixString(16).substring(2, 8).toUpperCase();
      if (hexController.text.toUpperCase() != hexString) {
        hexController.text = hexString;
      }
      return null;
    }, [hsvColor.value]);

    // Sync Hex to HSV
    useEffect(() {
      void listener() {
        final cleanValue = hexController.text.replaceAll('#', '');
        if (cleanValue.length == 6) {
          final color = cleanValue.toColor();
          if (hsvColor.value.toColor().toARGB32() != color.toARGB32()) {
            hsvColor.value = HSVColor.fromColor(color);
          }
        }
      }

      hexController.addListener(listener);
      return () => hexController.removeListener(listener);
    }, [hexController]);

    void updateSV(Offset position, double width, double height) {
      var s = position.dx / width;
      var v = 1.0 - (position.dy / height);
      s = s.clamp(0.0, 1.0);
      v = v.clamp(0.0, 1.0);
      hsvColor.value = hsvColor.value.withSaturation(s).withValue(v);
    }

    void updateHue(Offset position, double width) {
      var h = (position.dx / width) * 360.0;
      h = h.clamp(0.0, 360.0);
      hsvColor.value = hsvColor.value.withHue(h);
    }

    return FDialog(
      animation: animation,
      builder: (dialogCtx, dialogStyle) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(t.shared.customColor, style: theme.typography.display.sm.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 24),
              // Saturation/Value Box
              LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  const height = 200.0;
                  return GestureDetector(
                    onPanStart: (d) => updateSV(d.localPosition, width, height),
                    onPanUpdate: (d) => updateSV(d.localPosition, width, height),
                    onPanDown: (d) => updateSV(d.localPosition, width, height),
                    child: Container(
                      width: width,
                      height: height,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: HSVColor.fromAHSV(1, hsvColor.value.hue, 1, 1).toColor(),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.white, Colors.transparent],
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.transparent, Colors.black],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                          Positioned(
                            left: hsvColor.value.saturation * width - 12,
                            top: (1.0 - hsvColor.value.value) * height - 12,
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: hsvColor.value.toColor(),
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              // Hue Slider
              LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  const height = 32.0;
                  return GestureDetector(
                    onPanStart: (d) => updateHue(d.localPosition, width),
                    onPanUpdate: (d) => updateHue(d.localPosition, width),
                    onPanDown: (d) => updateHue(d.localPosition, width),
                    child: Container(
                      width: width,
                      height: height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFFF0000), // 0
                            Color(0xFFFFFF00), // 60
                            Color(0xFF00FF00), // 120
                            Color(0xFF00FFFF), // 180
                            Color(0xFF0000FF), // 240
                            Color(0xFFFF00FF), // 300
                            Color(0xFFFF0000), // 360
                          ],
                        ),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            left: (hsvColor.value.hue / 360.0) * width - 12,
                            top: 0,
                            bottom: 0,
                            child: Container(
                              width: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(color: Colors.black12, width: 2),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              // Hex Input
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: hsvColor.value.toColor(),
                      shape: BoxShape.circle,
                      border: Border.all(color: theme.colors.border),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FTextField(
                      control: FTextFieldControl.managed(controller: hexController),
                      label: Text(t.shared.hexColorCode),
                      hint: t.shared.egFf5733,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: FButton(
                      variant: FButtonVariant.outline,
                      onPress: () => Navigator.of(context).pop(),
                      child: Text(t.common.cancel),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FButton(
                      onPress: () {
                        var hexString = hexController.text.trim().replaceAll('#', '');
                        if (hexString.isEmpty) {
                          hexString = '3B82F6';
                        }
                        onColorSelected('#$hexString');
                        Navigator.of(context).pop();
                      },
                      child: Text(t.shared.apply),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
