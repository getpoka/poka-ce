part of 'theme.dart';

/// Color tokens and theme extensions for Poka CE.
///
/// ## Token layers
/// 1. [PokaColors] — raw brand ramp. Reference only, never used directly in widgets.
/// 2. [FColors] ([lightColors] / [darkColors]) — ForUI core roles (background, primary, card, border…).
/// 3. [AppColors] — Poka-specific extension holding the [PokaSurfaceColors] elevation ladder and the
///    [PokaFinanceColors] semantic set. Reached via `context.theme.colors.app`.
///
/// ## Mode identity
/// * **Light** — pure white canvas; brand primary `#5560D6` is unchanged and owns the accent role.
/// * **Dark** — Better Stack inspired near-black blue (`#0B0C14` base, `#12131C` card) with a desaturated,
///   lifted primary so the accent stays assertive without glaring against the deep background.
///
/// ## Accessibility
/// Every foreground token is verified against the surface it is designed to sit on:
/// body text ≥ 4.5:1 (WCAG AA), large/bold amounts ≥ 3:1. Borders are decorative — component boundaries
/// are carried by the surface step plus a fill, and focus is always drawn with `colors.primary`
/// (5.21:1 on white, 6.02:1 on `#0B0C14`).

// ---------------------------------------------------------------------------
// Brand palette reference constants
// ---------------------------------------------------------------------------

/// Full tonal spectrum extracted from the Poka brand logo.
///
/// **Reference only.** Widgets must read `context.theme.colors` instead.
abstract final class PokaColors {
  /// 50 — very light tint, hover/chip backgrounds.
  static const Color brand50 = Color(0xFFDCDDF7);

  /// 100 — soft accent, subtle borders.
  static const Color brand100 = Color(0xFFAFB3ED);

  /// 200 — muted primary, hover states.
  static const Color brand200 = Color(0xFF8389E3);

  /// 300 — desaturated lift used as the dark-mode primary (`L 67% / S 51%`).
  ///
  /// Reads 6.02:1 on the dark base and 5.71:1 on the dark card, while staying dull enough to avoid
  /// the halation a fully saturated indigo produces on a near-black canvas.
  static const Color brand300 = Color(0xFF8189D6);

  /// 400 — dark-mode hover step above [brand300].
  static const Color brand400 = Color(0xFF9AA1E1);

  /// 500 — main brand / primary accent. Fixed, never re-tuned.
  static const Color brand500 = Color(0xFF5560D6);

  /// 700 — dark primary, focus rings, on-tint foreground in light mode.
  static const Color brand700 = Color(0xFF313DAA);

  /// 800 — deep navy, elevated dark surfaces.
  static const Color brand800 = Color(0xFF1A2268);

  /// 900 — darkest navy, deep dark surfaces.
  static const Color brand900 = Color(0xFF080C32);
}

// ---------------------------------------------------------------------------
// Surface ladder
// ---------------------------------------------------------------------------

/// The elevation ladder for Poka.
///
/// Poka renders elevation with **surface steps and borders only** — shadows are forbidden app-wide.
/// Each step is one perceptible tone above the previous one, so a sheet stacked on a card stacked on
/// the page still reads as three distinct planes.
///
/// ```text
/// sunken  ← wells, grouped-list backdrops, chart plots
/// canvas  ← page background
/// raised  ← cards: transaction rows, balance widget, summary report
/// overlay ← bottom sheets, dialogs, popovers, menus
/// input   ← text fields, selects, keypad keys
/// ```
@immutable
class PokaSurfaceColors {
  const new({
    required this.sunken,
    required this.canvas,
    required this.raised,
    required this.overlay,
    required this.input,
    required this.borderSubtle,
    required this.border,
    required this.borderStrong,
    required this.hover,
    required this.pressed,
  });

  /// One step **below** the page — inset wells, grouped-list backdrops, chart plot areas.
  final Color sunken;

  /// The page background. Mirrors `FColors.background`.
  final Color canvas;

  /// Standard card plane. Mirrors `FColors.card`.
  final Color raised;

  /// Modal plane — bottom sheets, dialogs, popovers, dropdown menus.
  final Color overlay;

  /// Filled form controls — text fields, selects, keypad keys.
  final Color input;

  /// Hairline for dividers inside a surface (row separators, list dividers).
  final Color borderSubtle;

  /// Default surface outline. Mirrors `FColors.border`.
  final Color border;

  /// Emphasised outline — focused/selected cards, input borders, overlay edges.
  final Color borderStrong;

