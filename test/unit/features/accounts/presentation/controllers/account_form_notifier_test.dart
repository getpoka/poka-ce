import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/app/providers/repository_providers.dart';
import 'package:poka_ce/app/providers/use_case_providers.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/accounts/domain/i_account_repository.dart';
import 'package:poka_ce/features/accounts/domain/use_cases/create_account_use_case.dart';
import 'package:poka_ce/features/accounts/domain/use_cases/update_account_use_case.dart';
import 'package:poka_ce/features/accounts/presentation/controllers/account_form_notifier.dart';

class MockAccountRepository extends Mock implements IAccountRepository {}

class MockCreateAccountUseCase extends Mock implements CreateAccountUseCase {}

class MockUpdateAccountUseCase extends Mock implements UpdateAccountUseCase {}

class FakeAccountModel extends Fake implements AccountModel {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockAccountRepository mockAccountRepo;
  late MockCreateAccountUseCase mockCreate;
  late MockUpdateAccountUseCase mockUpdate;

  setUpAll(() {
    registerFallbackValue(FakeAccountModel());
    registerFallbackValue(AccountType.assets);
  });

  setUp(() {
    mockAccountRepo = MockAccountRepository();
    mockCreate = MockCreateAccountUseCase();
    mockUpdate = MockUpdateAccountUseCase();
    // default for list refresh
    when(() => mockAccountRepo.getAccounts()).thenAnswer((_) async => const Success([]));
  });

  ProviderContainer createContainer() {
    final container = ProviderContainer(
      overrides: [
        accountRepositoryProvider.overrideWithValue(mockAccountRepo),
        createAccountUseCaseProvider.overrideWithValue(mockCreate),
        updateAccountUseCaseProvider.overrideWithValue(mockUpdate),
      ],
    );
    addTearDown(container.dispose);
    container.listen(accountFormProvider, (_, __) {});
    return container;
  }

  AccountModel sampleAccount() => AccountModel(
    id: 'a1',
    name: 'Cash',
    type: AccountType.assets,
    balance: 1000,
    isActive: true,
    createdAt: DateTime.utc(2024, 1, 1),
    updatedAt: DateTime.utc(2024, 1, 1),
  );

  group('AccountFormNotifier', () {
    test('initial state defaults', () {
      final container = createContainer();
      final state = container.read(accountFormProvider);
      expect(state.name, '');
      expect(state.type, AccountType.assets);
      expect(state.balance, 0);
      expect(state.isSaving, false);
      expect(state.isSuccess, false);
    });

    test('init(null) resets', () {
      final container = createContainer();
      final notifier = container.read(accountFormProvider.notifier);
      notifier.setName('tmp');
      notifier.init(null);
      expect(container.read(accountFormProvider).name, '');
    });

    test('init(with model) populates', () {
      final container = createContainer();
      final notifier = container.read(accountFormProvider.notifier);
      notifier.init(sampleAccount());
      final s = container.read(accountFormProvider);
      expect(s.name, 'Cash');
      expect(s.balance, 1000);
      expect(s.initialAccount, isNotNull);
    });

    test('setters update state', () {
      final container = createContainer();
      final notifier = container.read(accountFormProvider.notifier);
      notifier.setName('Bank');
      notifier.setType(AccountType.liability);
      notifier.setBalance(5000);
      final s = container.read(accountFormProvider);
      expect(s.name, 'Bank');
      expect(s.type, AccountType.liability);
      expect(s.balance, 5000);
    });

    test('save validation empty name', () async {
      final container = createContainer();
      final notifier = container.read(accountFormProvider.notifier);
      notifier.setName('');
      await notifier.save();
      expect(container.read(accountFormProvider).nameError, 'Name cannot be empty');
    });

    test('save create success', () async {
      final created = sampleAccount();
      when(
        () => mockCreate.execute(
          name: any(named: 'name'),
          type: any(named: 'type'),
          balance: any(named: 'balance'),
          icon: any(named: 'icon'),
          color: any(named: 'color'),
          parentId: any(named: 'parentId'),
          isActive: any(named: 'isActive'),
          restrictedCategoryIds: any(named: 'restrictedCategoryIds'),
        ),
      ).thenAnswer((_) async => Success(created));
      final container = createContainer();
      final notifier = container.read(accountFormProvider.notifier);
      notifier.setName('NewAcc');
      notifier.setBalance(100);
      await notifier.save();
      final s = container.read(accountFormProvider);
      expect(s.isSuccess, true);
      expect(s.isSaving, false);
      verify(
        () => mockCreate.execute(
          name: 'NewAcc',
          type: AccountType.assets,
          balance: 100,
          icon: null,
          color: null,
          parentId: null,
          isActive: true,
          restrictedCategoryIds: [],
        ),
      ).called(1);
    });

    test('save create failure', () async {
      when(
        () => mockCreate.execute(
          name: any(named: 'name'),
          type: any(named: 'type'),
          balance: any(named: 'balance'),
          icon: any(named: 'icon'),
          color: any(named: 'color'),
          parentId: any(named: 'parentId'),
          isActive: any(named: 'isActive'),
          restrictedCategoryIds: any(named: 'restrictedCategoryIds'),
        ),
      ).thenAnswer((_) async => const ErrorResult<AccountModel, Failure>(DatabaseFailure('db fail')));
      final container = createContainer();
      final notifier = container.read(accountFormProvider.notifier);
      notifier.setName('NewAcc');
      await notifier.save();
      expect(container.read(accountFormProvider).error, 'db fail');
      expect(container.read(accountFormProvider).isSaving, false);
    });

    test('save update success', () async {
      final existing = sampleAccount();
      final updated = existing.copyWith(name: 'Updated');
      when(
        () => mockUpdate.execute(
          account: any(named: 'account'),
          name: any(named: 'name'),
          icon: any(named: 'icon'),
          color: any(named: 'color'),
          isActive: any(named: 'isActive'),
          restrictedCategoryIds: any(named: 'restrictedCategoryIds'),
        ),
      ).thenAnswer((_) async => Success(updated));
      final container = createContainer();
      final notifier = container.read(accountFormProvider.notifier);
      notifier.init(existing);
      notifier.setName('Updated');
      await notifier.save();
      expect(container.read(accountFormProvider).isSuccess, true);
    });

    test('save update failure', () async {
      final existing = sampleAccount();
      when(
        () => mockUpdate.execute(
          account: any(named: 'account'),
          name: any(named: 'name'),
          icon: any(named: 'icon'),
          color: any(named: 'color'),
          isActive: any(named: 'isActive'),
          restrictedCategoryIds: any(named: 'restrictedCategoryIds'),
        ),
      ).thenAnswer((_) async => const ErrorResult<AccountModel, Failure>(ValidationFailure('invalid')));
      final container = createContainer();
      final notifier = container.read(accountFormProvider.notifier);
      notifier.init(existing);
      notifier.setName('Updated');
      await notifier.save();
      expect(container.read(accountFormProvider).error, 'invalid');
    });

    test('copyWith', () {
      const s = AccountFormState(name: 'a', isSaving: false, nameError: 'err');
      final c = s.copyWith(name: 'b', isSaving: true);
      expect(c.name, 'b');
      expect(c.isSaving, true);
      expect(c.nameError, 'err');

      final c2 = s.copyWith(nameError: null);
      expect(c2.nameError, isNull);
    });
  });
}
