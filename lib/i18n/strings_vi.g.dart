///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsVi extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsVi({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.vi,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <vi>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key) ?? super[key];

	late final TranslationsVi _root = this; // ignore: unused_field

	@override 
	TranslationsVi $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsVi(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$accounts$vi accounts = _Translations$accounts$vi._(_root);
	@override late final _Translations$app$vi app = _Translations$app$vi._(_root);
	@override late final _Translations$backup$vi backup = _Translations$backup$vi._(_root);
	@override late final _Translations$budgets$vi budgets = _Translations$budgets$vi._(_root);
	@override late final _Translations$categories$vi categories = _Translations$categories$vi._(_root);
	@override late final _Translations$common$vi common = _Translations$common$vi._(_root);
	@override late final _Translations$dashboard$vi dashboard = _Translations$dashboard$vi._(_root);
	@override late final _Translations$debts$vi debts = _Translations$debts$vi._(_root);
	@override Map<String, String> get error => {
		'generic': 'Đã xảy ra lỗi không mong muốn',
		'network': 'Vui lòng kiểm tra kết nối và thử lại',
		'database': 'Không thể truy cập dữ liệu cục bộ',
	};
	@override late final _Translations$goals$vi goals = _Translations$goals$vi._(_root);
	@override late final _Translations$lock$vi lock = _Translations$lock$vi._(_root);
	@override late final _Translations$onboarding$vi onboarding = _Translations$onboarding$vi._(_root);
	@override late final _Translations$recurring$vi recurring = _Translations$recurring$vi._(_root);
	@override late final _Translations$reports$vi reports = _Translations$reports$vi._(_root);
	@override late final _Translations$settings$vi settings = _Translations$settings$vi._(_root);
	@override late final _Translations$shared$vi shared = _Translations$shared$vi._(_root);
	@override late final _Translations$transactions$vi transactions = _Translations$transactions$vi._(_root);
}

// Path: accounts
class _Translations$accounts$vi extends Translations$accounts$en {
	_Translations$accounts$vi._(TranslationsVi root) : this._root = root, super.internal(root);

	final TranslationsVi _root; // ignore: unused_field

	// Translations
	@override String get accountName => 'Tên tài khoản';
	@override String get pocketName => 'Tên ví phụ';
	@override String get initialBalance => 'Số dư ban đầu';
	@override String get icon => 'Biểu tượng';
	@override String get color => 'Màu sắc';
	@override String get assets => 'Tài sản';
	@override String get liability => 'Nợ phải trả';
	@override String get income => 'Thu nhập';
	@override String get expense => 'Chi tiêu';
	@override String get balance => 'Số dư';
	@override String get walletsPockets => 'Ví & Ví phụ';
	@override String get accounts => 'Tài khoản';
	@override String get mainAccounts => 'Tài khoản chính';
	@override String get deleteAccount => 'Xóa tài khoản';
	@override String get areYouSureYouWantToDeleteThisAccountItWillBeHiddenFromTheApp => 'Bạn có chắc muốn xóa tài khoản này? Tài khoản sẽ bị ẩn khỏi ứng dụng.';
	@override String get delete => 'Xóa';
	@override String get account => 'Tài khoản';
	@override String get totalBalance => 'Tổng số dư';
	@override String get pockets => 'Ví phụ';
	@override String get deletePocket => 'Xóa ví phụ';
	@override String get cannotDeleteMainPocket => 'Không thể xóa ví phụ chính';
	@override String get mainPocket => 'Chính';
	@override String get areYouSureYouWantToDeleteThisPocketItWillBeHiddenFromTheApp => 'Bạn có chắc muốn xóa ví phụ này? Ví phụ sẽ bị ẩn khỏi ứng dụng.';
	@override String get nameCannotBeEmpty => 'Tên không được để trống';
	@override String get egMainWallet => 'ví dụ: Ví chính';
	@override String get egPocket => 'ví dụ: Đi chợ, Du lịch';
	@override String get selectIcon => 'Chọn biểu tượng';
	@override String get allowedCategories => 'Danh mục cho phép';
	@override String get transactions => 'Giao dịch';
	@override String get editAccount => 'Sửa tài khoản';
	@override String get editPocket => 'Sửa ví phụ';
	@override String get updateNameIconOrColor => 'Cập nhật tên, biểu tượng hoặc màu sắc';
	@override String get permanentlyRemoveThisAccount => 'Xóa vĩnh viễn tài khoản này';
	@override String get seeAll => 'Xem tất cả';
	@override String get noTransactionsYet => 'Chưa có giao dịch nào';
	@override String get accountTransactionsSubtitle => 'Các giao dịch ghi trong tài khoản này sẽ hiện ở đây.';
	@override String get pocketTransactionsSubtitle => 'Các giao dịch ghi trong ví phụ này sẽ hiện ở đây.';
	@override String get addAccount => 'Thêm tài khoản';
	@override String get noAccountsFound => 'Không tìm thấy tài khoản nào.';
	@override String get addPocket => 'Thêm ví phụ';
	@override String get noPocketsYet => 'Chưa có ví phụ nào';
	@override String get pocketsHelpYouSplitYourWalletIntoCategories => 'Ví phụ giúp bạn chia ví thành các nhóm riêng';
	@override String get activeAccount => 'Tài khoản đang dùng';
	@override String get inactiveAccountsWillBeHidden => 'Các tài khoản ngừng dùng sẽ bị ẩn';
	@override String get noCategoriesAvailable => 'Không có danh mục nào.';
	@override String get noAccountsFound1 => 'Không tìm thấy tài khoản nào';
	@override String subcategoriesCount({required Object count}) => '${count} danh mục con';
	@override String pocketsCount({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('vi'))(count,
		one: '1 ví phụ',
		other: '${count} ví phụ',
	);
	@override String get totalActiveAccounts => 'Tổng tài khoản đang dùng';
	@override String get noAccountsYet => 'Chưa có tài khoản nào';
	@override String get tapTheButtonBelowToAddYourFirstAccount => 'Nhấn nút bên dưới để thêm tài khoản đầu tiên';
	@override String get allCategoriesAllowed => 'Cho phép mọi danh mục';
	@override String categoriesSelected({required Object count}) => 'Đã chọn ${count} danh mục';
	@override String ratioOfAccount({required Object percent}) => '${percent}% của tài khoản';
	@override String get noMainAccountsYet => 'Chưa có tài khoản chính nào.';
	@override String percentOfAssets({required Object percent}) => '${percent}% của tài sản';
	@override String get recentTransactions => 'Giao dịch gần đây';
	@override String recentTransactionsCount({required Object count}) => 'Giao dịch gần đây (${count})';
	@override String get reconcileBalance => 'Đối soát số dư';
	@override String get reconcileBalanceSubtitle => 'Khớp số dư trong ứng dụng với số dư thực tế';
	@override String get currentBalanceInPoka => 'Số dư trong Poka';
	@override String get actualBalance => 'Số dư thực tế';
	@override String get difference => 'Chênh lệch';
	@override String get adjustmentExpense => 'Điều chỉnh (Chi)';
	@override String get adjustmentIncome => 'Điều chỉnh (Thu)';
	@override String get balanceAdjustment => 'Điều chỉnh số dư';
	@override String get saveAdjustment => 'Lưu điều chỉnh';
	@override String get balancesMatch => 'Số dư khớp nhau, không cần điều chỉnh';
	@override String get noteOptional => 'Ghi chú (Tùy chọn)';
	@override String get reconcileAccount => 'Đối soát số dư tài khoản';
}

// Path: app
class _Translations$app$vi extends Translations$app$en {
	_Translations$app$vi._(TranslationsVi root) : this._root = root, super.internal(root);

	final TranslationsVi _root; // ignore: unused_field

	// Translations
	@override String get name => 'Poka';
	@override String get tagline => 'Người bạn đồng hành tài chính của bạn';
	@override late final _Translations$app$nav$vi nav = _Translations$app$nav$vi._(_root);
	@override String get termsOfService => 'Điều khoản sử dụng';
	@override String get privacyPolicy => 'Chính sách riêng tư';
}

// Path: backup
class _Translations$backup$vi extends Translations$backup$en {
	_Translations$backup$vi._(TranslationsVi root) : this._root = root, super.internal(root);

	final TranslationsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sao lưu & Khôi phục';
	@override String get backupAction => 'Sao lưu';
	@override String get restoreAction => 'Khôi phục';
	@override String get password => 'Mật khẩu';
	@override String get confirmPassword => 'Xác nhận mật khẩu';
	@override String get passwordsDoNotMatch => 'Mật khẩu không khớp';
	@override String get backupSuccess => 'Sao lưu thành công';
	@override String get restoreSuccess => 'Khôi phục thành công';
	@override String get incorrectPassword => 'Sai mật khẩu hoặc tệp bị lỗi';
	@override String get enterPasswordToEncrypt => 'Nhập mật khẩu để mã hóa bản sao lưu';
	@override String get enterPasswordToDecrypt => 'Nhập mật khẩu để giải mã bản sao lưu';
	@override String get pleaseRestart => 'Vui lòng khởi động lại ứng dụng để áp dụng thay đổi.';
	@override String get passwordRequired => 'Vui lòng nhập mật khẩu';
	@override String get reminder => 'Nhắc sao lưu';
	@override String get reminderDesc => 'Nhắc bạn sao lưu dữ liệu định kỳ';
	@override String get reminderOff => 'Tắt';
	@override String get reminderWeekly => 'Hằng tuần';
	@override String get reminderMonthly => 'Hằng tháng';
	@override String get reminderNotificationTitle => 'Đã đến lúc sao lưu dữ liệu';
	@override String get reminderNotificationBody => 'Đã lâu kể từ lần sao lưu gần nhất. Hãy tạo bản sao lưu ngay để bảo vệ dữ liệu tài chính của bạn.';
	@override String get reminderSaved => 'Đã cập nhật nhắc sao lưu';
	@override String get restoreWarningDesc => 'Khôi phục sẽ thay thế toàn bộ dữ liệu hiện tại bằng dữ liệu trong tệp sao lưu đã chọn. Các thay đổi chưa sao lưu sẽ bị mất. Bạn có muốn tiếp tục?';
	@override String get sendTestNotification => 'Gửi thông báo thử';
	@override String get testNotificationSent => 'Đã gửi thông báo nhắc thử';
	@override String get permissionRationaleTitle => 'Nhắc sao lưu cục bộ';
	@override String get permissionRationaleDesc => 'Poka cần quyền thông báo để nhắc bạn sao lưu dữ liệu định kỳ. Nhắc nhở chạy hoàn toàn ngoại tuyến trên thiết bị, không theo dõi hay phân tích.';
	@override String get allowNotifications => 'Cho phép thông báo';
	@override String get permissionDenied => 'Quyền thông báo đã bị từ chối. Nhắc nhở vẫn đang tắt.';
}

// Path: budgets
class _Translations$budgets$vi extends Translations$budgets$en {
	_Translations$budgets$vi._(TranslationsVi root) : this._root = root, super.internal(root);

	final TranslationsVi _root; // ignore: unused_field

	// Translations
	@override String get budgetName => 'Tên ngân sách';
	@override String get spendingLimit => 'Hạn mức chi tiêu';
	@override String get period => 'Kỳ hạn';
	@override String get resetDay => 'Ngày đặt lại (1–31)';
	@override String get createBudget => 'Tạo ngân sách';
	@override String get endDate => 'Ngày kết thúc';
	@override String get budgetDetails => 'Chi tiết ngân sách';
	@override String get deleteBudget => 'Xóa ngân sách';
	@override String get areYouSureYouWantToDeleteThisBudgetAllRelatedTrackingHistoryWillBePermanentlyDeletedThisActionCannotBeUndone => 'Bạn có chắc muốn xóa ngân sách này? Toàn bộ lịch sử theo dõi liên quan sẽ bị xóa vĩnh viễn. Hành động này không thể hoàn tác.';
	@override String get delete => 'Xóa';
	@override String get transactions => 'Giao dịch';
	@override String get budgets => 'Ngân sách';
	@override String get allBudgets => 'Tất cả ngân sách';
	@override String get egGroceriesEntertainment => 'ví dụ: Đi chợ, Giải trí';
	@override String get eg80 => 'ví dụ: 80';
	@override String get category => 'Danh mục';
	@override String get account => 'Tài khoản';
	@override String get overLimit => 'Vượt hạn mức';
	@override String get remaining => 'Còn lại';
	@override String get totalSpent => 'Tổng đã chi';
	@override String get totalLimit => 'Tổng hạn mức';
	@override String get selectEndDate => 'Chọn ngày kết thúc';
	@override String get noTransactionsFoundForThisBudgetPeriod => 'Không tìm thấy giao dịch nào trong kỳ ngân sách này.';
	@override String get budgetTransactionsSubtitle => 'Các giao dịch thuộc ngân sách này sẽ hiện ở đây.';
	@override String get addBudget => 'Thêm ngân sách';
	@override String get spent => 'Đã chi ';
	@override String get noBudgetsYet => 'Chưa có ngân sách nào';
	@override String get setSpendingLimitsToTrackWhereYourMoneyGoesEachPeriod => 'Đặt hạn mức chi tiêu để theo dõi tiền của bạn mỗi kỳ.';
	@override String budgetAlert({required Object name}) => 'Cảnh báo ngân sách: ${name}';
	@override String percentOf({required Object percent}) => '${percent}% của ';
	@override String budgetsCount({required Object count}) => '${count} ngân sách';
	@override String get editBudget => 'Sửa ngân sách';
	@override String get newBudget => 'Ngân sách mới';
	@override String get nameCannotBeEmpty => 'Tên không được để trống';
	@override String get amountGreaterThanZero => 'Số tiền phải lớn hơn 0';
	@override String get alertThresholdLabel => 'Ngưỡng cảnh báo (%)';
	@override String get scope => 'Phạm vi';
	@override String get anyCategory => 'Mọi danh mục';
	@override String get anyAccount => 'Mọi tài khoản';
	@override String get saveChanges => 'Lưu thay đổi';
	@override String get periodWeekly => 'Hằng tuần';
	@override String get periodMonthly => 'Hằng tháng';
	@override String get periodYearly => 'Hằng năm';
	@override String get periodCustom => 'Tùy chỉnh';
	@override String budgetExceededAlert({required Object percentage, required Object name}) => 'Bạn đã dùng ${percentage}% ngân sách ${name}.';
}

// Path: categories
class _Translations$categories$vi extends Translations$categories$en {
	_Translations$categories$vi._(TranslationsVi root) : this._root = root, super.internal(root);