  /// Translucent hover state layer, painted **on top** of any surface.
  final Color hover;

  /// Translucent pressed/active state layer, painted **on top** of any surface.
  final Color pressed;

  PokaSurfaceColors copyWith({
    Color? sunken,
    Color? canvas,
    Color? raised,
    Color? overlay,
    Color? input,
    Color? borderSubtle,
    Color? border,
    Color? borderStrong,
    Color? hover,
    Color? pressed,
  }) => PokaSurfaceColors(
    sunken: sunken ?? this.sunken,
    canvas: canvas ?? this.canvas,
    raised: raised ?? this.raised,
    overlay: overlay ?? this.overlay,
    input: input ?? this.input,
    borderSubtle: borderSubtle ?? this.borderSubtle,
    border: border ?? this.border,
    borderStrong: borderStrong ?? this.borderStrong,
    hover: hover ?? this.hover,
    pressed: pressed ?? this.pressed,
  );

  /// Linearly interpolates towards [other] by [t], used when the app animates between themes.
  PokaSurfaceColors lerp(PokaSurfaceColors other, double t) => PokaSurfaceColors(
    sunken: Color.lerp(sunken, other.sunken, t)!,
    canvas: Color.lerp(canvas, other.canvas, t)!,
    raised: Color.lerp(raised, other.raised, t)!,
    overlay: Color.lerp(overlay, other.overlay, t)!,
    input: Color.lerp(input, other.input, t)!,
    borderSubtle: Color.lerp(borderSubtle, other.borderSubtle, t)!,
    border: Color.lerp(border, other.border, t)!,
    borderStrong: Color.lerp(borderStrong, other.borderStrong, t)!,
    hover: Color.lerp(hover, other.hover, t)!,
    pressed: Color.lerp(pressed, other.pressed, t)!,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokaSurfaceColors &&
          runtimeType == other.runtimeType &&
          sunken == other.sunken &&
          canvas == other.canvas &&
          raised == other.raised &&
          overlay == other.overlay &&
          input == other.input &&
          borderSubtle == other.borderSubtle &&
          border == other.border &&
          borderStrong == other.borderStrong &&
          hover == other.hover &&
          pressed == other.pressed;

  @override
  int get hashCode => Object.hash(
    runtimeType,
    sunken,
    canvas,
    raised,
    overlay,
    input,
    borderSubtle,
    border,
    borderStrong,
    hover,
    pressed,
  );
}

// ---------------------------------------------------------------------------
// Finance semantics
// ---------------------------------------------------------------------------

/// Semantic colors for financial meaning.
///
/// Every semantic ships as a triplet so one hue can serve three jobs without ever failing contrast:
///
/// | Suffix   | Role                                             | Contrast target        |
/// |----------|--------------------------------------------------|------------------------|
/// | *(none)* | Text, icons, borders on a surface                | ≥ 4.5:1 on card/canvas |
/// | `Fill`   | Charts, progress bars, gradients, large solids   | ≥ 3:1 on card/canvas   |
/// | `Soft`   | Tinted chip/badge background                     | pairs with *(none)*    |
///
/// Reach for `Fill` only when the shape is large enough to read on its own; anything that carries a
/// number or a label uses the base token.
@immutable
class PokaFinanceColors {
  const new({
    required this.income,
    required this.incomeFill,
    required this.incomeSoft,
    required this.expense,
    required this.expenseFill,
    required this.expenseSoft,
    required this.transfer,
    required this.transferFill,
    required this.transferSoft,
    required this.success,
    required this.successFill,
    required this.successSoft,
    required this.warning,
    required this.warningFill,
    required this.warningSoft,
  });

  /// Money in — credited amounts, positive deltas.
  final Color income;

  /// Income as a chart series, progress fill, or gradient base.
  final Color incomeFill;

  /// Income chip/badge background.
  final Color incomeSoft;

  /// Money out — debited amounts, negative deltas.
  final Color expense;

  /// Expense as a chart series, progress fill, or gradient base.
  final Color expenseFill;

  /// Expense chip/badge background.
  final Color expenseSoft;

  /// Value moved between own accounts — net-zero, deliberately on-brand rather than good/bad.
  final Color transfer;

  /// Transfer as a chart series or progress fill.
  final Color transferFill;

  /// Transfer chip/badge background.
  final Color transferSoft;

  /// Goal reached, budget on track, debt settled.
  final Color success;

  /// Success as a chart series or progress fill.
  final Color successFill;

