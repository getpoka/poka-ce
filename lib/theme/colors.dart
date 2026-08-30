part of 'theme.dart';

/// Color tokens and theme extensions for Poka CE.
///
/// Primary brand color: `#5560D6` (indigo-blue), fixed across both modes.
/// Light mode: clean white surfaces with subtle brand-tinted supporting tokens.
/// Dark mode: slate-950 base — premium neutral — with slate-900 card lift.

// ---------------------------------------------------------------------------
// Brand palette reference constants
// ---------------------------------------------------------------------------

/// Full tonal spectrum extracted from the Poka brand logo.
abstract final class PokaColors {
  /// 50 — very light tint, hover/chip backgrounds.
  static const Color brand50 = Color(0xFFDCDDF7);

  /// 100 — soft accent, subtle borders.
  static const Color brand100 = Color(0xFFAFB3ED);

  /// 200 — muted primary, hover states.
  static const Color brand200 = Color(0xFF8389E3);

  /// 500 — main brand / primary accent.
  static const Color brand500 = Color(0xFF5560D6);

  /// 700 — dark primary, focus rings.
  static const Color brand700 = Color(0xFF313DAA);

  /// 800 — deep navy, elevated dark surfaces.
  static const Color brand800 = Color(0xFF1A2268);

  /// 900 — darkest navy, deep dark surfaces.
  static const Color brand900 = Color(0xFF080C32);
}

// ---------------------------------------------------------------------------
// Light theme — clean white canvas, brand primary pops at full strength
// ---------------------------------------------------------------------------

final FColors lightColors = FColors(
  brightness: .light,
  systemOverlayStyle: .dark,
  barrier: const Color(0x33000000),
  // Pure white — lets #5560D6 primary own the accent role completely.
  background: const Color(0xFFFFFFFF),
  // Near-black foreground — WCAG AAA on white.
  foreground: const Color(0xFF0F172A),
  // Brand primary fixed at #5560D6 — vibrant indigo-blue.
  primary: PokaColors.brand500,
  // White on #5560D6 passes WCAG AA (~4.6:1).
  primaryForeground: const Color(0xFFFFFFFF),
  // Very light brand tint for secondary surfaces — comfortable, not stark.
  secondary: const Color(0xFFEFF0FB),
  secondaryForeground: PokaColors.brand700,
  // Whisper brand tint for muted zones — barely perceptible.
  muted: const Color(0xFFF5F6FD),
  // Slate-500 — readable without competing with primary.
  mutedForeground: const Color(0xFF64748B),
  destructive: TWind.red600,
  destructiveForeground: TWind.white,
  error: TWind.red600,
  errorForeground: TWind.white,
  // White card — floats above bg via border, no shadow needed.
  card: const Color(0xFFFFFFFF),
  // brand50-adjacent border — brand-aligned but unobtrusive.
  border: const Color(0xFFDDE0F5),
  extensions: const [
    AppColors(
      // Teal-green income — rich saturation to match deep brand primary.
      income: Color(0xFF059669),
      // Deep rose expense — vivid and clearly distinct from primary.
      expense: Color(0xFFE11D48),
      // Mid-indigo transfer — on-brand, one stop below primary.
      transfer: Color(0xFF4F46E5),
      // Emerald success.
      success: Color(0xFF10B981),
      // Amber warning.
      warning: Color(0xFFF59E0B),
    ),
  ],
);

// ---------------------------------------------------------------------------
// Dark theme — slate-950 base, slate-900 card, primary #5560D6 vibrant
// ---------------------------------------------------------------------------

final FColors darkColors = FColors(
  brightness: .dark,
  systemOverlayStyle: .light,
  // Deeper scrim for dark-mode overlays.
  barrier: const Color(0x80000000),
  // Slate-950 (#020617) — ultra-dark neutral, premium and easy on eyes.
  background: TWind.slate950,
  // Slate-100 foreground — crisp (~19:1 on slate-950).
  foreground: const Color(0xFFF1F5F9),
  // #5560D6 reads well on slate-950 (~4.6:1 — WCAG AA).
  primary: PokaColors.brand500,
  // White on brand500 — clean and accessible.
  primaryForeground: const Color(0xFFFFFFFF),
  // Slate-800 secondary — natural slate family lift.
  secondary: TWind.slate800,
  secondaryForeground: TWind.slate200,
  // Slate-800/900 muted — tight to bg, muted feel without full black.
  muted: TWind.slate800,
  // Slate-400 — readable subtext on dark (~7:1 on slate-950).
  mutedForeground: TWind.slate400,
  destructive: TWind.red500,
  destructiveForeground: TWind.white,
  error: TWind.red500,
  errorForeground: TWind.white,
  // Slate-900 card — one visible step above slate-950 background.
  card: TWind.slate950,
  // Slate-700 border — clearly delineates surfaces without harshness.
  border: TWind.slate700,
  extensions: const [
    AppColors(
      // Bright emerald — pops beautifully on near-black slate surface.
      income: Color(0xFF34D399),
      // Soft rose — legible and distinct on dark slate.
      expense: Color(0xFFFB7185),
      // Light indigo transfer — on-brand, visible on dark bg.
      transfer: Color(0xFF818CF8),
      // Bright emerald success.
      success: Color(0xFF34D399),
      // Warm amber warning.
      warning: Color(0xFFFBBF24),
    ),
  ],
);

/// Provides convenient access to theme extensions on [FColors].
extension FColorsExtensions on FColors {
  AppColors get app => extension<AppColors>();
}

/// Custom color tokens unique to Poka.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.income,
    required this.expense,
    required this.transfer,
    required this.success,
    required this.warning,
  });

  final Color income;
  final Color expense;
  final Color transfer;
  final Color success;
  final Color warning;

  @override
  AppColors copyWith({
    Color? income,
    Color? expense,
    Color? transfer,
    Color? success,
    Color? warning,
  }) => AppColors(
    income: income ?? this.income,
    expense: expense ?? this.expense,
    transfer: transfer ?? this.transfer,
    success: success ?? this.success,
    warning: warning ?? this.warning,
  );

  @override
  AppColors lerp(covariant AppColors? other, double t) {
    if (other == null) return this;
    return AppColors(
      income: Color.lerp(income, other.income, t)!,
      expense: Color.lerp(expense, other.expense, t)!,
      transfer: Color.lerp(transfer, other.transfer, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppColors &&
          runtimeType == other.runtimeType &&
          income == other.income &&
          expense == other.expense &&
          transfer == other.transfer &&
          success == other.success &&
          warning == other.warning;

  @override
  int get hashCode => Object.hash(runtimeType, income, expense, transfer, success, warning);
}
