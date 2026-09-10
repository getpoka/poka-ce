# Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Prevent R8 from removing native platform channels and callbacks
-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}

-dontwarn io.flutter.plugin.**
-dontwarn com.google.android.play.core.**

# Quick Actions and Shortcuts
-keep class io.flutter.plugins.quickactions.** { *; }
-keep class androidx.core.content.pm.ShortcutInfoCompat** { *; }
-keep class androidx.core.content.pm.ShortcutManagerCompat** { *; }
-keep class androidx.core.graphics.drawable.IconCompat** { *; }

# Flutter Local Notifications
-keep class com.dexterous.** { *; }
-keepattributes Signature
-keepattributes *Annotation*
-dontwarn sun.misc.**

# SQLite / Drift
-keep class org.sqlite.** { *; }
-dontwarn org.sqlite.**

# Local Auth & Biometrics
-keep class io.flutter.plugins.localauth.** { *; }
-keep class androidx.biometric.** { *; }

# Flutter Secure Storage
-keep class com.it_nomads.fluttersecurestorage.** { *; }