	final TranslationsVi _root; // ignore: unused_field

	// Translations
	@override String get expense => 'Chi tiêu';
	@override String get income => 'Thu nhập';
	@override String get categoryName => 'Tên danh mục';
	@override String get icon => 'Biểu tượng';
	@override String get color => 'Màu sắc';
	@override String get noCategoriesFound => 'Không tìm thấy danh mục nào.';
	@override String get subcategories => 'Danh mục con';
	@override String get categories => 'Danh mục';
	@override String get egFoodDining => 'ví dụ: Ăn uống';
	@override String get deleteCategory => 'Xóa danh mục';
	@override String get delete => 'Xóa';
	@override String get selectIcon => 'Chọn biểu tượng';
	@override String get noSubcategoriesYet => 'Chưa có danh mục con nào';
	@override String get noCategoriesFound1 => 'Không tìm thấy danh mục nào';
	@override String subcategoriesCount({required Object count}) => '${count} danh mục con';
	@override String get addSubcategory => 'Thêm danh mục con';
	@override String get addCategory => 'Thêm danh mục';
	@override String get emptyCategorySubtitle => 'Bắt đầu theo dõi chi tiêu bằng cách thêm danh mục';
	@override String get emptySubcategorySubtitle => 'Chia nhỏ danh mục thành các phần chi tiết hơn';
	@override String get saveSubCategory => 'Lưu danh mục con';
	@override String get saveCategory => 'Lưu danh mục';
	@override String get newSubCategory => 'Danh mục con mới';
	@override String get newCategory => 'Danh mục mới';
	@override String get editSubCategory => 'Sửa danh mục con';
	@override String get editCategory => 'Sửa danh mục';
	@override String deleteConfirmWithChildren({required Object count}) => 'Bạn có chắc muốn xóa danh mục này? ${count} danh mục con của nó sẽ thành danh mục chính, và các giao dịch của nó sẽ thành chưa phân loại.';
	@override String get deleteConfirmNoChildren => 'Bạn có chắc muốn xóa danh mục này? Mọi giao dịch của nó sẽ thành chưa phân loại.';
}

// Path: common
class _Translations$common$vi extends Translations$common$en {
	_Translations$common$vi._(TranslationsVi root) : this._root = root, super.internal(root);

	final TranslationsVi _root; // ignore: unused_field

	// Translations
	@override String get save => 'Lưu';
	@override String get cancel => 'Hủy';
	@override String get delete => 'Xóa';
	@override String get edit => 'Sửa';
	@override String get confirm => 'Xác nhận';
	@override String get back => 'Quay lại';
	@override String get loading => 'Đang tải...';
	@override String get error => 'Đã xảy ra lỗi';
	@override String get retry => 'Thử lại';
	@override String get empty => 'Chưa có dữ liệu';
	@override String get cannotBeUndone => 'Hành động này không thể hoàn tác.';
	@override String get pleaseWait => 'Vui lòng chờ';
	@override String get today => 'Hôm nay';
	@override String get yesterday => 'Hôm qua';
	@override String get dueToday => 'Đến hạn hôm nay';
	@override String get overdue => 'Quá hạn';
	@override String get uncategorized => 'Chưa phân loại';
	@override String get unknown => 'Không rõ';
	@override String get notSet => 'Chưa đặt';
	@override String get undo => 'Hoàn tác';
}

// Path: dashboard
class _Translations$dashboard$vi extends Translations$dashboard$en {
	_Translations$dashboard$vi._(TranslationsVi root) : this._root = root, super.internal(root);

	final TranslationsVi _root; // ignore: unused_field

	// Translations
	@override String get overview => 'Tổng quan';
	@override String get myFinances => 'Tài chính của tôi';
	@override String get netWorth => 'Giá trị ròng';
	@override String accountsCount({required Object count}) => '${count} tài khoản';
	@override String get assets => 'Tài sản';
	@override String get liabilities => 'Nợ phải trả';
	@override String get budgets => 'Ngân sách';
	@override String get categories => 'Danh mục';
	@override String get goals => 'Mục tiêu';
	@override String get debts => 'Nợ';
	@override String get recurring => 'Định kỳ';
	@override String get cashFlow => 'Dòng tiền';
	@override String get budget => 'Ngân sách';
	@override String get needs => 'Nhu cầu (50%)';
	@override String get wants => 'Mong muốn (30%)';
	@override String get savings => 'Tiết kiệm (20%)';
	@override String get saved => 'đã tiết kiệm';
	@override String get onTrack => 'Đúng tiến độ';
	@override String get needsAttention => 'Cần chú ý';
	@override String get income => 'Thu nhập';
	@override String get expense => 'Chi tiêu';
	@override String get other => 'Khác';
	@override String get noData => 'Không có dữ liệu';
	@override String get spendingActivity => 'Hoạt động chi tiêu';
	@override String get total => 'Tổng cộng';
	@override String get average => 'Trung bình';
	@override String get budgetPerDay => 'Ngân sách/Ngày';
	@override String get todaysBudget => 'Ngân sách hôm nay';
	@override String get overbudget => 'Vượt ngân sách!';
	@override String get setDailyBudget => 'Đặt ngân sách ngày';
	@override String get amount => 'Số tiền';
	@override String get amountHint => 'ví dụ: 100000';
	@override String get recentTransactions => 'Giao dịch gần đây';
	@override String get thisMonth => 'Tháng này';
	@override String get noRecentTransactions => 'Không có giao dịch gần đây';
	@override String get recentTransactionsSubtitle => 'Các giao dịch bạn mới ghi sẽ hiện ở đây.';
	@override String get seeAll => 'Xem tất cả';
	@override String get notSet => 'Chưa đặt';
	@override late final _Translations$dashboard$insight$vi insight = _Translations$dashboard$insight$vi._(_root);
	@override late final _Translations$dashboard$days$vi days = _Translations$dashboard$days$vi._(_root);
}

// Path: debts
class _Translations$debts$vi extends Translations$debts$en {
	_Translations$debts$vi._(TranslationsVi root) : this._root = root, super.internal(root);

	final TranslationsVi _root; // ignore: unused_field

	// Translations
	@override String get addRepayment => 'Thêm khoản trả';
	@override String get iOwe => 'Tôi nợ';
	@override String get theyOwe => 'Họ nợ';
	@override String get personName => 'Tên người';
	@override String get principalAmount => 'Số tiền gốc';
	@override String get transactionBinding => 'Liên kết giao dịch';
	@override String get cancel => 'Hủy';
	@override String get save => 'Lưu';
	@override String get ok => 'OK';
	@override String get addRecord => 'Thêm bản ghi';
	@override String get createRecord => 'Tạo bản ghi';
	@override String get debtDetails => 'Chi tiết khoản nợ';
	@override String get repaymentHistory => 'Lịch sử trả nợ';
	@override String get debtsLoans => 'Nợ & Cho vay';
	@override String get deleteDebt => 'Xóa khoản nợ';
	@override String get delete => 'Xóa';
	@override String get writeoffDebt => 'Xóa sổ khoản nợ';
	@override String get areYouSureYouWantToWriteoffThisDebtItWillBeMarkedAsPaidWithoutAffectingYourWalletBalances => 'Bạn có chắc muốn xóa sổ khoản nợ này? Nó sẽ được đánh dấu là đã trả mà không ảnh hưởng đến số dư ví của bạn.';
	@override String get writeoff => 'Xóa sổ';
	@override String get egJohnDoe => 'ví dụ: Nguyễn Văn A';
	@override String get category => 'Danh mục';
	@override String get account => 'Tài khoản';
	@override String get egDinnerLastFriday => 'ví dụ: Bữa tối thứ Sáu tuần trước';
	@override String get selectDueDate => 'Chọn ngày đến hạn';
	@override String get outstanding => 'Còn nợ';
	@override String get paid => 'Đã trả';
	@override String get principal => 'Tiền gốc';
	@override String get actionDenied => 'Hành động bị từ chối';
	@override String get paymentCannotExceedRemaining => 'Số tiền trả không được vượt quá số nợ còn lại.';
	@override String get addNote => 'Thêm ghi chú';
	@override String get payInFull => 'Trả toàn bộ';
	@override String get remaining => 'còn lại';
	@override String get paid1 => 'Đã trả ';
	@override String reminder({required Object type, required Object name}) => 'Nhắc nhở ${type}: ${name}';
	@override String due({required Object type, required Object name}) => '${type} đến hạn: ${name}';
	@override String noHistoryFoundForThis({required Object type}) => 'Không tìm thấy lịch sử cho ${type} này';
	@override String repaymentHistorySubtitle({required Object type}) => 'Các bản ghi thanh toán cho ${type} này sẽ hiện ở đây.';
	@override String failedToLoadDebts({required Object error}) => 'Tải khoản nợ thất bại: ${error}';
	@override String percentOf({required Object percent}) => '${percent}% của ';
	@override String settled({required Object count}) => '${count} đã xong';
	@override String get payable => 'Phải trả';
	@override String get receivable => 'Phải thu';
	@override String get noDebtsRecorded => 'Chưa ghi khoản nợ nào';
	@override String get noLoansRecorded => 'Chưa ghi khoản cho vay nào';
	@override String get trackMoneyYouOweToOthersAndLogRepayments => 'Theo dõi tiền bạn nợ người khác và dễ dàng ghi lại mọi khoản trả ở đây.';
	@override String get trackMoneyOthersOweYouAndLogCollections => 'Theo dõi tiền người khác nợ bạn và dễ dàng ghi lại mọi khoản thu ở đây.';
	@override String get editRecord => 'Sửa bản ghi';
	@override String get newRecord => 'Bản ghi mới';
	@override String get personNameCannotBeEmpty => 'Tên người không được để trống';
	@override String get amountGreaterThanZero => 'Số tiền phải lớn hơn 0';
	@override String get selectCategoryAndAccount => 'Vui lòng chọn danh mục và tài khoản';
	@override String get selectCategoryPrompt => 'Chọn danh mục';
	@override String get selectAccountPrompt => 'Chọn tài khoản';
	@override String get debtBindingHelp => 'Ghi khoản nợ này sẽ cộng tiền vào tài khoản (giao dịch thu).';
	@override String get loanBindingHelp => 'Ghi khoản cho vay này sẽ trừ tiền khỏi tài khoản (giao dịch chi).';
	@override String get noteLabel => 'Ghi chú';
	@override String get dueDateLabel => 'Ngày đến hạn';
	@override String get saveChanges => 'Lưu thay đổi';
	@override String deleteConfirm({required Object type}) => 'Bạn có chắc muốn xóa ${type} này? Bản ghi của nó sẽ bị xóa vĩnh viễn. Hành động này không thể hoàn tác.';
	@override String debtDetailsTitle({required Object type}) => 'Chi tiết ${type}';
	@override String get debtTypeLoan => 'Khoản cho vay';
	@override String get debtTypeDebt => 'Khoản nợ';
	@override String reminderAlert({required Object type, required Object amount, required Object action, required Object when}) => '${type} số tiền ${amount} phải được ${action} ${when}.';
	@override String overdueAlert({required Object type, required Object amount, required Object action}) => '${type} số tiền ${amount} đã quá hạn và phải được ${action} ngay.';
	@override String get actionCollect => 'thu';
	@override String get actionPay => 'trả';
	@override String get today => 'hôm nay';
	@override String inDays({required Object days}) => 'trong ${days} ngày nữa';
	@override String owedCount({required Object count}) => '${count} khoản nợ';
	@override String receivableCount({required Object count}) => '${count} khoản phải thu';
}

// Path: goals
class _Translations$goals$vi extends Translations$goals$en {
	_Translations$goals$vi._(TranslationsVi root) : this._root = root, super.internal(root);

