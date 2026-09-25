import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poka_ce/app/router/router.dart';
import 'package:poka_ce/core/logger/poka_logger.dart';
import 'package:poka_ce/features/accounts/presentation/widgets/forms/account_form_sheet.dart';
import 'package:poka_ce/features/categories/presentation/widgets/forms/category_form_sheet.dart';
import 'package:poka_ce/features/goals/presentation/controllers/goal_form_sheet_builder_provider.dart';
import 'package:poka_ce/features/goals/presentation/widgets/goal_form_sheet.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/forms/transaction_form_sheet.dart';
import 'package:quick_actions/quick_actions.dart';

/// Service responsible for managing app shortcuts (Quick Actions).
///
/// Designed for extension: subclasses can override [additionalShortcutItems]
/// and [handleAdditionalAction] to inject extra platform shortcuts. Set
/// [instance] to a custom subclass instance before calling [initialize].
class QuickActionsService {
  /// Creates a [QuickActionsService] instance.
  new({QuickActions? quickActions}) : _quickActions = quickActions ?? const QuickActions();

  /// Global singleton instance. Can be replaced by a custom subclass before
  /// [initialize] is called.
  static QuickActionsService instance = QuickActionsService();
  final QuickActions _quickActions;

  bool _initialized = false;

  /// Initializes quick actions and registers shortcuts.
  void initialize() {
    if (_initialized) return;

    _quickActions.initialize((shortcutType) {
      talker.info('QuickAction triggered: $shortcutType');
      _handleAction(shortcutType);
    });

    _quickActions
        .setShortcutItems(<ShortcutItem>[
          const ShortcutItem(
            type: 'action_add_transaction',
            localizedTitle: 'Add Transaction',
            icon: 'ic_shortcut_add_transaction',
          ),
          const ShortcutItem(
            type: 'action_add_account',
            localizedTitle: 'Add Account',
            icon: 'ic_shortcut_add_account',
          ),
          const ShortcutItem(
            type: 'action_add_category',
            localizedTitle: 'Add Category',
            icon: 'ic_shortcut_add_category',
          ),
          const ShortcutItem(type: 'action_add_goal', localizedTitle: 'Add Goal', icon: 'ic_shortcut_add_goal'),
          ...additionalShortcutItems,
        ])
        .catchError((Object e, StackTrace st) {
          talker.error('Failed to set shortcut items', e, st);
        });

    _initialized = true;
  }

  /// Extra [ShortcutItem]s appended after the CE defaults.
  ///
  /// Override in a subclass to inject additional platform shortcuts.
  @protected
  List<ShortcutItem> get additionalShortcutItems => const [];

  /// Called for action types not handled by CE.
  ///
  /// Return `true` if the action was handled, `false` to fall through
  /// to the default unknown-action warning.
  @protected
  bool handleAdditionalAction(String type, BuildContext context) => false;

  void _handleAction(String type) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = rootNavigatorKey.currentContext;
      if (context == null) {
        talker.warning('Cannot handle QuickAction: rootNavigatorKey.currentContext is null');
        return;
      }

      switch (type) {
        case 'action_add_transaction':
          TransactionFormSheet.show(context);
        case 'action_add_account':
          AccountFormSheet.show(context);
        case 'action_add_category':
          CategoryFormSheet.show(context);
        case 'action_add_goal':
          final container = ProviderScope.containerOf(context, listen: false);
          final goalBuilder = container.read(goalFormSheetBuilderProvider);
          if (goalBuilder != null) {
            goalBuilder(context);
          } else {
            GoalFormSheet.show(context);
          }
        default:
          if (!handleAdditionalAction(type, context)) {
            talker.warning('Unknown QuickAction type: $type');
          }
      }
    });
  }
}