  /// Success chip/badge background.
  final Color successSoft;

  /// Budget cap approaching or breached, payment due, paused schedule.
  final Color warning;

  /// Warning as a chart series or progress fill.
  final Color warningFill;

  /// Warning chip/badge background.
  final Color warningSoft;

  PokaFinanceColors copyWith({
    Color? income,
    Color? incomeFill,
    Color? incomeSoft,
    Color? expense,
    Color? expenseFill,
    Color? expenseSoft,
    Color? transfer,
    Color? transferFill,
    Color? transferSoft,
    Color? success,
    Color? successFill,
    Color? successSoft,
    Color? warning,
    Color? warningFill,
    Color? warningSoft,
  }) => PokaFinanceColors(
    income: income ?? this.income,
    incomeFill: incomeFill ?? this.incomeFill,
    incomeSoft: incomeSoft ?? this.incomeSoft,
    expense: expense ?? this.expense,
    expenseFill: expenseFill ?? this.expenseFill,
    expenseSoft: expenseSoft ?? this.expenseSoft,
    transfer: transfer ?? this.transfer,
    transferFill: transferFill ?? this.transferFill,
    transferSoft: transferSoft ?? this.transferSoft,
    success: success ?? this.success,
    successFill: successFill ?? this.successFill,
    successSoft: successSoft ?? this.successSoft,
    warning: warning ?? this.warning,
    warningFill: warningFill ?? this.warningFill,
    warningSoft: warningSoft ?? this.warningSoft,
  );

  /// Linearly interpolates towards [other] by [t], used when the app animates between themes.
  PokaFinanceColors lerp(PokaFinanceColors other, double t) => PokaFinanceColors(
    income: Color.lerp(income, other.income, t)!,
    incomeFill: Color.lerp(incomeFill, other.incomeFill, t)!,
    incomeSoft: Color.lerp(incomeSoft, other.incomeSoft, t)!,
    expense: Color.lerp(expense, other.expense, t)!,
    expenseFill: Color.lerp(expenseFill, other.expenseFill, t)!,
    expenseSoft: Color.lerp(expenseSoft, other.expenseSoft, t)!,
    transfer: Color.lerp(transfer, other.transfer, t)!,
    transferFill: Color.lerp(transferFill, other.transferFill, t)!,
    transferSoft: Color.lerp(transferSoft, other.transferSoft, t)!,
    success: Color.lerp(success, other.success, t)!,
    successFill: Color.lerp(successFill, other.successFill, t)!,
    successSoft: Color.lerp(successSoft, other.successSoft, t)!,
    warning: Color.lerp(warning, other.warning, t)!,
    warningFill: Color.lerp(warningFill, other.warningFill, t)!,
    warningSoft: Color.lerp(warningSoft, other.warningSoft, t)!,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokaFinanceColors &&
          runtimeType == other.runtimeType &&
          income == other.income &&
          incomeFill == other.incomeFill &&
          incomeSoft == other.incomeSoft &&
          expense == other.expense &&
          expenseFill == other.expenseFill &&
          expenseSoft == other.expenseSoft &&
          transfer == other.transfer &&
          transferFill == other.transferFill &&
          transferSoft == other.transferSoft &&
          success == other.success &&
          successFill == other.successFill &&
          successSoft == other.successSoft &&
          warning == other.warning &&
          warningFill == other.warningFill &&
          warningSoft == other.warningSoft;

  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    income,
    incomeFill,
    incomeSoft,
    expense,
    expenseFill,
    expenseSoft,
    transfer,
    transferFill,
    transferSoft,
    success,
    successFill,
    successSoft,
    warning,
    warningFill,
    warningSoft,
  ]);
}

// ---------------------------------------------------------------------------
// Light theme — clean white canvas, brand primary pops at full strength
// ---------------------------------------------------------------------------

/// Surface ladder for light mode. Steps are cool-tinted so they sit under the indigo primary.
const PokaSurfaceColors _lightSurfaces = PokaSurfaceColors(
  // Slate-tinted well — reads as recessed against the white page.
  sunken: Color(0xFFF4F5FA),
  canvas: Color(0xFFFFFFFF),
  raised: Color(0xFFFFFFFF),
  // Sheets and dialogs stay white; the barrier does the separating.
  overlay: Color(0xFFFFFFFF),
  // Filled fields — the fill, not the border, is what marks the control.
  input: Color(0xFFF5F6FB),
  // Hairline dividers inside cards and tiles.
  borderSubtle: Color(0xFFE8EAF3),
  border: Color(0xFFDBDFEE),
  // Selected/focused outlines and input borders.
  borderStrong: Color(0xFFA9B1CC),
  // 6% brand wash — warmer than a grey overlay, keeps hover on-brand.
  hover: Color(0x0F5560D6),
  // 12% brand wash.
  pressed: Color(0x1F5560D6),
);