	final TranslationsVi _root; // ignore: unused_field

	// Translations
	@override String get goals => 'Mục tiêu';
	@override String get fulfillGoal => 'Hoàn thành mục tiêu (Chi)';
	@override String get goalName => 'Tên mục tiêu';
	@override String get targetAmount => 'Số tiền mục tiêu';
	@override String get createGoal => 'Tạo mục tiêu';
	@override String errorPrefix({required Object error}) => 'Lỗi: ${error}';
	@override String get goalDetails => 'Chi tiết mục tiêu';
	@override String get transactions => 'Giao dịch';
	@override String get active => 'Đang thực hiện';
	@override String get past => 'Đã qua';
	@override String get actionDenied => 'Hành động bị từ chối';
	@override String get emptyBalanceBeforeDelete => 'Hãy rút hết số dư (chuyển ra ngoài) trước khi xóa Mục tiêu này.';
	@override String get ok => 'OK';
	@override String get deleteGoal => 'Xóa mục tiêu';
	@override String get areYouSureYouWantToDeleteThisGoalTheAssociatedPocketAccountAndItsHistoryWillAlsoBeRemovedThisActionCannotBeUndone => 'Bạn có chắc muốn xóa mục tiêu này? Tài khoản ví phụ liên quan và lịch sử của nó cũng sẽ bị xóa. Hành động này không thể hoàn tác.';
	@override String get delete => 'Xóa';
	@override String get egEmergencyFundNewLaptop => 'ví dụ: Quỹ khẩn cấp, Laptop mới';
	@override String get completed => 'Đã hoàn thành';
	@override String get fullyFunded => 'Đã đủ tiền';
	@override String get inProgress => 'Đang thực hiện';
	@override String get totalSaved => 'Tổng đã tiết kiệm';
	@override String get stillNeeded => 'Còn cần thêm';
	@override String get totalTarget => 'Tổng mục tiêu';
	@override String get selectTargetDate => 'Chọn ngày mục tiêu';
	@override String get noTransactionsFoundForThisGoal => 'Không tìm thấy giao dịch nào cho mục tiêu này.';
	@override String get goalTransactionsSubtitle => 'Các khoản chuyển hoặc tiết kiệm cho mục tiêu này sẽ hiện ở đây.';
	@override String get addGoal => 'Thêm mục tiêu';
	@override String get aDedicatedPocketAccountWillBeCreatedAutomaticallyToTrackThisGoal => 'Một tài khoản ví phụ riêng sẽ được tạo tự động để theo dõi mục tiêu này.';
	@override String get saved => 'đã tiết kiệm';
	@override String get needs => 'Cần thêm ';
	@override String get more => ' nữa';
	@override String get noGoalsYet => 'Chưa có mục tiêu nào';
	@override String get setSavingsTargetsADedicatedPocketIsCreatedAutomaticallyForEachGoal => 'Đặt mục tiêu tiết kiệm — mỗi mục tiêu sẽ có một ví phụ riêng được tạo tự động.';
	@override String percentOfTarget({required Object percent}) => '${percent}% của mục tiêu';
	@override String goalsCount({required Object count}) => '${count} mục tiêu';
	@override String fullyFundedCount({required Object count}) => '${count} đã đủ tiền';
	@override String get noCompletedGoalsYet => 'Chưa có mục tiêu hoàn thành nào';
	@override String get completedGoalsWillAppearHere => 'Các mục tiêu bạn hoàn thành sẽ hiện ở đây.';
	@override String get editGoal => 'Sửa mục tiêu';
	@override String get newGoal => 'Mục tiêu mới';
	@override String get nameCannotBeEmpty => 'Tên không được để trống';
	@override String get targetAmountGreaterThanZero => 'Số tiền mục tiêu phải lớn hơn 0';
	@override String get saveChanges => 'Lưu thay đổi';
	@override String get targetDateLabel => 'Ngày mục tiêu';
	@override String get activeGoals => 'Mục tiêu đang thực hiện';
	@override String get completedGoals => 'Mục tiêu đã hoàn thành';
	@override String get noActiveGoalsYet => 'Chưa có mục tiêu đang thực hiện';
	@override String get noActiveGoalsSubtitle => 'Tạo mục tiêu mới để bắt đầu tiết kiệm cho cột mốc tiếp theo.';
	@override String get saveInAccount => 'Tiết kiệm trong tài khoản';
	@override String get selectAccount => 'Chọn tài khoản';
	@override String get accountRequired => 'Vui lòng chọn tài khoản';
	@override String storedIn({required Object account}) => 'Lưu trong ${account}';
}

// Path: lock
class _Translations$lock$vi extends Translations$lock$en {
	_Translations$lock$vi._(TranslationsVi root) : this._root = root, super.internal(root);

	final TranslationsVi _root; // ignore: unused_field

	// Translations
	@override String get confirmPin => 'Xác nhận PIN';
	@override String get createPin => 'Tạo PIN';
	@override String get pinsDoNotMatch => 'PIN không khớp';
	@override String get reenterPin => 'Nhập lại PIN';
	@override String get enterPinAppLock => 'Nhập PIN để mở khóa ứng dụng';
	@override String get incorrectPin => 'Sai PIN';
	@override String get verifyIdentity => 'Xác minh danh tính';
	@override String retryInSeconds({required Object seconds}) => 'Thử lại sau ${seconds} giây';
	@override String get setupPinTitle => 'Thiết lập PIN';
	@override String get setupPinBody => 'Vui lòng tạo PIN trước khi bật Khóa ứng dụng hoặc Sinh trắc học.';
	@override String get unlocked => 'Đã mở khóa';
	@override String get enter6DigitPin => 'Nhập PIN 6 chữ số';
	@override String get enterPin => 'Nhập PIN';
	@override String get invalidPin => 'PIN không hợp lệ';
	@override String get tooManyAttempts => 'Quá nhiều lần thử';
	@override String get temporarilyLocked => 'Tạm thời bị khóa';
	@override String get authenticateReason => 'Xác thực để truy cập Poka';
}

// Path: onboarding
class _Translations$onboarding$vi extends Translations$onboarding$en {
	_Translations$onboarding$vi._(TranslationsVi root) : this._root = root, super.internal(root);

	final TranslationsVi _root; // ignore: unused_field

	// Translations
	@override String get continueWithCurrency => 'Tiếp tục với đơn vị tiền đã chọn';
	@override String get chooseYourBaseCurrency => 'Chọn đơn vị tiền cơ bản';
	@override String get thisCurrencyWillBeUsedForAllAccountsPocketsAndTransactionsYouCanChangeThisLaterInSettings => 'Đơn vị tiền này sẽ dùng cho mọi tài khoản, ví phụ và giao dịch. Bạn có thể đổi lại trong Cài đặt.';
}

// Path: recurring
class _Translations$recurring$vi extends Translations$recurring$en {
	_Translations$recurring$vi._(TranslationsVi root) : this._root = root, super.internal(root);

	final TranslationsVi _root; // ignore: unused_field

	// Translations
	@override String get addSchedule => 'Thêm lịch';
	@override String get transactionDetails => 'Chi tiết giao dịch';
	@override String get amount => 'Số tiền';
	@override String get frequency => 'Tần suất';
	@override String get startDate => 'Ngày bắt đầu';
	@override String get recurring => 'Định kỳ';
	@override String get schedules => 'Lịch định kỳ';
	@override String get scheduleDetails => 'Chi tiết lịch';
	@override String get deleteSchedule => 'Xóa lịch';
	@override String get areYouSureYouWantToDeleteThisRecurringScheduleExistingGeneratedTransactionsWillNotBeDeleted => 'Bạn có chắc muốn xóa lịch định kỳ này? Các giao dịch đã tạo trước đó sẽ không bị xóa.';
	@override String get delete => 'Xóa';
	@override String get triggerHistory => 'Lịch sử thực hiện';
	@override String get destinationAccount => 'Tài khoản nhận';
	@override String get category => 'Danh mục';
	@override String get egNetflixSubscription => 'ví dụ: Gói Netflix';
	@override String get selectFirstDueDate => 'Chọn ngày đến hạn đầu tiên';
	@override String get estMonthlyNet => 'Ròng hằng tháng (ước tính)';
	@override String get monthlyIn => 'Thu hằng tháng';
	@override String get monthlyOut => 'Chi hằng tháng';
	@override String get noRecurringTransactions => 'Chưa có giao dịch định kỳ';
	@override String get automateBillsLikeSubscriptionsOrSalary => 'Tự động hóa hóa đơn như gói đăng ký hay lương. Ứng dụng sẽ ghi chúng đúng lịch.';
	@override String get noHistoryFoundForThisSchedule => 'Không tìm thấy lịch sử cho lịch này.';
	@override String get scheduleHistorySubtitle => 'Các giao dịch tạo từ lịch này sẽ hiện ở đây.';
	@override String get allocation => 'Phân bổ';
	@override String get active => 'Đang bật';
	@override String get eachTimeTheAppOpensOverdueRecurringTransactionsAre => 'Mỗi lần mở ứng dụng, các giao dịch định kỳ quá hạn sẽ tự động được ghi vào sổ.';
	@override String schedulesCount({required Object count}) => '${count} lịch';
	@override String pausedCount({required Object count}) => '${count} đã tạm dừng';
	@override String get editRecurring => 'Sửa định kỳ';
	@override String get newRecurring => 'Định kỳ mới';
	@override String get mustSelectAccount => 'Phải chọn tài khoản';
	@override String get sourceAccount => 'Tài khoản nguồn';
	@override String get account => 'Tài khoản';
	@override String get selectAccountPrompt => 'Chọn tài khoản';
	@override String get selectDestinationPrompt => 'Chọn nơi nhận';
	@override String get selectCategoryOptional => 'Chọn danh mục (tùy chọn)';
	@override String get noteLabel => 'Ghi chú';
	@override String get saveChanges => 'Lưu thay đổi';
	@override String get createRecurring => 'Tạo định kỳ';
	@override String get amountGreaterThanZero => 'Số tiền phải lớn hơn 0';
	@override String get mustSelectStartDate => 'Phải chọn ngày bắt đầu';
	@override String get periodDaily => 'Hằng ngày';
	@override String get periodWeekly => 'Hằng tuần';
	@override String get periodMonthly => 'Hằng tháng';
	@override String get periodYearly => 'Hằng năm';
	@override String get autoGenerateActive => 'Sẽ tự động tạo giao dịch';
	@override String get autoGeneratePaused => 'Đã tạm dừng — sẽ không tạo giao dịch nào';
	@override String get recurringIncome => 'Thu nhập định kỳ';
	@override String get recurringExpense => 'Chi tiêu định kỳ';
	@override String get recurringTransfer => 'Chuyển khoản định kỳ';
	@override String nextDateLabel({required Object date}) => 'Tiếp theo: ${date}';
}

// Path: reports
class _Translations$reports$vi extends Translations$reports$en {
	_Translations$reports$vi._(TranslationsVi root) : this._root = root, super.internal(root);

