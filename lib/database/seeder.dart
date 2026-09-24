import 'dart:convert';
import 'dart:math' as math;

import 'package:drift/drift.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:poka_ce/core/config.dart';
import 'package:poka_ce/core/enums.dart';
import 'package:poka_ce/database/database.dart';
import 'package:uuid/uuid.dart';

/// Utility responsible for seeding default currencies, settings, categories,
/// and optional development dummy data into [AppDatabase].
class DatabaseSeeder {
  static const defaultCashAccountId = '01a031e6-4383-70cc-9328-111111111111';
  static const String _defaultCashAccountId = defaultCashAccountId;

  /// Optional global overrides for seeding behavior.
  static bool? globalOverrideSeedEssentials;
  static bool? globalOverrideSeedDummyData;

  /// Seeds default datasets into the provided [db].
  static Future<void> seed(AppDatabase db, {bool? overrideSeedDummyData, bool? overrideSeedEssentials}) async {
    // Static ISO master catalog and base settings always seed for offline usability
    await _seedCurrencies(db);
    await _seedSettings(db);

    final shouldSeedEssentials = overrideSeedEssentials ?? globalOverrideSeedEssentials ?? AppConfig.seedEssentials;
    if (shouldSeedEssentials) {
      await _seedCategories(db);
      await _seedEssentialAccounts(db);
    }

    final shouldSeedDummy = overrideSeedDummyData ?? globalOverrideSeedDummyData ?? AppConfig.seedDummyData;
    if (shouldSeedDummy) {
      await _seedDummyData(db);
    }
  }

  static Future<void> _seedEssentialAccounts(AppDatabase db) async {
    final existing = await db.select(db.accounts).get();
    if (!existing.any((a) => a.id == defaultCashAccountId)) {
      await db
          .into(db.accounts)
          .insertOnConflictUpdate(
            AccountsCompanion.insert(
              id: const Value(defaultCashAccountId),
              name: 'Cash',
              type: AccountType.assets,
              icon: const Value('payments'),
              color: const Value('#4CAF50'),
              balance: const Value(0),
            ),
          );
    }
  }

