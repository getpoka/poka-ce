/// Types of categories used to classify transactions.
enum CategoryType { income, expense }

/// Types of accounts available in the application.
enum AccountType { assets, liability, goal }

/// Periods defining how often a budget resets.
enum BudgetPeriod { monthly, weekly, yearly, custom }

/// Classification of a financial transaction.
enum TransactionType { income, expense, transfer }

/// Frequencies for recurring transactions or events.
enum RecurringPeriod { daily, weekly, monthly, yearly }

/// Types of debt records (borrowing or lending).
enum DebtType { debt, loan }

/// Current status of a debt record.
enum DebtStatus { active, paid }

/// High-level allocation classification for expenses.
enum TransactionAllocation { need, want, saving }

/// Current status of a saving goal.
enum GoalStatus { active, completed }