	final TranslationsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Báo cáo';
	@override String get overview => 'Tổng quan tài chính';
	@override String get tabCashflow => 'Dòng tiền';
	@override String get tabBudgets => 'Ngân sách & Mục tiêu';
	@override String get period => 'Kỳ';
	@override String get thisMonth => 'Tháng này';
	@override String get lastMonth => 'Tháng trước';
	@override String get last3Months => '3 tháng';
	@override String get last6Months => '6 tháng';
	@override String get custom => 'Tùy chỉnh';
	@override String get income => 'Thu nhập';
	@override String get expense => 'Chi tiêu';
	@override String get netSavings => 'Tiết kiệm ròng';
	@override String get netCashflow => 'Dòng tiền ròng';
	@override String get cashflow => 'Dòng tiền';
	@override String get savingsRate => 'Tỷ lệ tiết kiệm';
	@override String get topCategories => 'Danh mục nổi bật';
	@override String get topExpenses => 'Khoản chi lớn nhất';
	@override String get topIncome => 'Khoản thu lớn nhất';
	@override String get monthlyTrend => 'Xu hướng hằng tháng';
	@override String get cashflowTrend => 'Xu hướng thu so với chi';
	@override String get budgetBreakdown => 'Chi tiết ngân sách';
	@override String get budgetUtilization => 'Mức sử dụng ngân sách';
	@override String get spendingAllocation => 'Phân bổ chi tiêu';
	@override String get noData => 'Không có dữ liệu trong kỳ này';
	@override String get noExpenseDataDesc => 'Ghi giao dịch chi để xem phân bổ chi tiêu của bạn.';
	@override String get noBudgets => 'Chưa có ngân sách nào';
	@override String get noBudgetsDesc => 'Thêm ngân sách để theo dõi hạn mức chi tiêu';
	@override String get onTrack => 'Đúng tiến độ';
	@override String get needsAttention => 'Cần chú ý';
	@override String get overBudget => 'Vượt ngân sách';
	@override String get onBudget => 'Trong hạn mức';
	@override String get needs => 'Nhu cầu';
	@override String get wants => 'Mong muốn';
	@override String get savings => 'Tiết kiệm';
	@override String get other => 'Khác';
	@override String get total => 'Tổng cộng';
	@override String get average => 'Trung bình';
	@override String get remaining => 'Còn lại';
	@override String get spent => 'Đã chi';
	@override String get limit => 'Hạn mức';
	@override String txCount({required Object count}) => '${count} giao dịch';
	@override String get selectDateRange => 'Chọn khoảng ngày';
	@override String get apply => 'Áp dụng';
	@override String get from => 'Từ';
	@override String get to => 'Đến';
	@override String comparedTo({required Object period}) => 'so với ${period}';
	@override String get higher => 'cao hơn';
	@override String get lower => 'thấp hơn';
	@override String get same => 'bằng với';
	@override String get noChange => 'Không thay đổi';
	@override String get percent50 => '50%';
	@override String get percent30 => '30%';
	@override String get percent20 => '20%';
	@override String get rule503020 => '50/30/20';
	@override String get prevLastMonth => 'tháng trước';
	@override String get prevMonth => 'tháng trước';
	@override String get prev3Months => '3 tháng trước';
	@override String get prev6Months => '6 tháng trước';
	@override String get prevPeriod => 'kỳ trước';
	@override String get exportExcel => 'Xuất ra Excel';
	@override String get exportExcelSuccess => 'Xuất Excel thành công';
	@override String get exportExcelError => 'Xuất tệp Excel thất bại';
}

// Path: settings
class _Translations$settings$vi extends Translations$settings$en {
	_Translations$settings$vi._(TranslationsVi root) : this._root = root, super.internal(root);

	final TranslationsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Cài đặt';
	@override String get preferences => 'Tùy chọn';
	@override String get baseCurrency => 'Đơn vị tiền cơ bản';
	@override String get theme => 'Giao diện';
	@override String get language => 'Ngôn ngữ';
	@override String get numberFormat => 'Định dạng số';
	@override String get selectNumberFormat => 'Chọn định dạng số';
	@override String get formatSystem => 'Mặc định ứng dụng';
	@override String get formatId => '1.000.000,00';
	@override String get formatUs => '1,000,000.00';
	@override String get formatFr => '1 000 000,00';
	@override String get system => 'Hệ thống';
	@override String get english => 'English';
	@override String get indonesia => 'Indonesia';
	@override String get malay => 'Bahasa Melayu';
	@override String get vietnam => 'Tiếng Việt';
	@override String get security => 'Bảo mật';
	@override String get appLock => 'Khóa ứng dụng';
	@override String get appLockDesc => 'Bảo vệ ứng dụng bằng PIN';
	@override String get biometrics => 'Sinh trắc học';
	@override String get biometricsDesc => 'Dùng vân tay để mở khóa';
	@override String get dataManagement => 'Quản lý dữ liệu';
	@override String get backupRestore => 'Sao lưu & Khôi phục';
	@override String get backupRestoreDesc => 'Lưu hoặc khôi phục dữ liệu của bạn';
	@override String get clearOld => 'Xóa giao dịch cũ';
	@override String get clearOldDesc => 'Xóa các giao dịch cũ hơn 1 năm';
	@override String get resetData => 'Đặt lại dữ liệu';
	@override String get resetDataDesc => 'Xóa toàn bộ dữ liệu ứng dụng cục bộ';
	@override String get support => 'Hỗ trợ';
	@override String get faq => 'Câu hỏi thường gặp';
	@override String get faqDesc => 'Các câu hỏi thường gặp';
	@override String get about => 'Về Poka CE';
	@override String get aboutDesc => 'Thông tin phiên bản và pháp lý';
	@override String get selectTheme => 'Chọn giao diện';
	@override String get themeLight => 'Sáng';
	@override String get themeDark => 'Tối';
	@override String get selectLanguage => 'Chọn ngôn ngữ';
	@override String get oldTransactionsCleared => 'Đã xóa giao dịch cũ thành công';
	@override String get appDataReset => 'Đã đặt lại dữ liệu ứng dụng thành công';
	@override String get failedToExportLogs => 'Xuất nhật ký thất bại';
	@override String easterEggRemaining({required Object remaining}) => 'Còn ${remaining} lần chạm nữa là có bất ngờ...';
	@override String get easterEggFound => '🎉 Bạn đã tìm thấy easter egg!';
	@override String get selectCurrency => 'Chọn đơn vị tiền';
	@override String get openSourceLicenses => 'Giấy phép mã nguồn mở';
	@override String get checkForUpdates => 'Kiểm tra cập nhật';
	@override String get viewLatestReleasesOnGithub => 'Xem bản phát hành mới nhất trên GitHub';
	@override String get helpIssues => 'Trợ giúp & Sự cố';
	@override String get reportBugsOrRequestFeatures => 'Báo lỗi hoặc đề xuất tính năng';
	@override String get legal => 'Pháp lý';
	@override String get termsOfService => 'Điều khoản sử dụng';
	@override String get readOurTermsAndConditions => 'Đọc điều khoản và điều kiện của chúng tôi';
	@override String get privacyPolicy => 'Chính sách riêng tư';
	@override String get learnHowWeHandleYourData => 'Tìm hiểu cách chúng tôi xử lý dữ liệu của bạn';
	@override String get viewThirdpartySoftwareLicenses => 'Xem giấy phép phần mềm bên thứ ba';
	@override String get advanced => 'Nâng cao';
	@override String get exportDebugLogs => 'Xuất nhật ký gỡ lỗi';
	@override String get shareErrorLogsForTroubleshooting => 'Chia sẻ nhật ký lỗi để khắc phục sự cố';
	@override String get search => 'Tìm kiếm...';
	@override String get errorLoadingContent => 'Tải nội dung thất bại';
	@override String get noLicensesFound => 'Không tìm thấy giấy phép nào';
	@override String get pokaCe => 'Poka CE';
	@override String get communityEdition => 'Phiên bản cộng đồng';
	@override String get aboutDescription => 'Trình quản lý tài chính cá nhân mã nguồn mở, miễn phí, giúp bạn theo dõi chi tiêu, quản lý ngân sách và giám sát tài khoản ngay trên thiết bị.';
	@override String get copyright => '© 2026 POKA. All rights reserved.';
	@override String get noResultsFound => 'Không tìm thấy kết quả';
	@override String get weCouldntFindAnyCurrencyMatching => 'Không tìm thấy đơn vị tiền nào khớp với "{search}".';
	@override String get notSet => 'Chưa đặt';
	@override String get exportExcel => 'Xuất ra Excel';
	@override String get exportExcelDesc => 'Xuất giao dịch, tài khoản và danh mục ra tệp .xlsx';
	@override String get exportExcelSuccess => 'Xuất Excel thành công';
	@override String get exportExcelError => 'Xuất tệp Excel thất bại';
	@override String get currencyLockedToast => 'Không thể thay đổi tiền tệ sau khi có giao dịch. Vui lòng thiết lập lại dữ liệu nếu bạn muốn thay đổi.';
}

// Path: shared
class _Translations$shared$vi extends Translations$shared$en {
	_Translations$shared$vi._(TranslationsVi root) : this._root = root, super.internal(root);

	final TranslationsVi _root; // ignore: unused_field

	// Translations
	@override String get authRequired => 'Yêu cầu xác thực';
	@override String get hexColorCode => 'Mã màu Hex';
	@override String get apply => 'Áp dụng';
	@override String get enterAmount => 'Nhập số tiền';
	@override String get selectCategory => 'Chọn danh mục';
	@override String get egFf5733 => 'ví dụ: FF5733';
	@override String get amount => 'Số tiền';
	@override String get noCategoriesAvailable => 'Không có danh mục nào.';
	@override String get noWalletsFoundPleaseCreateOneFirst => 'Không tìm thấy ví nào. Vui lòng tạo ví trước.';
	@override String get balance => 'Số dư: ';
	@override String get optional => 'Tùy chọn';
	@override String get customColor => 'Màu tùy chỉnh';
	@override String get selectWallet => 'Chọn ví';
}

// Path: transactions
class _Translations$transactions$vi extends Translations$transactions$en {
	_Translations$transactions$vi._(TranslationsVi root) : this._root = root, super.internal(root);

	final TranslationsVi _root; // ignore: unused_field

	// Translations
	@override String get searchTransactions => 'Tìm kiếm giao dịch...';
	@override String get failedToLoad => 'Tải giao dịch thất bại';
	@override String get cancel => 'Hủy';
	@override String get delete => 'Xóa';
	@override String get goToToday => 'Về hôm nay';
	@override String get addItem => 'Thêm mục';
	@override String get saveSplitTransaction => 'Lưu giao dịch tách';
	@override String get transactionType => 'Loại giao dịch';
	@override String get applyFilter => 'Áp dụng bộ lọc';
	@override String get noAccountsAvailable => 'Không có tài khoản nào';
	@override String get account => 'Tài khoản';
	@override String get category => 'Danh mục';
	@override String get done => 'Xong';
	@override String get save => 'Lưu';
	@override String get transactions => 'Giao dịch';
	@override String get splitTransaction => 'Tách giao dịch';
	@override String get from => 'Từ';
	@override String get to => 'Đến';
	@override String get empty => '+/-';
	@override String get filtered => 'Đã lọc';
	@override String get netBalance => 'Số dư ròng';
	@override String get income => 'Thu nhập';
	@override String get expense => 'Chi tiêu';
	@override String get selectCategory => 'Chọn danh mục';
	@override String get filter => 'Lọc';
	@override String get backToToday => 'Về hôm nay';
	@override String get deleteTransaction => 'Xóa giao dịch';
	@override String get deleteTransactionWarning => 'Xóa giao dịch này sẽ hoàn lại số dư tài khoản và ngân sách về trạng thái trước đó.';
	@override String get out => 'Chi ';
	@override String get noTransactions => 'Không có giao dịch';
	@override String get addNote => 'Thêm ghi chú';
	@override String get noItemsYet => 'Chưa có mục nào';
	@override String get tapAddItemToBeginSplittingntheTransaction => 'Nhấn "Thêm mục" để bắt đầu tách\ngiao dịch.';
	@override String get addAtLeastOneMoreItemToSave => 'Thêm ít nhất một mục nữa để lưu.';
	@override String get noTransactions1 => 'Không có giao dịch';
	@override String get reset => 'Đặt lại';
	@override String get incoming => 'Thu ';
	@override String nothingRecordedFor({required Object period}) => 'Chưa ghi gì cho ${period}.';
	@override String splitItems({required Object count}) => '${count} mục đã tách';
	@override String itemsCount({required Object count}) => '${count} mục';
	@override String transactionsCount({required Object count}) => '${count} giao dịch';
	@override String get editTransaction => 'Sửa giao dịch';
	@override String get newTransaction => 'Giao dịch mới';
	@override String get fromAccount => 'Tài khoản chuyển';
	@override String get toAccount => 'Tài khoản nhận';
	@override String get need => 'Nhu cầu';
	@override String get want => 'Mong muốn';
	@override String get saving => 'Tiết kiệm';
	@override String get addNoteEllipsis => 'Thêm ghi chú...';
	@override String get editItem => 'Sửa mục';
	@override String get newItem => 'Mục mới';
	@override String get viewModeDay => 'Ngày';
	@override String get viewModeWeek => 'Tuần';
	@override String get viewModeMonth => 'Tháng';
	@override String get viewModeDaily => 'Hằng ngày';
	@override String get viewModeWeekly => 'Hằng tuần';
	@override String get viewModeMonthly => 'Hằng tháng';
	@override String get debt => 'Nợ';
	@override String get recurring => 'Định kỳ';
	@override String get transfer => 'Chuyển khoản';
	@override String weekNumber({required Object weekNum, required Object date}) => 'Tuần ${weekNum} · ${date}';
	@override String get insufficientBalance => 'Số dư không đủ';
	@override String insufficientBalanceWarning({required Object amount, required Object account, required Object balance}) => 'Số tiền (${amount}) vượt quá số dư hiện tại trong ${account} (${balance}). Có thể bạn quên ghi thu nhập trước?';
	@override String get insufficientBalanceConsequence => 'Số dư tài khoản sẽ thành âm nếu bạn tiếp tục.';
	@override String get continueAnyway => 'Vẫn tiếp tục';
	@override String get checkAgain => 'Kiểm tra lại';
	@override String get transactionDeleted => 'Đã xóa giao dịch';
	@override String get transactionRestored => 'Đã khôi phục giao dịch';
	@override String get allocation => 'Phân bổ';
}

// Path: app.nav
class _Translations$app$nav$vi extends Translations$app$nav$en {
	_Translations$app$nav$vi._(TranslationsVi root) : this._root = root, super.internal(root);