  static Future<void> _seedDummyData(AppDatabase db) async {
    final existing = await db.select(db.accounts).get();
    if (existing.any((a) => a.name == 'Bank BCA')) return;

    const uuid = Uuid();
    final now = DateTime.now();
    final random = math.Random();

    // Accounts UUIDs
    final bcaId = uuid.v7();
    final ewalletId = uuid.v7();
    final bcaPocketId = uuid.v7();
    final gopayId = uuid.v7();
    final goalAccountId = uuid.v7();
    final goalAccount2Id = uuid.v7();
    final goalAccount3Id = uuid.v7();

    // Categories UUIDs — must stay in sync with assets/data/categories.json
    const foodId = '01a08cc1-a96a-7041-9258-86dc773d4ac1'; // Food & Drinks
    const transportId = '01a08cc1-a96a-792a-a9b2-d2cbfa7faba8'; // Transportation
    const billsId = '01a08cc1-a96a-7adc-91b3-e17ab468edcc'; // Bills & Utilities
    const salaryId = '01a08cc1-a96a-7c6f-a2cc-248b4ce19507'; // Salary
    const lunchId = '01a08cc1-a96a-78cb-9e03-3f8cba51250d'; // Groceries
    const electricityId = '01a08cc1-a96a-72d9-a95a-d0fb81d1fde2'; // Electricity

    // Other UUIDs
    final budgetId = uuid.v7();
    final budget2Id = uuid.v7();
    final budget3Id = uuid.v7();
    final budget4Id = uuid.v7();
    final goalId = uuid.v7();
    final goal2Id = uuid.v7();
    final goal3Id = uuid.v7();
    final debtId = uuid.v7();
    final debt2Id = uuid.v7();
    final debt3Id = uuid.v7();
    final debt4Id = uuid.v7();
    final recurringId = uuid.v7();
    final recurring2Id = uuid.v7();
    final recurring3Id = uuid.v7();
    final recurringPastDueId = uuid.v7();

    // Transactions UUIDs
    final txIncomeId = uuid.v7();
    final txExpense1Id = uuid.v7();
    final txExpense2Id = uuid.v7();
    final txExpense3Id = uuid.v7();
    final txExpense4Id = uuid.v7();
    final txExpense5Id = uuid.v7();
    final txTransferId = uuid.v7();
    final txGoal1In1 = uuid.v7();
    final txGoal1In2 = uuid.v7();
    final txGoal1In3 = uuid.v7();
    final txGoal2In1 = uuid.v7();
    final txGoal2In2 = uuid.v7();
    final txGoal2In3 = uuid.v7();
    final txGoal3In1 = uuid.v7();
    final txGoal3In2 = uuid.v7();
    final txGoal3Out1 = uuid.v7();
    final txGoal3Out2 = uuid.v7();

    // New Today's Transactions UUIDs
    final txTodayIncomeId = uuid.v7();
    final txTodayTransferId = uuid.v7();
    final txTodaySplit1Id = uuid.v7();
    final txTodaySplit2Id = uuid.v7();
    final txTodayExpense1Id = uuid.v7();
    final txTodayExpense2Id = uuid.v7();

    await db.batch((batch) {
      // 1. Seed Accounts
      batch
        ..insertAll(db.accounts, [
          // Balances stored as ISO 4217 minor units (IDR precision=2, ×100).
          AccountsCompanion.insert(
            id: Value(bcaId),
            name: 'Bank BCA',
            type: AccountType.assets,
            icon: const Value('account_balance'),
            color: const Value('#2196F3'),
            balance: const Value(1_500_000_000), // Rp 15.000.000,00
          ),
          AccountsCompanion.insert(
            id: Value(ewalletId),
            name: 'e-Wallet',
            type: AccountType.assets,
            icon: const Value('account_balance_wallet'),
            color: const Value('#FF9800'),
            balance: const Value(20_000_000), // Rp 200.000,00
          ),
          // Sub-accounts / Pockets
          AccountsCompanion.insert(
            id: Value(bcaPocketId),
            parentId: Value(bcaId),
            name: 'BCA Saving Pocket',
            type: AccountType.assets,
            icon: const Value('savings'),
            color: const Value('#03A9F4'),
            balance: const Value(500_000_000), // Rp 5.000.000,00
          ),
          AccountsCompanion.insert(
            id: Value(gopayId),
            parentId: Value(ewalletId),
            name: 'GoPay',
            type: AccountType.assets,
            icon: const Value('wallet'),
            color: const Value('#8BC34A'),
            balance: const Value(15_000_000), // Rp 150.000,00
          ),
          // Account for Goal
          AccountsCompanion.insert(
            id: Value(goalAccountId),
            parentId: Value(bcaId),
            name: 'Vacation Fund Account',
            type: AccountType.goal,
            icon: const Value('flight'),
            color: const Value('#9C27B0'),
            balance: const Value(0),
          ),
          AccountsCompanion.insert(
            id: Value(goalAccount2Id),
            parentId: Value(bcaId),
            name: 'Geekom A7 Max Fund',
            type: AccountType.goal,
            icon: const Value('computer'),
            color: const Value('#3F51B5'),
            balance: const Value(0),
          ),
          AccountsCompanion.insert(
            id: Value(goalAccount3Id),
            parentId: Value(ewalletId),
            name: 'Emergency Fund',
            type: AccountType.goal,
            icon: const Value('health_and_safety'),
            color: const Value('#F44336'),
            balance: const Value(0),
          ),
        ])
        // 3. Seed Budgets (amounts in ISO 4217 minor units, IDR ×100)
        ..insertAll(db.budgets, [
          BudgetsCompanion.insert(
            id: Value(budgetId),
            name: 'Monthly Food Budget',
            amount: 200_000_000, // Rp 2.000.000,00
            categoryId: const Value(foodId),
            period: BudgetPeriod.monthly,
            startDate: DateTime(now.year, now.month),
          ),
          BudgetsCompanion.insert(
            id: Value(budget2Id),
            name: 'Transportation',
            amount: 50_000_000, // Rp 500.000,00
            categoryId: const Value(transportId),
            period: BudgetPeriod.monthly,
            startDate: DateTime(now.year, now.month),
          ),
          BudgetsCompanion.insert(
            id: Value(budget3Id),
            name: 'Utility Bills',
            amount: 100_000_000, // Rp 1.000.000,00
            categoryId: const Value(billsId),
            period: BudgetPeriod.monthly,
            startDate: DateTime(now.year, now.month),
          ),
          BudgetsCompanion.insert(
            id: Value(budget4Id),
            name: 'Electricity',
            amount: 30_000_000, // Rp 300.000,00
            categoryId: const Value(electricityId),
            period: BudgetPeriod.monthly,
            startDate: DateTime(now.year, now.month),
          ),
        ])
        ..insertAll(db.budgetRecords, [
          BudgetRecordsCompanion.insert(
            budgetId: budgetId,
            spentAmount: const Value(5_000_000), // Rp 50.000,00
            periodStart: DateTime(now.year, now.month),
            periodEnd: DateTime(now.year, now.month + 1).subtract(const Duration(days: 1)),
          ),
          BudgetRecordsCompanion.insert(
            budgetId: budget2Id,
            spentAmount: const Value(12_000_000), // Rp 120.000,00
            periodStart: DateTime(now.year, now.month),
            periodEnd: DateTime(now.year, now.month + 1).subtract(const Duration(days: 1)),
          ),
          BudgetRecordsCompanion.insert(
            budgetId: budget3Id,
            spentAmount: const Value(45_000_000), // Rp 450.000,00
            periodStart: DateTime(now.year, now.month),
            periodEnd: DateTime(now.year, now.month + 1).subtract(const Duration(days: 1)),
          ),
          BudgetRecordsCompanion.insert(
            budgetId: budget4Id,
            spentAmount: const Value(0),
            periodStart: DateTime(now.year, now.month),
            periodEnd: DateTime(now.year, now.month + 1).subtract(const Duration(days: 1)),
          ),
        ])
        // 4. Seed Goals (target amounts in ISO 4217 minor units, IDR ×100)
        ..insertAll(db.goals, [
          GoalsCompanion.insert(
            id: Value(goalId),
            accountId: goalAccountId,
            name: 'Bali Vacation',
            targetAmount: 1_000_000_000, // Rp 10.000.000,00
            targetDate: Value(now.add(const Duration(days: 90))),
            icon: const Value('beach_access'),
            color: const Value('#00BCD4'),
          ),
          GoalsCompanion.insert(
            id: Value(goal2Id),
            accountId: goalAccount2Id,
            name: 'Geekom A7 Max',
            targetAmount: 1_400_000_000, // Rp 14.000.000,00
            targetDate: Value(now.add(const Duration(days: 120))),
            icon: const Value('computer'),
            color: const Value('#3F51B5'),
          ),
          GoalsCompanion.insert(
            id: Value(goal3Id),
            accountId: goalAccount3Id,
            name: 'Emergency Fund',
            targetAmount: 3_000_000_000, // Rp 30.000.000,00
            targetDate: Value(now.add(const Duration(days: 365))),
            icon: const Value('health_and_safety'),
            color: const Value('#F44336'),
          ),
        ])
        // 5. Seed Debts (amounts in ISO 4217 minor units, IDR ×100)
        ..insertAll(db.debts, [
          DebtsCompanion.insert(
            id: Value(debtId),
            personName: 'John Doe',
            type: DebtType.debt, // I owe
            amount: 50_000_000, // Rp 500.000,00
            remainingAmount: 50_000_000,
            status: DebtStatus.active,
            dueDate: Value(now.add(const Duration(days: 30))),
            note: const Value('Borrowed for lunch'),
          ),
          DebtsCompanion.insert(
            id: Value(debt2Id),
            personName: 'Bank Loan',
            type: DebtType.debt, // I owe
            amount: 1_500_000_000, // Rp 15.000.000,00
            remainingAmount: 1_200_000_000, // Rp 12.000.000,00
            status: DebtStatus.active,
            dueDate: Value(now.add(const Duration(days: 180))),
            note: const Value('Motorcycle loan'),
          ),
          DebtsCompanion.insert(
            id: Value(debt3Id),
            personName: 'Alice',
            type: DebtType.loan, // They owe
            amount: 20_000_000, // Rp 200.000,00
            remainingAmount: 20_000_000,
            status: DebtStatus.active,
            dueDate: Value(now.add(const Duration(days: 15))),
            note: const Value('Movie tickets'),
          ),
          DebtsCompanion.insert(
            id: Value(debt4Id),
            personName: 'Bob',
            type: DebtType.loan, // They owe
            amount: 100_000_000, // Rp 1.000.000,00
            remainingAmount: 50_000_000, // Rp 500.000,00
            status: DebtStatus.active,
            dueDate: Value(now.add(const Duration(days: 60))),
            note: const Value('Rent share'),
          ),
        ])
        // 6. Seed Recurring Transactions (amounts in ISO 4217 minor units, IDR ×100)
        ..insertAll(db.recurringTransactions, [
          RecurringTransactionsCompanion.insert(
            id: Value(recurringId),
            accountId: bcaId,
            categoryId: const Value(billsId),
            type: TransactionType.expense,
            amount: 30_000_000, // Rp 300.000,00
            period: RecurringPeriod.monthly,
            nextDate: now.subtract(Duration(days: 30 * (random.nextInt(3) + 1))),
            note: const Value('Monthly Internet Bill'),
          ),
          RecurringTransactionsCompanion.insert(
            id: Value(recurring2Id),
            accountId: ewalletId,
            categoryId: const Value(transportId),
            type: TransactionType.expense,
            amount: 5_000_000, // Rp 50.000,00
            period: RecurringPeriod.weekly,
            nextDate: now.subtract(Duration(days: 7 * (random.nextInt(3) + 1))),
            note: const Value('Weekly Commute Top-up'),
          ),
          RecurringTransactionsCompanion.insert(
            id: Value(recurring3Id),
            accountId: bcaId,
            categoryId: const Value(salaryId),
            type: TransactionType.income,
            amount: 1_000_000_000, // Rp 10.000.000,00
            period: RecurringPeriod.monthly,
            nextDate: now.subtract(Duration(days: 30 * (random.nextInt(3) + 1))),
            note: const Value('Monthly Salary'),
          ),
          RecurringTransactionsCompanion.insert(
            id: Value(recurringPastDueId),
            accountId: ewalletId,
            categoryId: const Value(foodId),
            type: TransactionType.expense,
            amount: 12_000_000, // Rp 120.000,00
            period: RecurringPeriod.monthly,
            nextDate: now.subtract(Duration(days: 30 * (random.nextInt(3) + 1))),
            note: const Value('Netflix Subscription (Trigger)'),
          ),
        ])
        // Transactions in ISO 4217 minor units (IDR ×100)
        ..insertAll(db.transactions, [
          // ── Today's New Seeders ──
          TransactionsCompanion.insert(
            id: Value(txTodayIncomeId),
            accountId: bcaId,
            type: TransactionType.income,
            amount: 500_000_000, // Rp 5.000.000,00
            transactionDate: now,
            note: const Value('Freelance project'),
          ),
          TransactionsCompanion.insert(
            id: Value(txTodayTransferId),
            accountId: bcaId,
            destinationAccountId: Value(ewalletId),
            type: TransactionType.transfer,
            amount: 50_000_000, // Rp 500.000,00
            transactionDate: now,
            note: const Value('Monthly topup'),
          ),
          TransactionsCompanion.insert(
            id: Value(txTodaySplit1Id),
            accountId: bcaId,
            type: TransactionType.expense,
            amount: 30_000_000, // Rp 300.000,00
            transactionDate: now,
            note: const Value('Supermarket & Cafe'),
          ),
          TransactionsCompanion.insert(
            id: Value(txTodaySplit2Id),
            accountId: _defaultCashAccountId,
            type: TransactionType.expense,
            amount: 15_000_000, // Rp 150.000,00
            transactionDate: now,
            note: const Value('Transport & Snacks'),
          ),
          TransactionsCompanion.insert(
            id: Value(txTodayExpense1Id),
            accountId: bcaId,
            type: TransactionType.expense,
            amount: 7_500_000, // Rp 75.000,00
            transactionDate: now,
            note: const Value('Movie ticket'),
          ),
          TransactionsCompanion.insert(
            id: Value(txTodayExpense2Id),
            accountId: ewalletId,
            type: TransactionType.expense,
            amount: 2_500_000, // Rp 25.000,00
            transactionDate: now,
            note: const Value('Coffee'),
          ),
          // ── Past Seeders ──
          // Income Transaction
          TransactionsCompanion.insert(
            id: Value(txIncomeId),
            accountId: bcaId,
            type: TransactionType.income,
            amount: 1_500_000_000, // Rp 15.000.000,00
            transactionDate: now.subtract(const Duration(days: 15)),
            note: const Value('Monthly Salary'),
          ),
          // Expense Transactions (Multiple for Chart & Category variations)
          TransactionsCompanion.insert(
            id: Value(txExpense1Id),
            accountId: _defaultCashAccountId,
            type: TransactionType.expense,
            amount: 5_000_000, // Rp 50.000,00
            transactionDate: now.subtract(Duration.zero), // Today
            note: const Value('Lunch at cafe'),
          ),
          TransactionsCompanion.insert(
            id: Value(txExpense2Id),
            accountId: bcaId,
            type: TransactionType.expense,
            amount: 25_000_000, // Rp 250.000,00
            transactionDate: now.subtract(const Duration(days: 1)), // 1 day ago
            note: const Value('Gasoline'),
          ),
          TransactionsCompanion.insert(
            id: Value(txExpense3Id),
            accountId: bcaId,
            type: TransactionType.expense,
            amount: 45_000_000, // Rp 450.000,00
            transactionDate: now.subtract(const Duration(days: 2)), // 2 days ago
            note: const Value('Electricity Token'),
          ),
          TransactionsCompanion.insert(
            id: Value(txExpense4Id),
            accountId: ewalletId,
            type: TransactionType.expense,
            amount: 15_000_000, // Rp 150.000,00
            transactionDate: now.subtract(const Duration(days: 3)), // 3 days ago
            note: const Value('Groceries'),
          ),
          TransactionsCompanion.insert(
            id: Value(txExpense5Id),
            accountId: bcaId,
            type: TransactionType.expense,
            amount: 30_000_000, // Rp 300.000,00
            transactionDate: now.subtract(const Duration(days: 5)), // 5 days ago
            note: const Value('Internet Bill'),
          ),
          // Transfer Transaction
          TransactionsCompanion.insert(
            id: Value(txTransferId),
            accountId: bcaId,
            destinationAccountId: Value(gopayId),
            type: TransactionType.transfer,
            amount: 20_000_000, // Rp 200.000,00
            transactionDate: now.subtract(const Duration(days: 1)),
            note: const Value('Topup GoPay'),
          ),
        ])
        // 8. Seed Transaction Items (amounts in ISO 4217 minor units, IDR ×100)
        ..insertAll(db.transactionItems, [
          // ── Today's New Items ──
          TransactionItemsCompanion.insert(
            transactionId: txTodayIncomeId,
            categoryId: const Value(salaryId),
            allocation: const Value(TransactionAllocation.need),
            amount: 500_000_000, // Rp 5.000.000,00
            note: const Value('Project Payment'),
          ),
          // Items for txTodaySplit1 (Supermarket Rp200k, Cafe Rp100k)
          TransactionItemsCompanion.insert(
            transactionId: txTodaySplit1Id,
            categoryId: const Value(foodId),
            allocation: const Value(TransactionAllocation.need),
            amount: 20_000_000, // Rp 200.000,00
            note: const Value('Groceries'),
          ),
          TransactionItemsCompanion.insert(
            transactionId: txTodaySplit1Id,
            categoryId: const Value(lunchId),
            allocation: const Value(TransactionAllocation.want),
            amount: 10_000_000, // Rp 100.000,00
            note: const Value('Coffee at Cafe'),
          ),
          // Items for txTodaySplit2 (Transport Rp100k, Snacks Rp50k)
          TransactionItemsCompanion.insert(
            transactionId: txTodaySplit2Id,
            categoryId: const Value(transportId),
            allocation: const Value(TransactionAllocation.need),
            amount: 10_000_000, // Rp 100.000,00
            note: const Value('Train Ticket'),
          ),
          TransactionItemsCompanion.insert(
            transactionId: txTodaySplit2Id,
            categoryId: const Value(lunchId),
            allocation: const Value(TransactionAllocation.want),
            amount: 5_000_000, // Rp 50.000,00
            note: const Value('Snacks'),
          ),
          // Items for txTodayExpense1
          TransactionItemsCompanion.insert(
            transactionId: txTodayExpense1Id,
            categoryId: const Value(lunchId),
            allocation: const Value(TransactionAllocation.want),
            amount: 7_500_000, // Rp 75.000,00
            note: const Value('Movie ticket'),
          ),
          // Items for txTodayExpense2
          TransactionItemsCompanion.insert(
            transactionId: txTodayExpense2Id,
            categoryId: const Value(lunchId),
            allocation: const Value(TransactionAllocation.want),
            amount: 2_500_000, // Rp 25.000,00
            note: const Value('Americano'),
          ),
          // ── Past Items ──
          TransactionItemsCompanion.insert(
            transactionId: txIncomeId,
            categoryId: const Value(salaryId),
            allocation: const Value(TransactionAllocation.need),
            amount: 1_500_000_000, // Rp 15.000.000,00
            note: const Value('Main Salary'),
          ),
          TransactionItemsCompanion.insert(
            transactionId: txExpense1Id,
            categoryId: const Value(lunchId),
            allocation: const Value(TransactionAllocation.want),
            amount: 5_000_000, // Rp 50.000,00
            note: const Value('Nasi Goreng'),
          ),
          TransactionItemsCompanion.insert(
            transactionId: txExpense2Id,
            categoryId: const Value(transportId),
            allocation: const Value(TransactionAllocation.need),
            amount: 25_000_000, // Rp 250.000,00
            note: const Value('Pertamax'),
          ),
          TransactionItemsCompanion.insert(
            transactionId: txExpense3Id,
            categoryId: const Value(electricityId),
            allocation: const Value(TransactionAllocation.need),
            amount: 45_000_000, // Rp 450.000,00
            note: const Value('Token Listrik'),
          ),
          TransactionItemsCompanion.insert(
            transactionId: txExpense4Id,
            categoryId: const Value(foodId),
            allocation: const Value(TransactionAllocation.need),
            amount: 15_000_000, // Rp 150.000,00
            note: const Value('Supermarket'),
          ),
          TransactionItemsCompanion.insert(
            transactionId: txExpense5Id,
            categoryId: const Value(billsId),
            allocation: const Value(TransactionAllocation.need),
            amount: 30_000_000, // Rp 300.000,00
            note: const Value('IndiHome'),
          ),
        ])
        // Update Cash account balance for dummy data (in ISO 4217 minor units)
        ..update(
          db.accounts,
          const AccountsCompanion(balance: Value(50_000_000)), // Rp 500.000,00
          where: (tbl) => tbl.id.equals(_defaultCashAccountId),
        );
    });

    // 9. Insert Goal Transactions via DAO (amounts in ISO 4217 minor units, IDR ×100)
    final goalTransactions = [
      // Goal 1: Vacation Fund
      TransactionsCompanion.insert(
        id: Value(txGoal1In1),
        accountId: bcaId,
        destinationAccountId: Value(goalAccountId),
        type: TransactionType.transfer,
        amount: 50_000_000, // Rp 500.000,00
        transactionDate: now.subtract(const Duration(days: 30)),
        note: const Value('Vacation saving 1'),
      ),
      TransactionsCompanion.insert(
        id: Value(txGoal1In2),
        accountId: bcaId,
        destinationAccountId: Value(goalAccountId),
        type: TransactionType.transfer,
        amount: 100_000_000, // Rp 1.000.000,00
        transactionDate: now.subtract(const Duration(days: 15)),
        note: const Value('Vacation saving 2 (bonus)'),
      ),
      TransactionsCompanion.insert(
        id: Value(txGoal1In3),
        accountId: bcaId,
        destinationAccountId: Value(goalAccountId),
        type: TransactionType.transfer,
        amount: 50_000_000, // Rp 500.000,00
        transactionDate: now.subtract(const Duration(days: 2)),
        note: const Value('Vacation saving 3'),
      ),
      // Goal 2: Geekom A7 Max
      TransactionsCompanion.insert(
        id: Value(txGoal2In1),
        accountId: bcaId,
        destinationAccountId: Value(goalAccount2Id),
        type: TransactionType.transfer,
        amount: 200_000_000, // Rp 2.000.000,00
        transactionDate: now.subtract(const Duration(days: 60)),
        note: const Value('Mini PC saving start'),
      ),
      TransactionsCompanion.insert(
        id: Value(txGoal2In2),
        accountId: ewalletId,
        destinationAccountId: Value(goalAccount2Id),
        type: TransactionType.transfer,
        amount: 100_000_000, // Rp 1.000.000,00
        transactionDate: now.subtract(const Duration(days: 30)),
        note: const Value('From freelance cash'),
      ),
      TransactionsCompanion.insert(
        id: Value(txGoal2In3),
        accountId: bcaId,
        destinationAccountId: Value(goalAccount2Id),
        type: TransactionType.transfer,
        amount: 200_000_000, // Rp 2.000.000,00
        transactionDate: now.subtract(const Duration(days: 5)),
        note: const Value('Monthly saving'),
      ),
      // Goal 3: Emergency Fund
      TransactionsCompanion.insert(
        id: Value(txGoal3In1),
        accountId: bcaId,
        destinationAccountId: Value(goalAccount3Id),
        type: TransactionType.transfer,
        amount: 100_000_000, // Rp 1.000.000,00
        transactionDate: now.subtract(const Duration(days: 90)),
        note: const Value('Emergency fund start'),
      ),
      TransactionsCompanion.insert(
        id: Value(txGoal3In2),
        accountId: bcaId,
        destinationAccountId: Value(goalAccount3Id),
        type: TransactionType.transfer,
        amount: 100_000_000, // Rp 1.000.000,00
        transactionDate: now.subtract(const Duration(days: 45)),
        note: const Value('Emergency fund topup'),
      ),
      TransactionsCompanion.insert(
        id: Value(txGoal3Out1),
        accountId: goalAccount3Id,
        destinationAccountId: Value(bcaId),
        type: TransactionType.transfer,
        amount: 25_000_000, // Rp 250.000,00
        transactionDate: now.subtract(const Duration(days: 20)),
        note: const Value('Emergency car repair'),
      ),
      TransactionsCompanion.insert(
        id: Value(txGoal3Out2),
        accountId: goalAccount3Id,
        destinationAccountId: const Value(_defaultCashAccountId),
        type: TransactionType.transfer,
        amount: 25_000_000, // Rp 250.000,00
        transactionDate: now.subtract(const Duration(days: 10)),
        note: const Value('Medical emergency'),
      ),
    ];

    for (final tx in goalTransactions) {
      await db.transactionsDao.insertTransactionWithItems(tx, []);
    }
  }

