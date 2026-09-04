part of 'theme.dart';

/// Poka-specific gradient tokens.
abstract final class PokaGradients {
  /// The standard directional gradient used for hero cards and vibrant color surfaces.
  /// It fades the base color slightly towards black at the bottom right.
  static LinearGradient hero(Color baseColor) {
    return LinearGradient(
      colors: [
        baseColor,
        Color.lerp(baseColor, Colors.black, 0.35) ?? baseColor,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  /// White to transparent gradient for HSV saturation map.
  static const LinearGradient hsvSaturation = LinearGradient(
    colors: [Colors.white, Colors.transparent],
  );

  /// Transparent to black gradient for HSV value map.
  static const LinearGradient hsvValue = LinearGradient(
    colors: [Colors.transparent, Colors.black],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  /// Rainbow hue slider gradient.
  static const LinearGradient hsvHue = LinearGradient(
    colors: [
      Color(0xFFFF0000), // 0
      Color(0xFFFFFF00), // 60
      Color(0xFF00FF00), // 120
      Color(0xFF00FFFF), // 180
      Color(0xFF0000FF), // 240
      Color(0xFFFF00FF), // 300
      Color(0xFFFF0000), // 360
    ],
  );

  /// Vertical fade-out gradient for sparklines on hero cards and background charts.
  static LinearGradient sparklineFill(Color color) {
    return LinearGradient(
      colors: [
        color.withValues(alpha: 0.18),
        color.withValues(alpha: 0),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }
}