	final TranslationsVi _root; // ignore: unused_field

	// Translations
	@override String get home => 'Trang chủ';
	@override String get transactions => 'Giao dịch';
	@override String get reports => 'Báo cáo';
	@override String get accounts => 'Tài khoản';
	@override String get settings => 'Cài đặt';
}

// Path: dashboard.insight
class _Translations$dashboard$insight$vi extends Translations$dashboard$insight$en {
	_Translations$dashboard$insight$vi._(TranslationsVi root) : this._root = root, super.internal(root);

	final TranslationsVi _root; // ignore: unused_field

	// Translations
	@override String get noData => 'Không có dữ liệu tháng này để phân tích.';
	@override String get thisMonth => 'tháng này là';
	@override String get up => 'tăng';
	@override String get down => 'giảm';
	@override String get same => 'bằng với';
	@override String get fromLastMonth => 'so với tháng trước.';
}

// Path: dashboard.days
class _Translations$dashboard$days$vi extends Translations$dashboard$days$en {
	_Translations$dashboard$days$vi._(TranslationsVi root) : this._root = root, super.internal(root);

	final TranslationsVi _root; // ignore: unused_field

	// Translations
	@override String get mon => 'T2';
	@override String get tue => 'T3';
	@override String get wed => 'T4';
	@override String get thu => 'T5';
	@override String get fri => 'T6';
	@override String get sat => 'T7';
	@override String get sun => 'CN';
}

/// The flat map containing all translations for locale <vi>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsVi {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'accounts.accountName' => 'Tên tài khoản',
			'accounts.pocketName' => 'Tên ví phụ',
			'accounts.initialBalance' => 'Số dư ban đầu',
			'accounts.icon' => 'Biểu tượng',
			'accounts.color' => 'Màu sắc',
			'accounts.assets' => 'Tài sản',
			'accounts.liability' => 'Nợ phải trả',
			'accounts.income' => 'Thu nhập',
			'accounts.expense' => 'Chi tiêu',
			'accounts.balance' => 'Số dư',
			'accounts.walletsPockets' => 'Ví & Ví phụ',
			'accounts.accounts' => 'Tài khoản',
			'accounts.mainAccounts' => 'Tài khoản chính',
			'accounts.deleteAccount' => 'Xóa tài khoản',
			'accounts.areYouSureYouWantToDeleteThisAccountItWillBeHiddenFromTheApp' => 'Bạn có chắc muốn xóa tài khoản này? Tài khoản sẽ bị ẩn khỏi ứng dụng.',
			'accounts.delete' => 'Xóa',
			'accounts.account' => 'Tài khoản',
			'accounts.totalBalance' => 'Tổng số dư',
			'accounts.pockets' => 'Ví phụ',
			'accounts.deletePocket' => 'Xóa ví phụ',
			'accounts.cannotDeleteMainPocket' => 'Không thể xóa ví phụ chính',
			'accounts.mainPocket' => 'Chính',
			'accounts.areYouSureYouWantToDeleteThisPocketItWillBeHiddenFromTheApp' => 'Bạn có chắc muốn xóa ví phụ này? Ví phụ sẽ bị ẩn khỏi ứng dụng.',
			'accounts.nameCannotBeEmpty' => 'Tên không được để trống',
			'accounts.egMainWallet' => 'ví dụ: Ví chính',
			'accounts.egPocket' => 'ví dụ: Đi chợ, Du lịch',
			'accounts.selectIcon' => 'Chọn biểu tượng',
			'accounts.allowedCategories' => 'Danh mục cho phép',
			'accounts.transactions' => 'Giao dịch',
			'accounts.editAccount' => 'Sửa tài khoản',
			'accounts.editPocket' => 'Sửa ví phụ',
			'accounts.updateNameIconOrColor' => 'Cập nhật tên, biểu tượng hoặc màu sắc',
			'accounts.permanentlyRemoveThisAccount' => 'Xóa vĩnh viễn tài khoản này',
			'accounts.seeAll' => 'Xem tất cả',
			'accounts.noTransactionsYet' => 'Chưa có giao dịch nào',
			'accounts.accountTransactionsSubtitle' => 'Các giao dịch ghi trong tài khoản này sẽ hiện ở đây.',
			'accounts.pocketTransactionsSubtitle' => 'Các giao dịch ghi trong ví phụ này sẽ hiện ở đây.',
			'accounts.addAccount' => 'Thêm tài khoản',
			'accounts.noAccountsFound' => 'Không tìm thấy tài khoản nào.',
			'accounts.addPocket' => 'Thêm ví phụ',
			'accounts.noPocketsYet' => 'Chưa có ví phụ nào',
			'accounts.pocketsHelpYouSplitYourWalletIntoCategories' => 'Ví phụ giúp bạn chia ví thành các nhóm riêng',
			'accounts.activeAccount' => 'Tài khoản đang dùng',
			'accounts.inactiveAccountsWillBeHidden' => 'Các tài khoản ngừng dùng sẽ bị ẩn',
			'accounts.noCategoriesAvailable' => 'Không có danh mục nào.',
			'accounts.noAccountsFound1' => 'Không tìm thấy tài khoản nào',
			'accounts.subcategoriesCount' => ({required Object count}) => '${count} danh mục con',
			'accounts.pocketsCount' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('vi'))(count, one: '1 ví phụ', other: '${count} ví phụ', ), 
			'accounts.totalActiveAccounts' => 'Tổng tài khoản đang dùng',
			'accounts.noAccountsYet' => 'Chưa có tài khoản nào',
			'accounts.tapTheButtonBelowToAddYourFirstAccount' => 'Nhấn nút bên dưới để thêm tài khoản đầu tiên',
			'accounts.allCategoriesAllowed' => 'Cho phép mọi danh mục',
			'accounts.categoriesSelected' => ({required Object count}) => 'Đã chọn ${count} danh mục',
			'accounts.ratioOfAccount' => ({required Object percent}) => '${percent}% của tài khoản',
			'accounts.noMainAccountsYet' => 'Chưa có tài khoản chính nào.',
			'accounts.percentOfAssets' => ({required Object percent}) => '${percent}% của tài sản',
			'accounts.recentTransactions' => 'Giao dịch gần đây',
			'accounts.recentTransactionsCount' => ({required Object count}) => 'Giao dịch gần đây (${count})',
			'accounts.reconcileBalance' => 'Đối soát số dư',
			'accounts.reconcileBalanceSubtitle' => 'Khớp số dư trong ứng dụng với số dư thực tế',
			'accounts.currentBalanceInPoka' => 'Số dư trong Poka',
			'accounts.actualBalance' => 'Số dư thực tế',
			'accounts.difference' => 'Chênh lệch',
			'accounts.adjustmentExpense' => 'Điều chỉnh (Chi)',
			'accounts.adjustmentIncome' => 'Điều chỉnh (Thu)',
			'accounts.balanceAdjustment' => 'Điều chỉnh số dư',
			'accounts.saveAdjustment' => 'Lưu điều chỉnh',
			'accounts.balancesMatch' => 'Số dư khớp nhau, không cần điều chỉnh',
			'accounts.noteOptional' => 'Ghi chú (Tùy chọn)',
			'accounts.reconcileAccount' => 'Đối soát số dư tài khoản',
			'app.name' => 'Poka',
			'app.tagline' => 'Người bạn đồng hành tài chính của bạn',
			'app.nav.home' => 'Trang chủ',
			'app.nav.transactions' => 'Giao dịch',
			'app.nav.reports' => 'Báo cáo',
			'app.nav.accounts' => 'Tài khoản',
			'app.nav.settings' => 'Cài đặt',
			'app.termsOfService' => 'Điều khoản sử dụng',
			'app.privacyPolicy' => 'Chính sách riêng tư',
			'backup.title' => 'Sao lưu & Khôi phục',
			'backup.backupAction' => 'Sao lưu',
			'backup.restoreAction' => 'Khôi phục',
			'backup.password' => 'Mật khẩu',
			'backup.confirmPassword' => 'Xác nhận mật khẩu',
			'backup.passwordsDoNotMatch' => 'Mật khẩu không khớp',
			'backup.backupSuccess' => 'Sao lưu thành công',
			'backup.restoreSuccess' => 'Khôi phục thành công',
			'backup.incorrectPassword' => 'Sai mật khẩu hoặc tệp bị lỗi',
			'backup.enterPasswordToEncrypt' => 'Nhập mật khẩu để mã hóa bản sao lưu',
			'backup.enterPasswordToDecrypt' => 'Nhập mật khẩu để giải mã bản sao lưu',
			'backup.pleaseRestart' => 'Vui lòng khởi động lại ứng dụng để áp dụng thay đổi.',
			'backup.passwordRequired' => 'Vui lòng nhập mật khẩu',
			'backup.reminder' => 'Nhắc sao lưu',
			'backup.reminderDesc' => 'Nhắc bạn sao lưu dữ liệu định kỳ',
			'backup.reminderOff' => 'Tắt',
			'backup.reminderWeekly' => 'Hằng tuần',
			'backup.reminderMonthly' => 'Hằng tháng',
			'backup.reminderNotificationTitle' => 'Đã đến lúc sao lưu dữ liệu',
			'backup.reminderNotificationBody' => 'Đã lâu kể từ lần sao lưu gần nhất. Hãy tạo bản sao lưu ngay để bảo vệ dữ liệu tài chính của bạn.',
			'backup.reminderSaved' => 'Đã cập nhật nhắc sao lưu',
			'backup.restoreWarningDesc' => 'Khôi phục sẽ thay thế toàn bộ dữ liệu hiện tại bằng dữ liệu trong tệp sao lưu đã chọn. Các thay đổi chưa sao lưu sẽ bị mất. Bạn có muốn tiếp tục?',
			'backup.sendTestNotification' => 'Gửi thông báo thử',
			'backup.testNotificationSent' => 'Đã gửi thông báo nhắc thử',
			'backup.permissionRationaleTitle' => 'Nhắc sao lưu cục bộ',
			'backup.permissionRationaleDesc' => 'Poka cần quyền thông báo để nhắc bạn sao lưu dữ liệu định kỳ. Nhắc nhở chạy hoàn toàn ngoại tuyến trên thiết bị, không theo dõi hay phân tích.',
			'backup.allowNotifications' => 'Cho phép thông báo',
			'backup.permissionDenied' => 'Quyền thông báo đã bị từ chối. Nhắc nhở vẫn đang tắt.',
			'budgets.budgetName' => 'Tên ngân sách',
			'budgets.spendingLimit' => 'Hạn mức chi tiêu',
			'budgets.period' => 'Kỳ hạn',
			'budgets.resetDay' => 'Ngày đặt lại (1–31)',
			'budgets.createBudget' => 'Tạo ngân sách',
			'budgets.endDate' => 'Ngày kết thúc',
			'budgets.budgetDetails' => 'Chi tiết ngân sách',
			'budgets.deleteBudget' => 'Xóa ngân sách',
			'budgets.areYouSureYouWantToDeleteThisBudgetAllRelatedTrackingHistoryWillBePermanentlyDeletedThisActionCannotBeUndone' => 'Bạn có chắc muốn xóa ngân sách này? Toàn bộ lịch sử theo dõi liên quan sẽ bị xóa vĩnh viễn. Hành động này không thể hoàn tác.',
			'budgets.delete' => 'Xóa',
			'budgets.transactions' => 'Giao dịch',
			'budgets.budgets' => 'Ngân sách',
			'budgets.allBudgets' => 'Tất cả ngân sách',
			'budgets.egGroceriesEntertainment' => 'ví dụ: Đi chợ, Giải trí',
			'budgets.eg80' => 'ví dụ: 80',
			'budgets.category' => 'Danh mục',
			'budgets.account' => 'Tài khoản',
			'budgets.overLimit' => 'Vượt hạn mức',
			'budgets.remaining' => 'Còn lại',
			'budgets.totalSpent' => 'Tổng đã chi',
			'budgets.totalLimit' => 'Tổng hạn mức',
			'budgets.selectEndDate' => 'Chọn ngày kết thúc',
			'budgets.noTransactionsFoundForThisBudgetPeriod' => 'Không tìm thấy giao dịch nào trong kỳ ngân sách này.',
			'budgets.budgetTransactionsSubtitle' => 'Các giao dịch thuộc ngân sách này sẽ hiện ở đây.',
			'budgets.addBudget' => 'Thêm ngân sách',
			'budgets.spent' => 'Đã chi ',
			'budgets.noBudgetsYet' => 'Chưa có ngân sách nào',
			'budgets.setSpendingLimitsToTrackWhereYourMoneyGoesEachPeriod' => 'Đặt hạn mức chi tiêu để theo dõi tiền của bạn mỗi kỳ.',
			'budgets.budgetAlert' => ({required Object name}) => 'Cảnh báo ngân sách: ${name}',
			'budgets.percentOf' => ({required Object percent}) => '${percent}% của ',
			'budgets.budgetsCount' => ({required Object count}) => '${count} ngân sách',
			'budgets.editBudget' => 'Sửa ngân sách',
			'budgets.newBudget' => 'Ngân sách mới',
			'budgets.nameCannotBeEmpty' => 'Tên không được để trống',
			'budgets.amountGreaterThanZero' => 'Số tiền phải lớn hơn 0',
			'budgets.alertThresholdLabel' => 'Ngưỡng cảnh báo (%)',
			'budgets.scope' => 'Phạm vi',
			'budgets.anyCategory' => 'Mọi danh mục',
			'budgets.anyAccount' => 'Mọi tài khoản',
			'budgets.saveChanges' => 'Lưu thay đổi',
			'budgets.periodWeekly' => 'Hằng tuần',
			'budgets.periodMonthly' => 'Hằng tháng',
			'budgets.periodYearly' => 'Hằng năm',
			'budgets.periodCustom' => 'Tùy chỉnh',
			'budgets.budgetExceededAlert' => ({required Object percentage, required Object name}) => 'Bạn đã dùng ${percentage}% ngân sách ${name}.',
			'categories.expense' => 'Chi tiêu',
			'categories.income' => 'Thu nhập',
			'categories.categoryName' => 'Tên danh mục',
			'categories.icon' => 'Biểu tượng',
			'categories.color' => 'Màu sắc',
			'categories.noCategoriesFound' => 'Không tìm thấy danh mục nào.',
			'categories.subcategories' => 'Danh mục con',
			'categories.categories' => 'Danh mục',
			'categories.egFoodDining' => 'ví dụ: Ăn uống',
			'categories.deleteCategory' => 'Xóa danh mục',
			'categories.delete' => 'Xóa',
			'categories.selectIcon' => 'Chọn biểu tượng',
			'categories.noSubcategoriesYet' => 'Chưa có danh mục con nào',
			'categories.noCategoriesFound1' => 'Không tìm thấy danh mục nào',
			'categories.subcategoriesCount' => ({required Object count}) => '${count} danh mục con',
			'categories.addSubcategory' => 'Thêm danh mục con',
			'categories.addCategory' => 'Thêm danh mục',
			'categories.emptyCategorySubtitle' => 'Bắt đầu theo dõi chi tiêu bằng cách thêm danh mục',
			'categories.emptySubcategorySubtitle' => 'Chia nhỏ danh mục thành các phần chi tiết hơn',
			'categories.saveSubCategory' => 'Lưu danh mục con',
			'categories.saveCategory' => 'Lưu danh mục',
			'categories.newSubCategory' => 'Danh mục con mới',
			'categories.newCategory' => 'Danh mục mới',
			'categories.editSubCategory' => 'Sửa danh mục con',
			'categories.editCategory' => 'Sửa danh mục',
			'categories.deleteConfirmWithChildren' => ({required Object count}) => 'Bạn có chắc muốn xóa danh mục này? ${count} danh mục con của nó sẽ thành danh mục chính, và các giao dịch của nó sẽ thành chưa phân loại.',
			'categories.deleteConfirmNoChildren' => 'Bạn có chắc muốn xóa danh mục này? Mọi giao dịch của nó sẽ thành chưa phân loại.',
			'common.save' => 'Lưu',
			'common.cancel' => 'Hủy',
			'common.delete' => 'Xóa',
			'common.edit' => 'Sửa',
			'common.confirm' => 'Xác nhận',
			'common.back' => 'Quay lại',
			'common.loading' => 'Đang tải...',
			'common.error' => 'Đã xảy ra lỗi',
			'common.retry' => 'Thử lại',
			'common.empty' => 'Chưa có dữ liệu',
			'common.cannotBeUndone' => 'Hành động này không thể hoàn tác.',
			'common.pleaseWait' => 'Vui lòng chờ',
			'common.today' => 'Hôm nay',
			'common.yesterday' => 'Hôm qua',
			'common.dueToday' => 'Đến hạn hôm nay',
			'common.overdue' => 'Quá hạn',
			'common.uncategorized' => 'Chưa phân loại',
			'common.unknown' => 'Không rõ',
			'common.notSet' => 'Chưa đặt',
			'common.undo' => 'Hoàn tác',
			'dashboard.overview' => 'Tổng quan',
			'dashboard.myFinances' => 'Tài chính của tôi',
			'dashboard.netWorth' => 'Giá trị ròng',
			'dashboard.accountsCount' => ({required Object count}) => '${count} tài khoản',
			'dashboard.assets' => 'Tài sản',
			'dashboard.liabilities' => 'Nợ phải trả',
			'dashboard.budgets' => 'Ngân sách',
			'dashboard.categories' => 'Danh mục',
			'dashboard.goals' => 'Mục tiêu',
			'dashboard.debts' => 'Nợ',
			'dashboard.recurring' => 'Định kỳ',
			'dashboard.cashFlow' => 'Dòng tiền',
			'dashboard.budget' => 'Ngân sách',
			'dashboard.needs' => 'Nhu cầu (50%)',
			'dashboard.wants' => 'Mong muốn (30%)',
			'dashboard.savings' => 'Tiết kiệm (20%)',
			'dashboard.saved' => 'đã tiết kiệm',
			'dashboard.onTrack' => 'Đúng tiến độ',
			'dashboard.needsAttention' => 'Cần chú ý',
			'dashboard.income' => 'Thu nhập',
			'dashboard.expense' => 'Chi tiêu',
			'dashboard.other' => 'Khác',
			'dashboard.noData' => 'Không có dữ liệu',
			'dashboard.spendingActivity' => 'Hoạt động chi tiêu',
			'dashboard.total' => 'Tổng cộng',
			'dashboard.average' => 'Trung bình',
			'dashboard.budgetPerDay' => 'Ngân sách/Ngày',
			'dashboard.todaysBudget' => 'Ngân sách hôm nay',
			'dashboard.overbudget' => 'Vượt ngân sách!',
			'dashboard.setDailyBudget' => 'Đặt ngân sách ngày',
			'dashboard.amount' => 'Số tiền',
			'dashboard.amountHint' => 'ví dụ: 100000',
			'dashboard.recentTransactions' => 'Giao dịch gần đây',
			'dashboard.thisMonth' => 'Tháng này',
			'dashboard.noRecentTransactions' => 'Không có giao dịch gần đây',
			'dashboard.recentTransactionsSubtitle' => 'Các giao dịch bạn mới ghi sẽ hiện ở đây.',
			'dashboard.seeAll' => 'Xem tất cả',
			'dashboard.notSet' => 'Chưa đặt',
			'dashboard.insight.noData' => 'Không có dữ liệu tháng này để phân tích.',
			'dashboard.insight.thisMonth' => 'tháng này là',
			'dashboard.insight.up' => 'tăng',
			'dashboard.insight.down' => 'giảm',
			'dashboard.insight.same' => 'bằng với',
			'dashboard.insight.fromLastMonth' => 'so với tháng trước.',
			'dashboard.days.mon' => 'T2',
			'dashboard.days.tue' => 'T3',
			'dashboard.days.wed' => 'T4',
			'dashboard.days.thu' => 'T5',
			'dashboard.days.fri' => 'T6',
			'dashboard.days.sat' => 'T7',
			'dashboard.days.sun' => 'CN',
			'debts.addRepayment' => 'Thêm khoản trả',
			'debts.iOwe' => 'Tôi nợ',
			'debts.theyOwe' => 'Họ nợ',
			'debts.personName' => 'Tên người',
			'debts.principalAmount' => 'Số tiền gốc',
			'debts.transactionBinding' => 'Liên kết giao dịch',
			'debts.cancel' => 'Hủy',
			'debts.save' => 'Lưu',
			'debts.ok' => 'OK',
			'debts.addRecord' => 'Thêm bản ghi',
			'debts.createRecord' => 'Tạo bản ghi',
			'debts.debtDetails' => 'Chi tiết khoản nợ',
			'debts.repaymentHistory' => 'Lịch sử trả nợ',
			'debts.debtsLoans' => 'Nợ & Cho vay',
			'debts.deleteDebt' => 'Xóa khoản nợ',
			'debts.delete' => 'Xóa',
			'debts.writeoffDebt' => 'Xóa sổ khoản nợ',
			'debts.areYouSureYouWantToWriteoffThisDebtItWillBeMarkedAsPaidWithoutAffectingYourWalletBalances' => 'Bạn có chắc muốn xóa sổ khoản nợ này? Nó sẽ được đánh dấu là đã trả mà không ảnh hưởng đến số dư ví của bạn.',
			'debts.writeoff' => 'Xóa sổ',
			'debts.egJohnDoe' => 'ví dụ: Nguyễn Văn A',
			'debts.category' => 'Danh mục',
			'debts.account' => 'Tài khoản',
			'debts.egDinnerLastFriday' => 'ví dụ: Bữa tối thứ Sáu tuần trước',
			'debts.selectDueDate' => 'Chọn ngày đến hạn',
			'debts.outstanding' => 'Còn nợ',
			'debts.paid' => 'Đã trả',
			'debts.principal' => 'Tiền gốc',
			'debts.actionDenied' => 'Hành động bị từ chối',
			'debts.paymentCannotExceedRemaining' => 'Số tiền trả không được vượt quá số nợ còn lại.',
			'debts.addNote' => 'Thêm ghi chú',
			'debts.payInFull' => 'Trả toàn bộ',
			'debts.remaining' => 'còn lại',
			'debts.paid1' => 'Đã trả ',
			'debts.reminder' => ({required Object type, required Object name}) => 'Nhắc nhở ${type}: ${name}',
			'debts.due' => ({required Object type, required Object name}) => '${type} đến hạn: ${name}',
			'debts.noHistoryFoundForThis' => ({required Object type}) => 'Không tìm thấy lịch sử cho ${type} này',
			'debts.repaymentHistorySubtitle' => ({required Object type}) => 'Các bản ghi thanh toán cho ${type} này sẽ hiện ở đây.',
			'debts.failedToLoadDebts' => ({required Object error}) => 'Tải khoản nợ thất bại: ${error}',
			'debts.percentOf' => ({required Object percent}) => '${percent}% của ',
			'debts.settled' => ({required Object count}) => '${count} đã xong',
			'debts.payable' => 'Phải trả',
			'debts.receivable' => 'Phải thu',
			'debts.noDebtsRecorded' => 'Chưa ghi khoản nợ nào',
			'debts.noLoansRecorded' => 'Chưa ghi khoản cho vay nào',
			'debts.trackMoneyYouOweToOthersAndLogRepayments' => 'Theo dõi tiền bạn nợ người khác và dễ dàng ghi lại mọi khoản trả ở đây.',
			'debts.trackMoneyOthersOweYouAndLogCollections' => 'Theo dõi tiền người khác nợ bạn và dễ dàng ghi lại mọi khoản thu ở đây.',
			'debts.editRecord' => 'Sửa bản ghi',
			'debts.newRecord' => 'Bản ghi mới',
			'debts.personNameCannotBeEmpty' => 'Tên người không được để trống',
			'debts.amountGreaterThanZero' => 'Số tiền phải lớn hơn 0',
			'debts.selectCategoryAndAccount' => 'Vui lòng chọn danh mục và tài khoản',
			'debts.selectCategoryPrompt' => 'Chọn danh mục',
			'debts.selectAccountPrompt' => 'Chọn tài khoản',
			'debts.debtBindingHelp' => 'Ghi khoản nợ này sẽ cộng tiền vào tài khoản (giao dịch thu).',
			'debts.loanBindingHelp' => 'Ghi khoản cho vay này sẽ trừ tiền khỏi tài khoản (giao dịch chi).',
			'debts.noteLabel' => 'Ghi chú',
			'debts.dueDateLabel' => 'Ngày đến hạn',
			'debts.saveChanges' => 'Lưu thay đổi',
			'debts.deleteConfirm' => ({required Object type}) => 'Bạn có chắc muốn xóa ${type} này? Bản ghi của nó sẽ bị xóa vĩnh viễn. Hành động này không thể hoàn tác.',
			'debts.debtDetailsTitle' => ({required Object type}) => 'Chi tiết ${type}',
			'debts.debtTypeLoan' => 'Khoản cho vay',
			'debts.debtTypeDebt' => 'Khoản nợ',
			'debts.reminderAlert' => ({required Object type, required Object amount, required Object action, required Object when}) => '${type} số tiền ${amount} phải được ${action} ${when}.',
			'debts.overdueAlert' => ({required Object type, required Object amount, required Object action}) => '${type} số tiền ${amount} đã quá hạn và phải được ${action} ngay.',
			'debts.actionCollect' => 'thu',
			'debts.actionPay' => 'trả',
			'debts.today' => 'hôm nay',
			'debts.inDays' => ({required Object days}) => 'trong ${days} ngày nữa',
			'debts.owedCount' => ({required Object count}) => '${count} khoản nợ',
			'debts.receivableCount' => ({required Object count}) => '${count} khoản phải thu',
			'error.generic' => 'Đã xảy ra lỗi không mong muốn',
			'error.network' => 'Vui lòng kiểm tra kết nối và thử lại',
			'error.database' => 'Không thể truy cập dữ liệu cục bộ',
			'goals.goals' => 'Mục tiêu',
			'goals.fulfillGoal' => 'Hoàn thành mục tiêu (Chi)',
			'goals.goalName' => 'Tên mục tiêu',
			'goals.targetAmount' => 'Số tiền mục tiêu',
			'goals.createGoal' => 'Tạo mục tiêu',
			'goals.errorPrefix' => ({required Object error}) => 'Lỗi: ${error}',
			'goals.goalDetails' => 'Chi tiết mục tiêu',
			'goals.transactions' => 'Giao dịch',
			'goals.active' => 'Đang thực hiện',
			'goals.past' => 'Đã qua',
			'goals.actionDenied' => 'Hành động bị từ chối',
			'goals.emptyBalanceBeforeDelete' => 'Hãy rút hết số dư (chuyển ra ngoài) trước khi xóa Mục tiêu này.',
			'goals.ok' => 'OK',
			'goals.deleteGoal' => 'Xóa mục tiêu',
			'goals.areYouSureYouWantToDeleteThisGoalTheAssociatedPocketAccountAndItsHistoryWillAlsoBeRemovedThisActionCannotBeUndone' => 'Bạn có chắc muốn xóa mục tiêu này? Tài khoản ví phụ liên quan và lịch sử của nó cũng sẽ bị xóa. Hành động này không thể hoàn tác.',
			'goals.delete' => 'Xóa',
			'goals.egEmergencyFundNewLaptop' => 'ví dụ: Quỹ khẩn cấp, Laptop mới',
			'goals.completed' => 'Đã hoàn thành',
			'goals.fullyFunded' => 'Đã đủ tiền',
			'goals.inProgress' => 'Đang thực hiện',
			'goals.totalSaved' => 'Tổng đã tiết kiệm',
			'goals.stillNeeded' => 'Còn cần thêm',
			'goals.totalTarget' => 'Tổng mục tiêu',
			'goals.selectTargetDate' => 'Chọn ngày mục tiêu',
			'goals.noTransactionsFoundForThisGoal' => 'Không tìm thấy giao dịch nào cho mục tiêu này.',
			'goals.goalTransactionsSubtitle' => 'Các khoản chuyển hoặc tiết kiệm cho mục tiêu này sẽ hiện ở đây.',
			'goals.addGoal' => 'Thêm mục tiêu',
			'goals.aDedicatedPocketAccountWillBeCreatedAutomaticallyToTrackThisGoal' => 'Một tài khoản ví phụ riêng sẽ được tạo tự động để theo dõi mục tiêu này.',
			'goals.saved' => 'đã tiết kiệm',
			'goals.needs' => 'Cần thêm ',
			'goals.more' => ' nữa',
			'goals.noGoalsYet' => 'Chưa có mục tiêu nào',
			'goals.setSavingsTargetsADedicatedPocketIsCreatedAutomaticallyForEachGoal' => 'Đặt mục tiêu tiết kiệm — mỗi mục tiêu sẽ có một ví phụ riêng được tạo tự động.',
			'goals.percentOfTarget' => ({required Object percent}) => '${percent}% của mục tiêu',
			'goals.goalsCount' => ({required Object count}) => '${count} mục tiêu',
			'goals.fullyFundedCount' => ({required Object count}) => '${count} đã đủ tiền',
			'goals.noCompletedGoalsYet' => 'Chưa có mục tiêu hoàn thành nào',
			'goals.completedGoalsWillAppearHere' => 'Các mục tiêu bạn hoàn thành sẽ hiện ở đây.',
			'goals.editGoal' => 'Sửa mục tiêu',
			'goals.newGoal' => 'Mục tiêu mới',
			'goals.nameCannotBeEmpty' => 'Tên không được để trống',
			'goals.targetAmountGreaterThanZero' => 'Số tiền mục tiêu phải lớn hơn 0',
			'goals.saveChanges' => 'Lưu thay đổi',
			'goals.targetDateLabel' => 'Ngày mục tiêu',
			'goals.activeGoals' => 'Mục tiêu đang thực hiện',
			'goals.completedGoals' => 'Mục tiêu đã hoàn thành',
			'goals.noActiveGoalsYet' => 'Chưa có mục tiêu đang thực hiện',
			'goals.noActiveGoalsSubtitle' => 'Tạo mục tiêu mới để bắt đầu tiết kiệm cho cột mốc tiếp theo.',
			'goals.saveInAccount' => 'Tiết kiệm trong tài khoản',
			'goals.selectAccount' => 'Chọn tài khoản',
			'goals.accountRequired' => 'Vui lòng chọn tài khoản',
			'goals.storedIn' => ({required Object account}) => 'Lưu trong ${account}',
			'lock.confirmPin' => 'Xác nhận PIN',
			'lock.createPin' => 'Tạo PIN',
			'lock.pinsDoNotMatch' => 'PIN không khớp',
			'lock.reenterPin' => 'Nhập lại PIN',
			'lock.enterPinAppLock' => 'Nhập PIN để mở khóa ứng dụng',
			'lock.incorrectPin' => 'Sai PIN',
			'lock.verifyIdentity' => 'Xác minh danh tính',
			'lock.retryInSeconds' => ({required Object seconds}) => 'Thử lại sau ${seconds} giây',
			'lock.setupPinTitle' => 'Thiết lập PIN',
			'lock.setupPinBody' => 'Vui lòng tạo PIN trước khi bật Khóa ứng dụng hoặc Sinh trắc học.',
			'lock.unlocked' => 'Đã mở khóa',
			'lock.enter6DigitPin' => 'Nhập PIN 6 chữ số',
			'lock.enterPin' => 'Nhập PIN',
			'lock.invalidPin' => 'PIN không hợp lệ',
			'lock.tooManyAttempts' => 'Quá nhiều lần thử',
			'lock.temporarilyLocked' => 'Tạm thời bị khóa',
			'lock.authenticateReason' => 'Xác thực để truy cập Poka',
			'onboarding.continueWithCurrency' => 'Tiếp tục với đơn vị tiền đã chọn',
			'onboarding.chooseYourBaseCurrency' => 'Chọn đơn vị tiền cơ bản',
			'onboarding.thisCurrencyWillBeUsedForAllAccountsPocketsAndTransactionsYouCanChangeThisLaterInSettings' => 'Đơn vị tiền này sẽ dùng cho mọi tài khoản, ví phụ và giao dịch. Bạn có thể đổi lại trong Cài đặt.',
			'recurring.addSchedule' => 'Thêm lịch',
			'recurring.transactionDetails' => 'Chi tiết giao dịch',
			'recurring.amount' => 'Số tiền',
			'recurring.frequency' => 'Tần suất',
			'recurring.startDate' => 'Ngày bắt đầu',
			'recurring.recurring' => 'Định kỳ',
			'recurring.schedules' => 'Lịch định kỳ',
			'recurring.scheduleDetails' => 'Chi tiết lịch',
			'recurring.deleteSchedule' => 'Xóa lịch',
			'recurring.areYouSureYouWantToDeleteThisRecurringScheduleExistingGeneratedTransactionsWillNotBeDeleted' => 'Bạn có chắc muốn xóa lịch định kỳ này? Các giao dịch đã tạo trước đó sẽ không bị xóa.',
			'recurring.delete' => 'Xóa',
			'recurring.triggerHistory' => 'Lịch sử thực hiện',
			'recurring.destinationAccount' => 'Tài khoản nhận',
			'recurring.category' => 'Danh mục',
			'recurring.egNetflixSubscription' => 'ví dụ: Gói Netflix',
			'recurring.selectFirstDueDate' => 'Chọn ngày đến hạn đầu tiên',
			'recurring.estMonthlyNet' => 'Ròng hằng tháng (ước tính)',
			'recurring.monthlyIn' => 'Thu hằng tháng',
			'recurring.monthlyOut' => 'Chi hằng tháng',
			'recurring.noRecurringTransactions' => 'Chưa có giao dịch định kỳ',
			'recurring.automateBillsLikeSubscriptionsOrSalary' => 'Tự động hóa hóa đơn như gói đăng ký hay lương. Ứng dụng sẽ ghi chúng đúng lịch.',
			'recurring.noHistoryFoundForThisSchedule' => 'Không tìm thấy lịch sử cho lịch này.',
			'recurring.scheduleHistorySubtitle' => 'Các giao dịch tạo từ lịch này sẽ hiện ở đây.',
			'recurring.allocation' => 'Phân bổ',
			'recurring.active' => 'Đang bật',
			'recurring.eachTimeTheAppOpensOverdueRecurringTransactionsAre' => 'Mỗi lần mở ứng dụng, các giao dịch định kỳ quá hạn sẽ tự động được ghi vào sổ.',
			'recurring.schedulesCount' => ({required Object count}) => '${count} lịch',
			'recurring.pausedCount' => ({required Object count}) => '${count} đã tạm dừng',
			'recurring.editRecurring' => 'Sửa định kỳ',
			'recurring.newRecurring' => 'Định kỳ mới',
			'recurring.mustSelectAccount' => 'Phải chọn tài khoản',
			'recurring.sourceAccount' => 'Tài khoản nguồn',
			'recurring.account' => 'Tài khoản',
			'recurring.selectAccountPrompt' => 'Chọn tài khoản',
			'recurring.selectDestinationPrompt' => 'Chọn nơi nhận',
			'recurring.selectCategoryOptional' => 'Chọn danh mục (tùy chọn)',
			'recurring.noteLabel' => 'Ghi chú',
			'recurring.saveChanges' => 'Lưu thay đổi',
			'recurring.createRecurring' => 'Tạo định kỳ',
			'recurring.amountGreaterThanZero' => 'Số tiền phải lớn hơn 0',
			'recurring.mustSelectStartDate' => 'Phải chọn ngày bắt đầu',
			'recurring.periodDaily' => 'Hằng ngày',
			'recurring.periodWeekly' => 'Hằng tuần',
			'recurring.periodMonthly' => 'Hằng tháng',
			'recurring.periodYearly' => 'Hằng năm',
			'recurring.autoGenerateActive' => 'Sẽ tự động tạo giao dịch',
			'recurring.autoGeneratePaused' => 'Đã tạm dừng — sẽ không tạo giao dịch nào',
			'recurring.recurringIncome' => 'Thu nhập định kỳ',
			'recurring.recurringExpense' => 'Chi tiêu định kỳ',
			'recurring.recurringTransfer' => 'Chuyển khoản định kỳ',
			'recurring.nextDateLabel' => ({required Object date}) => 'Tiếp theo: ${date}',
			'reports.title' => 'Báo cáo',
			'reports.overview' => 'Tổng quan tài chính',
			'reports.tabCashflow' => 'Dòng tiền',
			'reports.tabBudgets' => 'Ngân sách & Mục tiêu',
			'reports.period' => 'Kỳ',
			'reports.thisMonth' => 'Tháng này',
			'reports.lastMonth' => 'Tháng trước',
			'reports.last3Months' => '3 tháng',
			'reports.last6Months' => '6 tháng',
			'reports.custom' => 'Tùy chỉnh',
			'reports.income' => 'Thu nhập',
			'reports.expense' => 'Chi tiêu',
			'reports.netSavings' => 'Tiết kiệm ròng',
			'reports.netCashflow' => 'Dòng tiền ròng',
			'reports.cashflow' => 'Dòng tiền',
			'reports.savingsRate' => 'Tỷ lệ tiết kiệm',
			'reports.topCategories' => 'Danh mục nổi bật',
			'reports.topExpenses' => 'Khoản chi lớn nhất',
			'reports.topIncome' => 'Khoản thu lớn nhất',
			'reports.monthlyTrend' => 'Xu hướng hằng tháng',
			'reports.cashflowTrend' => 'Xu hướng thu so với chi',
			'reports.budgetBreakdown' => 'Chi tiết ngân sách',
			'reports.budgetUtilization' => 'Mức sử dụng ngân sách',
			'reports.spendingAllocation' => 'Phân bổ chi tiêu',
			'reports.noData' => 'Không có dữ liệu trong kỳ này',
			'reports.noExpenseDataDesc' => 'Ghi giao dịch chi để xem phân bổ chi tiêu của bạn.',
			'reports.noBudgets' => 'Chưa có ngân sách nào',
			'reports.noBudgetsDesc' => 'Thêm ngân sách để theo dõi hạn mức chi tiêu',
			'reports.onTrack' => 'Đúng tiến độ',
			'reports.needsAttention' => 'Cần chú ý',
			'reports.overBudget' => 'Vượt ngân sách',
			'reports.onBudget' => 'Trong hạn mức',
			'reports.needs' => 'Nhu cầu',
			'reports.wants' => 'Mong muốn',
			'reports.savings' => 'Tiết kiệm',
			'reports.other' => 'Khác',
			'reports.total' => 'Tổng cộng',
			'reports.average' => 'Trung bình',
			'reports.remaining' => 'Còn lại',
			'reports.spent' => 'Đã chi',
			'reports.limit' => 'Hạn mức',
			'reports.txCount' => ({required Object count}) => '${count} giao dịch',
			'reports.selectDateRange' => 'Chọn khoảng ngày',
			'reports.apply' => 'Áp dụng',
			'reports.from' => 'Từ',
			'reports.to' => 'Đến',
			'reports.comparedTo' => ({required Object period}) => 'so với ${period}',
			'reports.higher' => 'cao hơn',
			'reports.lower' => 'thấp hơn',
			'reports.same' => 'bằng với',
			'reports.noChange' => 'Không thay đổi',
			'reports.percent50' => '50%',
			'reports.percent30' => '30%',
			'reports.percent20' => '20%',
			'reports.rule503020' => '50/30/20',
			'reports.prevLastMonth' => 'tháng trước',
			'reports.prevMonth' => 'tháng trước',
			'reports.prev3Months' => '3 tháng trước',
			'reports.prev6Months' => '6 tháng trước',
			'reports.prevPeriod' => 'kỳ trước',
			'reports.exportExcel' => 'Xuất ra Excel',
			'reports.exportExcelSuccess' => 'Xuất Excel thành công',
			'reports.exportExcelError' => 'Xuất tệp Excel thất bại',
			'settings.title' => 'Cài đặt',
			'settings.preferences' => 'Tùy chọn',
			'settings.baseCurrency' => 'Đơn vị tiền cơ bản',
			_ => null,
		} ?? switch (path) {
			'settings.theme' => 'Giao diện',
			'settings.language' => 'Ngôn ngữ',
			'settings.numberFormat' => 'Định dạng số',
			'settings.selectNumberFormat' => 'Chọn định dạng số',
			'settings.formatSystem' => 'Mặc định ứng dụng',
			'settings.formatId' => '1.000.000,00',
			'settings.formatUs' => '1,000,000.00',
			'settings.formatFr' => '1 000 000,00',
			'settings.system' => 'Hệ thống',
			'settings.english' => 'English',
			'settings.indonesia' => 'Indonesia',
			'settings.malay' => 'Bahasa Melayu',
			'settings.vietnam' => 'Tiếng Việt',
			'settings.security' => 'Bảo mật',
			'settings.appLock' => 'Khóa ứng dụng',
			'settings.appLockDesc' => 'Bảo vệ ứng dụng bằng PIN',
			'settings.biometrics' => 'Sinh trắc học',
			'settings.biometricsDesc' => 'Dùng vân tay để mở khóa',
			'settings.dataManagement' => 'Quản lý dữ liệu',
			'settings.backupRestore' => 'Sao lưu & Khôi phục',
			'settings.backupRestoreDesc' => 'Lưu hoặc khôi phục dữ liệu của bạn',
			'settings.clearOld' => 'Xóa giao dịch cũ',
			'settings.clearOldDesc' => 'Xóa các giao dịch cũ hơn 1 năm',
			'settings.resetData' => 'Đặt lại dữ liệu',
			'settings.resetDataDesc' => 'Xóa toàn bộ dữ liệu ứng dụng cục bộ',
			'settings.support' => 'Hỗ trợ',
			'settings.faq' => 'Câu hỏi thường gặp',
			'settings.faqDesc' => 'Các câu hỏi thường gặp',
			'settings.about' => 'Về Poka CE',
			'settings.aboutDesc' => 'Thông tin phiên bản và pháp lý',
			'settings.selectTheme' => 'Chọn giao diện',
			'settings.themeLight' => 'Sáng',
			'settings.themeDark' => 'Tối',
			'settings.selectLanguage' => 'Chọn ngôn ngữ',
			'settings.oldTransactionsCleared' => 'Đã xóa giao dịch cũ thành công',
			'settings.appDataReset' => 'Đã đặt lại dữ liệu ứng dụng thành công',
			'settings.failedToExportLogs' => 'Xuất nhật ký thất bại',
			'settings.easterEggRemaining' => ({required Object remaining}) => 'Còn ${remaining} lần chạm nữa là có bất ngờ...',
			'settings.easterEggFound' => '🎉 Bạn đã tìm thấy easter egg!',
			'settings.selectCurrency' => 'Chọn đơn vị tiền',
			'settings.openSourceLicenses' => 'Giấy phép mã nguồn mở',
			'settings.checkForUpdates' => 'Kiểm tra cập nhật',
			'settings.viewLatestReleasesOnGithub' => 'Xem bản phát hành mới nhất trên GitHub',
			'settings.helpIssues' => 'Trợ giúp & Sự cố',
			'settings.reportBugsOrRequestFeatures' => 'Báo lỗi hoặc đề xuất tính năng',
			'settings.legal' => 'Pháp lý',
			'settings.termsOfService' => 'Điều khoản sử dụng',
			'settings.readOurTermsAndConditions' => 'Đọc điều khoản và điều kiện của chúng tôi',
			'settings.privacyPolicy' => 'Chính sách riêng tư',
			'settings.learnHowWeHandleYourData' => 'Tìm hiểu cách chúng tôi xử lý dữ liệu của bạn',
			'settings.viewThirdpartySoftwareLicenses' => 'Xem giấy phép phần mềm bên thứ ba',
			'settings.advanced' => 'Nâng cao',
			'settings.exportDebugLogs' => 'Xuất nhật ký gỡ lỗi',
			'settings.shareErrorLogsForTroubleshooting' => 'Chia sẻ nhật ký lỗi để khắc phục sự cố',
			'settings.search' => 'Tìm kiếm...',
			'settings.errorLoadingContent' => 'Tải nội dung thất bại',
			'settings.noLicensesFound' => 'Không tìm thấy giấy phép nào',
			'settings.pokaCe' => 'Poka CE',
			'settings.communityEdition' => 'Phiên bản cộng đồng',
			'settings.aboutDescription' => 'Trình quản lý tài chính cá nhân mã nguồn mở, miễn phí, giúp bạn theo dõi chi tiêu, quản lý ngân sách và giám sát tài khoản ngay trên thiết bị.',
			'settings.copyright' => '© 2026 POKA. All rights reserved.',
			'settings.noResultsFound' => 'Không tìm thấy kết quả',
			'settings.weCouldntFindAnyCurrencyMatching' => 'Không tìm thấy đơn vị tiền nào khớp với "{search}".',
			'settings.notSet' => 'Chưa đặt',
			'settings.exportExcel' => 'Xuất ra Excel',
			'settings.exportExcelDesc' => 'Xuất giao dịch, tài khoản và danh mục ra tệp .xlsx',
			'settings.exportExcelSuccess' => 'Xuất Excel thành công',
			'settings.exportExcelError' => 'Xuất tệp Excel thất bại',
			'settings.currencyLockedToast' => 'Không thể thay đổi tiền tệ sau khi có giao dịch. Vui lòng thiết lập lại dữ liệu nếu bạn muốn thay đổi.',
			'shared.authRequired' => 'Yêu cầu xác thực',
			'shared.hexColorCode' => 'Mã màu Hex',
			'shared.apply' => 'Áp dụng',
			'shared.enterAmount' => 'Nhập số tiền',
			'shared.selectCategory' => 'Chọn danh mục',
			'shared.egFf5733' => 'ví dụ: FF5733',
			'shared.amount' => 'Số tiền',
			'shared.noCategoriesAvailable' => 'Không có danh mục nào.',
			'shared.noWalletsFoundPleaseCreateOneFirst' => 'Không tìm thấy ví nào. Vui lòng tạo ví trước.',
			'shared.balance' => 'Số dư: ',
			'shared.optional' => 'Tùy chọn',
			'shared.customColor' => 'Màu tùy chỉnh',
			'shared.selectWallet' => 'Chọn ví',
			'transactions.searchTransactions' => 'Tìm kiếm giao dịch...',
			'transactions.failedToLoad' => 'Tải giao dịch thất bại',
			'transactions.cancel' => 'Hủy',
			'transactions.delete' => 'Xóa',
			'transactions.goToToday' => 'Về hôm nay',
			'transactions.addItem' => 'Thêm mục',
			'transactions.saveSplitTransaction' => 'Lưu giao dịch tách',
			'transactions.transactionType' => 'Loại giao dịch',
			'transactions.applyFilter' => 'Áp dụng bộ lọc',
			'transactions.noAccountsAvailable' => 'Không có tài khoản nào',
			'transactions.account' => 'Tài khoản',
			'transactions.category' => 'Danh mục',
			'transactions.done' => 'Xong',
			'transactions.save' => 'Lưu',
			'transactions.transactions' => 'Giao dịch',
			'transactions.splitTransaction' => 'Tách giao dịch',
			'transactions.from' => 'Từ',
			'transactions.to' => 'Đến',
			'transactions.empty' => '+/-',
			'transactions.filtered' => 'Đã lọc',
			'transactions.netBalance' => 'Số dư ròng',
			'transactions.income' => 'Thu nhập',
			'transactions.expense' => 'Chi tiêu',
			'transactions.selectCategory' => 'Chọn danh mục',
			'transactions.filter' => 'Lọc',
			'transactions.backToToday' => 'Về hôm nay',
			'transactions.deleteTransaction' => 'Xóa giao dịch',
			'transactions.deleteTransactionWarning' => 'Xóa giao dịch này sẽ hoàn lại số dư tài khoản và ngân sách về trạng thái trước đó.',
			'transactions.out' => 'Chi ',
			'transactions.noTransactions' => 'Không có giao dịch',
			'transactions.addNote' => 'Thêm ghi chú',
			'transactions.noItemsYet' => 'Chưa có mục nào',
			'transactions.tapAddItemToBeginSplittingntheTransaction' => 'Nhấn "Thêm mục" để bắt đầu tách\ngiao dịch.',
			'transactions.addAtLeastOneMoreItemToSave' => 'Thêm ít nhất một mục nữa để lưu.',
			'transactions.noTransactions1' => 'Không có giao dịch',
			'transactions.reset' => 'Đặt lại',
			'transactions.incoming' => 'Thu ',
			'transactions.nothingRecordedFor' => ({required Object period}) => 'Chưa ghi gì cho ${period}.',
			'transactions.splitItems' => ({required Object count}) => '${count} mục đã tách',
			'transactions.itemsCount' => ({required Object count}) => '${count} mục',
			'transactions.transactionsCount' => ({required Object count}) => '${count} giao dịch',
			'transactions.editTransaction' => 'Sửa giao dịch',
			'transactions.newTransaction' => 'Giao dịch mới',
			'transactions.fromAccount' => 'Tài khoản chuyển',
			'transactions.toAccount' => 'Tài khoản nhận',
			'transactions.need' => 'Nhu cầu',
			'transactions.want' => 'Mong muốn',
			'transactions.saving' => 'Tiết kiệm',
			'transactions.addNoteEllipsis' => 'Thêm ghi chú...',
			'transactions.editItem' => 'Sửa mục',
			'transactions.newItem' => 'Mục mới',
			'transactions.viewModeDay' => 'Ngày',
			'transactions.viewModeWeek' => 'Tuần',
			'transactions.viewModeMonth' => 'Tháng',
			'transactions.viewModeDaily' => 'Hằng ngày',
			'transactions.viewModeWeekly' => 'Hằng tuần',
			'transactions.viewModeMonthly' => 'Hằng tháng',
			'transactions.debt' => 'Nợ',
			'transactions.recurring' => 'Định kỳ',
			'transactions.transfer' => 'Chuyển khoản',
			'transactions.weekNumber' => ({required Object weekNum, required Object date}) => 'Tuần ${weekNum} · ${date}',
			'transactions.insufficientBalance' => 'Số dư không đủ',
			'transactions.insufficientBalanceWarning' => ({required Object amount, required Object account, required Object balance}) => 'Số tiền (${amount}) vượt quá số dư hiện tại trong ${account} (${balance}). Có thể bạn quên ghi thu nhập trước?',
			'transactions.insufficientBalanceConsequence' => 'Số dư tài khoản sẽ thành âm nếu bạn tiếp tục.',
			'transactions.continueAnyway' => 'Vẫn tiếp tục',
			'transactions.checkAgain' => 'Kiểm tra lại',
			'transactions.transactionDeleted' => 'Đã xóa giao dịch',
			'transactions.transactionRestored' => 'Đã khôi phục giao dịch',
			'transactions.allocation' => 'Phân bổ',
			_ => null,
		};
	}
}