  static Future<void> _seedCurrencies(AppDatabase db) async {
    final existing = await db.select(db.currencies).get();
    if (existing.isNotEmpty) return;

    final currencyData = {
      'AED': ('د.إ', 'UAE Dirham', 2),
      'AUD': (r'A$', 'Australian Dollar', 2),
      'BDT': ('৳', 'Bangladeshi Taka', 2),
      'BND': (r'B$', 'Brunei Dollar', 2),
      'CAD': (r'C$', 'Canadian Dollar', 2),
      'CHF': ('CHF', 'Swiss Franc', 2),
      'CNH': ('¥', 'Chinese Yuan Offshore', 2),
      'CNY': ('¥', 'Chinese Yuan', 2),
      'DKK': ('kr', 'Danish Krone', 2),
      'EUR': ('€', 'Euro', 2),
      'GBP': ('£', 'British Pound', 2),
      'HKD': (r'HK$', 'Hong Kong Dollar', 2),
      'IDR': ('Rp', 'Indonesian Rupiah', 2),
      'INR': ('₹', 'Indian Rupee', 2),
      'JPY': ('¥', 'Japanese Yen', 0),
      'KHR': ('៛', 'Cambodian Riel', 2),
      'KRW': ('₩', 'South Korean Won', 0),
      'KWD': ('د.ك', 'Kuwaiti Dinar', 3),
      'LAK': ('₭', 'Lao Kip', 0),
      'MMK': ('K', 'Myanmar Kyat', 2),
      'MYR': ('RM', 'Malaysian Ringgit', 2),
      'NOK': ('kr', 'Norwegian Krone', 2),
      'NZD': (r'NZ$', 'New Zealand Dollar', 2),
      'PGK': ('K', 'Papua New Guinean Kina', 2),
      'PHP': ('₱', 'Philippine Peso', 2),
      'PKR': ('₨', 'Pakistani Rupee', 2),
      'SAR': ('﷼', 'Saudi Riyal', 2),
      'SEK': ('kr', 'Swedish Krona', 2),
      'SGD': (r'S$', 'Singapore Dollar', 2),
      'THB': ('฿', 'Thai Baht', 2),
      'TWD': (r'NT$', 'Taiwan New Dollar', 2),
      'USD': (r'$', 'United States Dollar', 2),
      'VND': ('₫', 'Vietnamese Dong', 0),
    };

    for (final entry in currencyData.entries) {
      final code = entry.key;
      final symbol = entry.value.$1;
      final name = entry.value.$2;
      final precision = entry.value.$3;

      await db
          .into(db.currencies)
          .insertOnConflictUpdate(
            CurrenciesCompanion.insert(
              id: Value(const Uuid().v7()),
              code: code,
              name: name,
              symbol: symbol,
              precision: Value(precision),
            ),
          );
    }
  }

