import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/app/providers/use_case_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/accounts/presentation/controllers/account_list_notifier.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/categories/presentation/controllers/category_list_notifier.dart';
import 'package:poka_ce/features/dashboard/presentation/controllers/balance_visibility_provider.dart';
import 'package:poka_ce/features/recurring/domain/recurring_model.dart';
import 'package:poka_ce/features/recurring/presentation/controllers/recurring_list_notifier.dart';
import 'package:poka_ce/features/recurring/presentation/screens/recurring_detail_page.dart';
import 'package:poka_ce/features/settings/presentation/controllers/settings_notifier.dart';
import 'package:poka_ce/features/transactions/domain/i_transaction_repository.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:poka_ce/features/transactions/domain/use_cases/update_transaction_use_case.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/tile/transaction_tile.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

class MockTransactionRepo extends Mock implements ITransactionRepository {}

class MockUpdateTransactionUseCase extends Mock implements UpdateTransactionUseCase {}

class FakeRecurringListNotifier extends RecurringListNotifier {
  final List<RecurringTransactionModel> _recurrings;
  FakeRecurringListNotifier(this._recurrings);
  @override
  RecurringListState build() => RecurringListState(recurrings: _recurrings, isLoading: false);
}

class FakeCategoryListNotifier extends CategoryListNotifier {
  final List<CategoryModel> _categories;
  FakeCategoryListNotifier(this._categories);
  @override
  Future<List<CategoryModel>> build() async => _categories;
}

class FakeAccountListNotifier extends AccountListNotifier {
  final AccountListState _state;
  FakeAccountListNotifier(this._state);
  @override
  Stream<AccountListState> build() => Stream.value(_state);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.en));

  late MockTransactionRepo mockTxRepo;
  late MockUpdateTransactionUseCase mockUseCase;

  setUpAll(() {
    registerFallbackValue(
      TransactionModel(
        id: 'tx',
        accountId: 'a1',
        type: TransactionType.expense,
        amount: 1,
        transactionDate: DateTime(2026, 1, 1),
        createdAt: DateTime(2026, 1, 1),
        updatedAt: DateTime(2026, 1, 1),
      ),
    );
  });

  setUp(() {
    mockTxRepo = MockTransactionRepo();
    mockUseCase = MockUpdateTransactionUseCase();
  });

  RecurringTransactionModel recurring() => RecurringTransactionModel(
    id: 'r1',
    accountId: 'a1',
    type: TransactionType.expense,
    amount: 50000,
    period: RecurringPeriod.monthly,
    nextDate: DateTime(2026, 8, 1),
    createdAt: DateTime(2026, 1, 1),
    updatedAt: DateTime(2026, 1, 1),
  );

  Widget wrap({List<TransactionModel> transactions = const []}) {
    when(
      () => mockTxRepo.watchTransactions(
        startDate: any(named: 'startDate'),
        endDate: any(named: 'endDate'),
        accountIds: any(named: 'accountIds'),
        categoryIds: any(named: 'categoryIds'),
        types: any(named: 'types'),
        debtIds: any(named: 'debtIds'),
        recurringIds: any(named: 'recurringIds'),
      ),
    ).thenAnswer(
      (_) => Stream.value(Success<List<TransactionModel>, Failure>(transactions)),
    );

    return ProviderScope(
      overrides: [
        recurringListProvider.overrideWith(() => FakeRecurringListNotifier([recurring()])),
        categoryListProvider.overrideWith(() => FakeCategoryListNotifier(const [])),
        accountListProvider.overrideWith(() => FakeAccountListNotifier(const AccountListState())),
        transactionRepositoryProvider.overrideWithValue(mockTxRepo),
        updateTransactionUseCaseProvider.overrideWithValue(mockUseCase),
        balanceVisibilityProvider.overrideWithValue(true),
        settingsProvider.overrideWith(() => _FakeSettingsNotifier()),
      ],
      child: TranslationProvider(
        child: MaterialApp(
          builder: (context, child) => FTheme(data: lightTheme, child: child!),
          home: const RecurringDetailPage(id: 'r1'),
        ),
      ),
    );
  }

  TransactionModel tx() => TransactionModel(
    id: 'tx1',
    accountId: 'a1',
    type: TransactionType.expense,
    amount: 1000,
    transactionDate: DateTime(2026, 8, 1),
    createdAt: DateTime(2026, 8, 1),
    updatedAt: DateTime(2026, 8, 1),
  );

  group('RecurringDetailPage', () {
    testWidgets('renders schedule details with empty history', (tester) async {
      await tester.pumpWidget(wrap());
      await tester.pumpAndSettle();

      expect(find.text('Schedule Details'), findsOneWidget);
      expect(find.text('TRIGGER HISTORY'), findsOneWidget);
      expect(find.text('No history found for this schedule.'), findsOneWidget);
    });

    testWidgets('lists triggered transactions', (tester) async {
      await tester.pumpWidget(wrap(transactions: [tx()]));
      await tester.pumpAndSettle();

      expect(find.text('No history found for this schedule.'), findsNothing);
      expect(find.byType(RecentTransactionTile), findsWidgets);
    });
  });
}

class _FakeSettingsNotifier extends SettingsNotifier {
  @override
  SettingsState build() => const SettingsState();
}
