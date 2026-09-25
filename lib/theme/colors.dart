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
  // ── Brand Palette ──────────────────────────────────────────────────────────
  /// 500 — Main brand / primary accent. Fixed, never re-tuned (#5560D6).
  static const Color brand500 = Color(0xFF5560D6);

  /// 700 — Dark primary, focus rings, on-tint foreground in light mode (#313DAA).
  static const Color brand700 = Color(0xFF313DAA);

  /// 300 — Desaturated lift used as dark-mode transfer (#8189D6).
  static const Color brand300 = Color(0xFF8189D6);

  // ── Base Neutrals ──────────────────────────────────────────────────────────
  static const Color white = Color(0xFFFFFFFF);
  static const Color transparent = Color(0x00000000);
  static const Color barrierLight = Color(0x33000000);
  static const Color barrierDark = Color(0x99000000);

  /// Default fallback for invalid hex color strings (#CCCCCC).
  static const Color colorFallback = Color(0xFFCCCCCC);

  // ── Semantic Finance & Feedback Palette ────────────────────────────────────
  // Emerald / Income & Success
  static const Color emerald700 = Color(0xFF047857);
  static const Color emerald600 = Color(0xFF059669);
  static const Color emerald500 = Color(0xFF10B981);
  static const Color emerald400 = Color(0xFF34D399);
  static const Color emeraldSoftLight = Color(0xFFE6F4F0);
  static const Color emeraldSoftDark = Color(0xFF162A2B);

  // Rose / Expense
  static const Color rose700 = Color(0xFFBE123C);
  static const Color rose500 = Color(0xFFF43F5E);
  static const Color rose400 = Color(0xFFFB7185);
  static const Color roseSoftLight = Color(0xFFFEECEF);
  static const Color roseSoftDark = Color(0xFF2E1E29);

  // Indigo / Transfer
  static const Color indigo600 = Color(0xFF4F46E5);
  static const Color indigo500 = Color(0xFF6366F1);
  static const Color indigoSoftLight = Color(0xFFEFF0FE);
  static const Color indigoSoftDark = Color(0xFF1F2132);

  // Amber / Warning
  static const Color amber700 = Color(0xFFB45309);
  static const Color amber500 = Color(0xFFF59E0B);
  static const Color amber400 = Color(0xFFFBBF24);
  static const Color warningSoftLight = Color(0xFFFEF5E7);
  static const Color warningSoftDark = Color(0xFF2E281D);

  // Destructive & Error
  static const Color red600 = Color(0xFFDC2626);
  static const Color red400 = Color(0xFFF87171);

  // ── Light Mode Surface & Neutral Tokens ────────────────────────────────────
  static const Color lightSunken = Color(0xFFF4F5FA);
  static const Color lightInput = Color(0xFFF5F6FB);
  static const Color lightBorderSubtle = Color(0xFFE8EAF3);
  static const Color lightBorder = Color(0xFFDBDFEE);
  static const Color lightBorderStrong = Color(0xFFA9B1CC);
  static const Color lightForeground = Color(0xFF0F172A);
  static const Color lightSecondary = Color(0xFFEEF0FB);
  static const Color lightMutedForeground = Color(0xFF5F6B85);
  static const Color lightHover = Color(0x0F5560D6);
  static const Color lightPressed = Color(0x1F5560D6);

  // ── Dark Mode Surface & Neutral Tokens (Better Stack Near-Black) ───────────
  static const Color darkSunken = Color(0xFF07080E);
  static const Color darkCanvas = Color(0xFF0B0C14);
  static const Color darkRaised = Color(0xFF12131C);
  static const Color darkOverlay = Color(0xFF171825);
  static const Color darkInput = Color(0xFF1B1D2B);
  static const Color darkBorder = Color(0xFF24263A);
  static const Color darkBorderStrong = Color(0xFF313349);
  static const Color darkForeground = Color(0xFFE6E8F0);
  static const Color darkSecondaryForeground = Color(0xFFD5D8E4);
  static const Color darkMutedForeground = Color(0xFF8E94AB);
  static const Color darkHover = Color(0x0FFFFFFF);
  static const Color darkPressed = Color(0x1FFFFFFF);
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
  sunken: PokaColors.lightSunken,
  canvas: PokaColors.white,
  raised: PokaColors.white,
  overlay: PokaColors.white,
  input: PokaColors.lightInput,
  borderSubtle: PokaColors.lightBorderSubtle,
  border: PokaColors.lightBorder,
  borderStrong: PokaColors.lightBorderStrong,
  hover: PokaColors.lightHover,
  pressed: PokaColors.lightPressed,
);

