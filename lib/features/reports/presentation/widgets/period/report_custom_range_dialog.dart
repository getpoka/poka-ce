import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

/// Modal dialog providing date range calendar selection for custom report periods.
class ReportCustomRangeDialog extends StatefulWidget {
  /// Creates a [ReportCustomRangeDialog].
  const new({required this.initial, required this.now, required this.animation, super.key});

  /// The initially selected date range tuple, or null if unset.
  final (DateTime, DateTime)? initial;

  /// Reference current date for bounds.
  final DateTime now;

  /// Entrance animation for the dialog.
  final Animation<double> animation;

  @override
  State<ReportCustomRangeDialog> createState() => _ReportCustomRangeDialogState();
}

class _ReportCustomRangeDialogState extends State<ReportCustomRangeDialog> {
  (DateTime, DateTime)? _range;

  @override
  void initState() {
    super.initState();
    _range = widget.initial;
  }

  @override
  Widget build(BuildContext context) {
    return FDialog(
      animation: widget.animation,
      builder: (context, style) {
        return FCalendar.grid(
          control: FGridCalendarControl(
            start: DateTime.utc(widget.now.year - 3),
            end: DateTime.utc(widget.now.year, widget.now.month, widget.now.day),
          ),
          selectionControl: FDateSelectionControl.managedOpenRange(
            initial: _range != null ? (_range!.$1, _range!.$2) : (null, null),
            onChange: (range) {
              if (range.$1 != null && range.$2 != null) {
                setState(() => _range = (range.$1!, range.$2!));
                Future.delayed(const Duration(milliseconds: 400), () {
                  if (!context.mounted) return;
                  Navigator.of(context).pop((range.$1!, range.$2!));
                });
              } else if (range.$1 != null) {
                setState(() => _range = (range.$1!, range.$1!));
              }
            },
          ),
        );
      },
    );
  }
}
