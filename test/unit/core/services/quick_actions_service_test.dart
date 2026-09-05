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
    test('is a singleton via instance getter', () {
      expect(QuickActionsService.instance, isNotNull);
      expect(identical(QuickActionsService.instance, QuickActionsService.instance), isTrue);
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
  });
}
