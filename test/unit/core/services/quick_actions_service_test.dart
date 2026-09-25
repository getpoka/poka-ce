import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/core/services/quick_actions_service.dart';
import 'package:quick_actions/quick_actions.dart';

class MockQuickActions extends Mock implements QuickActions {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockQuickActions mockQuickActions;
  late QuickActionsService service;

  setUp(() {
    mockQuickActions = MockQuickActions();
    when(() => mockQuickActions.initialize(any())).thenAnswer((_) async {});
    when(() => mockQuickActions.setShortcutItems(any())).thenAnswer((_) async {});
    service = QuickActionsService(quickActions: mockQuickActions);
  });

  group('QuickActionsService', () {
    test('instance is set by default', () {
      expect(QuickActionsService.instance, isNotNull);
    });

    test('initialize registers action handler and sets shortcut items', () async {
      service.initialize();

      verify(() => mockQuickActions.initialize(any())).called(1);
      verify(() => mockQuickActions.setShortcutItems(any())).called(1);
    });

    test('initialize is idempotent', () async {
      service.initialize();
      service.initialize();

      verify(() => mockQuickActions.initialize(any())).called(1);
      verify(() => mockQuickActions.setShortcutItems(any())).called(1);
    });

    test('additionalShortcutItems defaults to empty list', () {
      expect(service.additionalShortcutItems, isEmpty);
    });

    test('setShortcutItems includes CE defaults plus additionalShortcutItems', () async {
      service.initialize();

      final captured = verify(() => mockQuickActions.setShortcutItems(captureAny())).captured;

      final items = captured.first as List<ShortcutItem>;
      expect(
        items.map((e) => e.type),
        containsAll(['action_add_transaction', 'action_add_account', 'action_add_category', 'action_add_goal']),
      );
    });
  });
}