/// Finance semantics for light mode, tuned so every base token clears AA on white *and* on its own tint.
const PokaFinanceColors _lightFinance = PokaFinanceColors(
  // Emerald-700 — 5.48:1 on white (emerald-600 only reached 3.77:1 and failed AA).
  income: Color(0xFF047857),
  incomeFill: Color(0xFF059669),
  incomeSoft: Color(0xFFE6F4F0),
  // Rose-700 — 6.29:1 on white, 5.36:1 on its own tint.
  expense: Color(0xFFBE123C),
  expenseFill: Color(0xFFF43F5E),
  expenseSoft: Color(0xFFFEECEF),
  // Indigo-600 — one stop off the brand primary so transfers read neutral-but-related.
  transfer: Color(0xFF4F46E5),
  transferFill: Color(0xFF6366F1),
  transferSoft: Color(0xFFEFF0FE),
  success: Color(0xFF047857),
  successFill: Color(0xFF10B981),
  successSoft: Color(0xFFE6F4F0),
  // Amber-700 — amber-500 is only 2.15:1 on white and is fill-only.
  warning: Color(0xFFB45309),
  warningFill: Color(0xFFF59E0B),
  warningSoft: Color(0xFFFEF5E7),
);

final FColors lightColors = FColors(
  brightness: .light,
  systemOverlayStyle: .dark,
  barrier: const Color(0x33000000),
  // Pure white — lets #5560D6 primary own the accent role completely.
  background: _lightSurfaces.canvas,
  // Near-black foreground — 17.85:1 on white, WCAG AAA.
  foreground: const Color(0xFF0F172A),
  // Brand primary fixed at #5560D6 — vibrant indigo-blue, unchanged.
  primary: PokaColors.brand500,
  // White on #5560D6 — 5.21:1, WCAG AA.
  primaryForeground: const Color(0xFFFFFFFF),
  // Light brand tint for secondary surfaces — comfortable, not stark.
  secondary: const Color(0xFFEEF0FB),
  // 7.77:1 on the secondary tint.
  secondaryForeground: PokaColors.brand700,
  // Muted zones share the sunken step so recessed areas stay consistent.
  muted: _lightSurfaces.sunken,
  // Slate-blue subtext — 5.35:1 on white and 4.91:1 on the sunken step.
  // (The previous #64748B dropped to 4.48:1 on tinted surfaces and missed AA.)
  mutedForeground: const Color(0xFF5F6B85),
  destructive: TWind.red600,
  destructiveForeground: TWind.white,
  error: TWind.red600,
  errorForeground: TWind.white,
  // White card — floats above bg via border, no shadow needed.
  card: _lightSurfaces.raised,
  border: _lightSurfaces.border,
  extensions: const [AppColors(finance: _lightFinance, surfaces: _lightSurfaces)],
);

// ---------------------------------------------------------------------------
// Dark theme — Better Stack tone: #0B0C14 base, #12131C card, lifted primary
// ---------------------------------------------------------------------------

/// Surface ladder for dark mode.
///
/// Five steps of near-black blue. Each rung lifts luminance by roughly 1.05–1.15× the one below, which
/// is the smallest step that still separates planes on an OLED panel without turning grey.
const PokaSurfaceColors _darkSurfaces = PokaSurfaceColors(
  // Below the base — chart plots and inset wells recede instead of floating.
  sunken: Color(0xFF07080E),
  canvas: Color(0xFF0B0C14),
  raised: Color(0xFF12131C),
  // Sheets, dialogs and popovers sit a visible step above any card behind them.
  overlay: Color(0xFF171825),
  // Inputs read as the topmost plane — the classic dashboard "lit field".
  input: Color(0xFF1B1D2B),
  // Dev-tool hairlines: present, never harsh.
  borderSubtle: Color(0xFF1B1D2B),
  border: Color(0xFF24263A),
  borderStrong: Color(0xFF313349),
  // 6% white wash.
  hover: Color(0x0FFFFFFF),
  // 12% white wash.
  pressed: Color(0x1FFFFFFF),
);

