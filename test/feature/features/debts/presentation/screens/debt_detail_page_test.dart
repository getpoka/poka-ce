import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:forui_phosphor/forui_phosphor.dart';
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
import 'package:poka_ce/features/debts/domain/debt_model.dart';
import 'package:poka_ce/features/debts/presentation/controllers/debt_detail_notifier.dart';
import 'package:poka_ce/features/debts/presentation/controllers/debt_list_notifier.dart';
import 'package:poka_ce/features/debts/presentation/screens/debt_detail_page.dart';
import 'package:poka_ce/features/settings/presentation/controllers/settings_notifier.dart';
import 'package:poka_ce/features/transactions/domain/i_transaction_repository.dart';
import 'package:poka_ce/features/transactions/domain/transaction_model.dart';
import 'package:poka_ce/features/transactions/domain/use_cases/update_transaction_use_case.dart';
import 'package:poka_ce/features/transactions/presentation/widgets/tile/transaction_tile.dart';
import 'package:poka_ce/i18n/strings.g.dart';
import 'package:poka_ce/theme/theme.dart';

class MockTransactionRepo extends Mock implements ITransactionRepository {}

class MockUpdateTransactionUseCase extends Mock implements UpdateTransactionUseCase {}

class FakeDebtListNotifier extends DebtList {
  final List<DebtModel> _debts;
  FakeDebtListNotifier(this._debts);
  @override
  Stream<List<DebtModel>> build() => Stream.value(_debts);
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

  DebtModel debt({DebtType type = DebtType.debt, DebtStatus status = DebtStatus.active}) => DebtModel(
    id: 'd1',
    personName: 'Budi',
    type: type,
    amount: 100000,
    remainingAmount: 50000,
    status: status,
    createdAt: DateTime(2026, 1, 1),
    updatedAt: DateTime(2026, 1, 1),
  );

  Widget wrap({
    required DebtModel activeDebt,
    List<TransactionModel> transactions = const [],
  }) {
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
        debtListProvider.overrideWith(() => FakeDebtListNotifier([activeDebt])),
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
          home: const DebtDetailPage(id: 'd1'),
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

  group('DebtDetailPage', () {
    testWidgets('renders debt details with empty history', (tester) async {
      await tester.pumpWidget(wrap(activeDebt: debt()));
      await tester.pumpAndSettle();

      expect(find.text('Debt Details'), findsOneWidget);
      expect(find.text('Budi'), findsWidgets);
      expect(find.text(t.debts.addRepayment), findsOneWidget);
      expect(find.text(t.debts.noHistoryFoundForThis(type: t.debts.payable)), findsOneWidget);
    });

    testWidgets('renders loan variant', (tester) async {
      await tester.pumpWidget(wrap(activeDebt: debt(type: DebtType.loan)));
      await tester.pumpAndSettle();

      expect(find.text('Loan Details'), findsOneWidget);
      expect(find.text(t.debts.noHistoryFoundForThis(type: t.debts.receivable)), findsOneWidget);
    });

    testWidgets('hides repayment actions for paid debts', (tester) async {
      await tester.pumpWidget(wrap(activeDebt: debt(status: DebtStatus.paid)));
      await tester.pumpAndSettle();

      expect(find.text(t.debts.addRepayment), findsNothing);
      expect(find.byIcon(FPhosphorIcons.handshake), findsNothing);
    });

    testWidgets('lists repayment transactions', (tester) async {
      await tester.pumpWidget(
        wrap(activeDebt: debt(), transactions: [tx()]),
      );
      await tester.pumpAndSettle();

      expect(find.text(t.debts.noHistoryFoundForThis(type: t.debts.payable)), findsNothing);
      expect(find.byType(RecentTransactionTile), findsWidgets);
    });
  });
}

class _FakeSettingsNotifier extends SettingsNotifier {
  @override
  SettingsState build() => const SettingsState();
}
