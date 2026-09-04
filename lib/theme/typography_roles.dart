import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

/// Semantic typography roles extension for Poka CE.
/// This maps semantic intent to the raw Forui typography scale, ensuring
/// consistent sizing and weights across the application without inline overrides.
extension PokaTypographyRoles on FTypography {
  // ── Display / Hero ────────────────────────────
  /// Hero amount (e.g., net worth, goal total). 28-30px w800 letterSpacing: -1, tabular figures.
  TextStyle get amountHero => body.xl2.copyWith(
    fontWeight: FontWeight.w800,
    letterSpacing: -1,
    height: 1,
    fontFeatures: const [FontFeature.tabularFigures()],
  );

  /// Section amount (e.g., account balance). 20-22px w700 letterSpacing: -0.5, tabular figures.
  TextStyle get amountSection => body.xl.copyWith(
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 1,
    fontFeatures: const [FontFeature.tabularFigures()],
  );

  // ── Titles ────────────────────────────────────
  /// Screen / page title. 20px w600 letterSpacing: -0.4 (Plus Jakarta Sans).
  TextStyle get titleScreen => display.lg.copyWith(fontWeight: FontWeight.w600, letterSpacing: -0.4);

  /// Card / section title. 16px w600 letterSpacing: -0.2 (Plus Jakarta Sans).
  TextStyle get titleCard => display.sm.copyWith(fontWeight: FontWeight.w600, letterSpacing: -0.2);

  TextStyle get titleItem => body.sm.copyWith(fontWeight: FontWeight.w600, letterSpacing: 0);

  // ── Body ──────────────────────────────────────
  /// Standard readable body text. 15-16px w400 (Inter).
  TextStyle get bodyPrimary => body.sm;

  /// Secondary / supporting text beneath a primary label. 13-14px w400 (Inter).
  TextStyle get bodySecondary => body.xs;

  // ── Labels / Metadata ─────────────────────────
  /// Section label (uppercase tracking). 12-13px w700 letterSpacing: +0.8 (Plus Jakarta Sans).
  TextStyle get labelSection => display.xs2.copyWith(fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.8);

  /// Form input labels, filter chip labels. 12px w600 (Inter).
  TextStyle get labelField => body.xs2.copyWith(fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0);

  /// Timestamps, muted metadata. 11-12px w400 (Inter).
  TextStyle get caption => body.xs2;

  /// Badge / chip text. 9px w600. Only for containers with colored background.
  TextStyle get labelBadge => body.xs3.copyWith(fontSize: 9, fontWeight: FontWeight.w600, letterSpacing: 0);

  /// Per-row financial amounts in transaction tiles. 13px w600, tabular figures.
  TextStyle get amountTile => body.xs.copyWith(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
    fontFeatures: const [FontFeature.tabularFigures()],
  );

  /// Primary amount in full-width cards (budget, goal, debt, recurring). 15px w700, tabular figures.
  TextStyle get amountCard => body.xs.copyWith(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    fontFeatures: const [FontFeature.tabularFigures()],
  );
}