/// Finance semantics for dark mode — 400-level hues, all ≥ 4.7:1 on both the card and its own tint.
const PokaFinanceColors _darkFinance = PokaFinanceColors(
  // Emerald-400 — 9.62:1 on the card.
  income: Color(0xFF34D399),
  incomeFill: Color(0xFF10B981),
  incomeSoft: Color(0xFF162A2B),
  // Rose-400 — 6.87:1 on the card, soft enough to avoid vibrating on near-black.
  expense: Color(0xFFFB7185),
  expenseFill: Color(0xFFF43F5E),
  expenseSoft: Color(0xFF2E1E29),
  // Matches the dark primary family so transfers stay on-brand.
  transfer: PokaColors.brand300,
  transferFill: Color(0xFF6366F1),
  transferSoft: Color(0xFF1F2132),
  success: Color(0xFF34D399),
  successFill: Color(0xFF10B981),
  successSoft: Color(0xFF162A2B),
  // Amber-400 — 11.08:1 on the card.
  warning: Color(0xFFFBBF24),
  warningFill: Color(0xFFF59E0B),
  warningSoft: Color(0xFF2E281D),
);

final FColors darkColors = FColors(
  brightness: .dark,
  systemOverlayStyle: .light,
  // Deeper scrim so the near-black overlay still separates from the page.
  barrier: const Color(0x99000000),
  background: _darkSurfaces.canvas,
  // Cool off-white — 15.94:1 on the base. Pure white would bloom on this tone.
  foreground: const Color(0xFFE6E8F0),
  // Set to match light mode primary (#5560D6).
  primary: PokaColors.brand500,
  // White on #5560D6 — 5.21:1, WCAG AA.
  primaryForeground: const Color(0xFFFFFFFF),
  secondary: _darkSurfaces.input,
  // 11.75:1 on the secondary surface.
  secondaryForeground: const Color(0xFFD5D8E4),
  muted: _darkSurfaces.overlay,
  // 6.48:1 on the base, 5.84:1 on the overlay.
  mutedForeground: const Color(0xFF8E94AB),
  // Solid red for filled destructive actions — white text clears AA at 4.83:1.
  destructive: TWind.red600,
  destructiveForeground: TWind.white,
  // Error is rendered as *text* by ForUI form fields, so it needs the light rose, not the solid red:
  // #F87171 is 7.05:1 on the base where red-600 would be 4.04:1.
  error: const Color(0xFFF87171),
  errorForeground: const Color(0xFF0B0C14),
  card: _darkSurfaces.canvas,
  border: _darkSurfaces.border,
  extensions: const [AppColors(finance: _darkFinance, surfaces: _darkSurfaces)],
);

/// Provides convenient access to theme extensions on [FColors].
extension FColorsExtensions on FColors {
  AppColors get app => extension<AppColors>();
}

/// Custom color tokens unique to Poka.
///
/// Groups the two Poka-owned token families and re-exports the finance semantics as flat getters so
/// call sites stay short:
///
/// ```dart
/// final colors = context.theme.colors;
///
/// colors.app.income          // semantic text/icon color
/// colors.app.finance.incomeFill  // chart series
/// colors.app.surfaces.overlay    // sheet background
/// ```
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const new({required this.finance, required this.surfaces});

  /// Semantic colors for financial meaning — income, expense, transfer, success, warning.
  final PokaFinanceColors finance;

  /// The surface elevation ladder and its border/state tokens.
  final PokaSurfaceColors surfaces;

  /// Money in. Shorthand for `finance.income`.
  Color get income => finance.income;

  /// Money out. Shorthand for `finance.expense`.
  Color get expense => finance.expense;

  /// Value moved between own accounts. Shorthand for `finance.transfer`.
  Color get transfer => finance.transfer;

  /// Positive outcome. Shorthand for `finance.success`.
  Color get success => finance.success;

  /// Budget cap, due payment, paused schedule. Shorthand for `finance.warning`.
  Color get warning => finance.warning;

  @override
  AppColors copyWith({PokaFinanceColors? finance, PokaSurfaceColors? surfaces}) =>
      AppColors(finance: finance ?? this.finance, surfaces: surfaces ?? this.surfaces);

  @override
  AppColors lerp(covariant AppColors? other, double t) {
    if (other == null) return this;
    return AppColors(finance: finance.lerp(other.finance, t), surfaces: surfaces.lerp(other.surfaces, t));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppColors && runtimeType == other.runtimeType && finance == other.finance && surfaces == other.surfaces;

  @override
  int get hashCode => Object.hash(runtimeType, finance, surfaces);
}
