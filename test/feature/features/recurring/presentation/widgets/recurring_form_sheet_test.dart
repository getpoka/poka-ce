import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/accounts/domain/i_account_repository.dart';
import 'package:poka_ce/features/categories/domain/category_model.dart';
import 'package:poka_ce/features/categories/domain/i_category_repository.dart';
import 'package:poka_ce/features/recurring/domain/i_recurring_repository.dart';
import 'package:poka_ce/features/recurring/domain/recurring_model.dart';
import 'package:poka_ce/features/recurring/presentation/controllers/recurring_form_notifier.dart';
import 'package:poka_ce/features/recurring/presentation/controllers/recurring_list_notifier.dart';
import 'package:poka_ce/features/recurring/presentation/widgets/recurring_form_sheet.dart';
import 'package:poka_ce/theme/theme.dart';

class MockRecurringRepository extends Mock implements IRecurringRepository {}

class MockAccountRepository extends Mock implements IAccountRepository {}

class MockCategoryRepository extends Mock implements ICategoryRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(
      RecurringTransactionModel(
        id: 'r1',
        accountId: 'a1',
        type: TransactionType.expense,
        amount: 100,
        period: RecurringPeriod.monthly,
        nextDate: DateTime.utc(2025, 1, 1),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
  });

  late MockRecurringRepository mockRecurringRepo;
  late MockAccountRepository mockAccountRepo;
  late MockCategoryRepository mockCategoryRepo;

  setUp(() {
    mockRecurringRepo = MockRecurringRepository();
    mockAccountRepo = MockAccountRepository();
    mockCategoryRepo = MockCategoryRepository();

    when(() => mockAccountRepo.watchAccounts()).thenAnswer((_) => Stream.value(const Success([])));
    when(() => mockCategoryRepo.watchCategories()).thenAnswer((_) => Stream.value(const Success([])));
    when(() => mockAccountRepo.getAccounts()).thenAnswer((_) async => const Success([]));
    when(() => mockCategoryRepo.getCategories()).thenAnswer((_) async => const Success([]));
    when(() => mockCategoryRepo.getActiveCategories()).thenAnswer((_) async => const Success([]));
    when(() => mockRecurringRepo.getRecurringTransactions()).thenAnswer((_) async => const Success([]));
  });

  Widget createWidgetUnderTest(ProviderContainer container, {RecurringTransactionModel? initialRecurring}) {
    return UncontrolledProviderScope(
      container: container,
      child: FTheme(
        data: lightTheme,
        child: MaterialApp(
          builder: (context, child) => FToaster(child: child!),
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () => RecurringFormSheet.show(context, initialRecurring: initialRecurring),
                  child: const Text('Open'),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('RecurringFormSheet creates recurring successfully', (tester) async {
    when(() => mockRecurringRepo.createRecurring(any())).thenAnswer((_) async => const Success(null));

    final container = ProviderContainer(
      overrides: [
        recurringRepositoryProvider.overrideWithValue(mockRecurringRepo),
        accountRepositoryProvider.overrideWithValue(mockAccountRepo),
        categoryRepositoryProvider.overrideWithValue(mockCategoryRepo),
      ],
    );
    container.listen(recurringListProvider, (_, __) {});

    await tester.pumpWidget(createWidgetUnderTest(container));
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    final notifier = container.read(recurringFormProvider.notifier);
    notifier.setAmount(100);
    notifier.setAccountId('a1');
    notifier.setCategoryId('c1');
    notifier.setNextDate(DateTime.utc(2024, 1, 1));
    await notifier.save();

    verify(() => mockRecurringRepo.createRecurring(any())).called(1);
    expect(container.read(recurringFormProvider).isSuccess, true);
  });

  testWidgets('RecurringFormSheet updates recurring successfully', (tester) async {
    when(() => mockRecurringRepo.updateRecurring(any())).thenAnswer((_) async => const Success(null));

    final container = ProviderContainer(
      overrides: [
        recurringRepositoryProvider.overrideWithValue(mockRecurringRepo),
        accountRepositoryProvider.overrideWithValue(mockAccountRepo),
        categoryRepositoryProvider.overrideWithValue(mockCategoryRepo),
      ],
    );
    container.listen(recurringListProvider, (_, __) {});

    final initialRecurring = RecurringTransactionModel(
      id: 'r1',
      accountId: 'a1',
      type: TransactionType.expense,
      amount: 100,
      period: RecurringPeriod.monthly,
      nextDate: DateTime.utc(2025, 1, 1),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await tester.pumpWidget(createWidgetUnderTest(container, initialRecurring: initialRecurring));
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    final notifier = container.read(recurringFormProvider.notifier);
    notifier.setAmount(200);
    await notifier.save();

    verify(() => mockRecurringRepo.updateRecurring(any())).called(1);
    expect(container.read(recurringFormProvider).isSuccess, true);
  });
}