/// Finance semantics for light mode, tuned so every base token clears AA on white *and* on its own tint.
const PokaFinanceColors _lightFinance = PokaFinanceColors(
  income: PokaColors.emerald700,
  incomeFill: PokaColors.emerald600,
  incomeSoft: PokaColors.emeraldSoftLight,
  expense: PokaColors.rose700,
  expenseFill: PokaColors.rose500,
  expenseSoft: PokaColors.roseSoftLight,
  transfer: PokaColors.indigo600,
  transferFill: PokaColors.indigo500,
  transferSoft: PokaColors.indigoSoftLight,
  success: PokaColors.emerald700,
  successFill: PokaColors.emerald500,
  successSoft: PokaColors.emeraldSoftLight,
  warning: PokaColors.amber700,
  warningFill: PokaColors.amber500,
  warningSoft: PokaColors.warningSoftLight,
);

final FColors lightColors = FColors(
  brightness: .light,
  systemOverlayStyle: .dark,
  barrier: PokaColors.barrierLight,
  background: _lightSurfaces.canvas,
  foreground: PokaColors.lightForeground,
  primary: PokaColors.brand500,
  primaryForeground: PokaColors.white,
  secondary: PokaColors.lightSecondary,
  secondaryForeground: PokaColors.brand700,
  muted: _lightSurfaces.sunken,
  mutedForeground: PokaColors.lightMutedForeground,
  destructive: PokaColors.red600,
  destructiveForeground: PokaColors.white,
  error: PokaColors.red600,
  errorForeground: PokaColors.white,
  card: _lightSurfaces.raised,
  border: _lightSurfaces.border,
  extensions: const [AppColors(finance: _lightFinance, surfaces: _lightSurfaces)],
);

// ---------------------------------------------------------------------------
// Dark theme — Better Stack tone: #0B0C14 base, #12131C card, lifted primary
// ---------------------------------------------------------------------------

/// Surface ladder for dark mode.
const PokaSurfaceColors _darkSurfaces = PokaSurfaceColors(
  sunken: PokaColors.darkSunken,
  canvas: PokaColors.darkCanvas,
  raised: PokaColors.darkRaised,
  overlay: PokaColors.darkOverlay,
  input: PokaColors.darkInput,
  borderSubtle: PokaColors.darkInput,
  border: PokaColors.darkBorder,
  borderStrong: PokaColors.darkBorderStrong,
  hover: PokaColors.darkHover,
  pressed: PokaColors.darkPressed,
);

/// Finance semantics for dark mode — 400-level hues, all ≥ 4.7:1 on both the card and its own tint.
const PokaFinanceColors _darkFinance = PokaFinanceColors(
  income: PokaColors.emerald400,
  incomeFill: PokaColors.emerald500,
  incomeSoft: PokaColors.emeraldSoftDark,
  expense: PokaColors.rose400,
  expenseFill: PokaColors.rose500,
  expenseSoft: PokaColors.roseSoftDark,
  transfer: PokaColors.brand300,
  transferFill: PokaColors.indigo500,
  transferSoft: PokaColors.indigoSoftDark,
  success: PokaColors.emerald400,
  successFill: PokaColors.emerald500,
  successSoft: PokaColors.emeraldSoftDark,
  warning: PokaColors.amber400,
  warningFill: PokaColors.amber500,
  warningSoft: PokaColors.warningSoftDark,
);

final FColors darkColors = FColors(
  brightness: .dark,
  systemOverlayStyle: .light,
  barrier: PokaColors.barrierDark,
  background: _darkSurfaces.canvas,
  foreground: PokaColors.darkForeground,
  primary: PokaColors.brand500,
  primaryForeground: PokaColors.white,
  secondary: _darkSurfaces.input,
  secondaryForeground: PokaColors.darkSecondaryForeground,
  muted: _darkSurfaces.overlay,
  mutedForeground: PokaColors.darkMutedForeground,
  destructive: PokaColors.red600,
  destructiveForeground: PokaColors.white,
  error: PokaColors.red400,
  errorForeground: PokaColors.darkCanvas,
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
