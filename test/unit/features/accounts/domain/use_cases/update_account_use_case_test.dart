import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/core/error/failure.dart';
import 'package:poka_ce/core/error/result.dart';
import 'package:poka_ce/core/utils/datetime_utils.dart';
import 'package:poka_ce/features/accounts/domain/account_model.dart';
import 'package:poka_ce/features/accounts/domain/i_account_repository.dart';
import 'package:poka_ce/features/accounts/domain/use_cases/update_account_use_case.dart';

class MockAccountRepository extends Mock implements IAccountRepository {}

class FakeAccountModel extends Fake implements AccountModel {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late UpdateAccountUseCase useCase;
  late MockAccountRepository mockAccountRepo;

  setUpAll(() {
    registerFallbackValue(FakeAccountModel());
  });

  setUp(() {
    mockAccountRepo = MockAccountRepository();
    useCase = UpdateAccountUseCase(mockAccountRepo);
  });

  final testAccount = AccountModel(
    id: 'a1',
    name: 'Old Name',
    type: AccountType.assets,
    balance: 5000,
    isActive: true,
    createdAt: DateTimeUtils.nowUtc(),
    updatedAt: DateTimeUtils.nowUtc(),
  );

  test('returns ValidationFailure if name is empty', () async {
    final result = await useCase.execute(
      account: testAccount,
      name: '',
      icon: null,
      color: null,
      isActive: true,
      restrictedCategoryIds: const [],
    );

    expect(result, isA<ErrorResult>());
    expect((result as ErrorResult).error, isA<ValidationFailure>());
  });

  test('updates account and returns Success', () async {
    when(() => mockAccountRepo.updateAccount(any())).thenAnswer((_) async => const Success(null));

    final result = await useCase.execute(
      account: testAccount,
      name: 'New Name',
      icon: 'icon',
      color: '#fff',
      isActive: false,
      restrictedCategoryIds: ['cat_1'],
    );

    expect(result, isA<Success>());

    final captured = verify(() => mockAccountRepo.updateAccount(captureAny())).captured.first as AccountModel;
    expect(captured.id, 'a1');
    expect(captured.name, 'New Name');
    expect(captured.icon, 'icon');
    expect(captured.color, '#fff');
    expect(captured.isActive, false);
    expect(captured.restrictedCategoryIds, ['cat_1']);
    expect(captured.updatedAt.isAfter(testAccount.updatedAt), true);
  });

  test('propagates repository error as ErrorResult', () async {
    const failure = DatabaseFailure('update failed');
    when(() => mockAccountRepo.updateAccount(any())).thenAnswer((_) async => const ErrorResult<void, Failure>(failure));

    final result = await useCase.execute(
      account: testAccount,
      name: 'New Name',
      icon: null,
      color: null,
      isActive: true,
      restrictedCategoryIds: const [],
    );

    expect(result, isA<ErrorResult<AccountModel, Failure>>());
    result.fold(
      (_) => fail('Should not succeed'),
      (error) => expect(error, same(failure)),
    );
  });
}