  static Future<void> _seedSettings(AppDatabase db) async {
    final existing = await db.select(db.settings).get();
    if (existing.isNotEmpty) return;

    await db.into(db.settings).insertOnConflictUpdate(SettingsCompanion.insert(key: 'themeMode', value: 'system'));
    // Note: baseCurrencyId will be set during onboarding
  }

  static Future<void> _seedCategories(AppDatabase db) async {
    final existing = await db.select(db.categories).get();
    if (existing.isNotEmpty) return;

    try {
      final raw = await rootBundle
          .loadString('assets/data/categories.json')
          .catchError((_) => rootBundle.loadString('packages/poka_ce/assets/data/categories.json'));
      final decoded = jsonDecode(raw) as List<dynamic>;
      final rows = decoded.cast<Map<String, dynamic>>();

      final companions = <CategoriesCompanion>[];
      for (final row in rows) {
        final parent = _categoryFromJson(row);
        if (parent != null) companions.add(parent);

        final children = row['children'] as List<dynamic>? ?? const [];
        for (final child in children) {
          final childCompanion = _categoryFromJson(child as Map<String, dynamic>, parentId: row['id'] as String);
          if (childCompanion != null) companions.add(childCompanion);
        }
      }

      await db.batch((batch) => batch.insertAllOnConflictUpdate(db.categories, companions));
    } on Exception catch (_) {
      // Gracefully ignore missing assets
    }
  }

  static CategoriesCompanion? _categoryFromJson(Map<String, dynamic> row, {String? parentId}) {
    CategoryType type;
    switch (row['type'] as String) {
      case 'income':
        type = CategoryType.income;
      case 'expense':
        type = CategoryType.expense;
      default:
        return null; // Skip unsupported types
    }

    return CategoriesCompanion.insert(
      id: Value(row['id'] as String),
      parentId: Value(parentId),
      name: row['name'] as String,
      type: type,
      icon: Value(row['icon'] as String?),
      color: Value(row['color'] as String?),
    );
  }
}
