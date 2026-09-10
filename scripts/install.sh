#!/usr/bin/env bash

# =============================================================================
# Poka CE — APK Installer Script
# Installs a built APK to a connected Android device or emulator via adb.
# Usage: ./scripts/install.sh [fat|universal|arm64|armeabi-v7a|x86_64]
# =============================================================================

set -e

APK_DIR="build/app/outputs/flutter-apk"
RAW_TARGET="${1:-fat}"
# Normalize target string to lowercase and strip whitespace
TARGET=$(echo "$RAW_TARGET" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')

# Check adb availability
if ! command -v adb >/dev/null 2>&1; then
  echo "❌ Error: 'adb' command not found."
  echo "   Please ensure Android SDK Platform-Tools is installed and in your PATH."
  exit 1
fi

# Check connected devices
DEVICE_COUNT=$(adb devices | grep -E '	(device|emulator)' | wc -l | tr -d ' ')
if [ "$DEVICE_COUNT" -eq 0 ]; then
  echo "❌ Error: No Android device or emulator detected."
  echo "   Please connect a device with USB Debugging enabled or start an emulator."
  exit 1
fi

# Map target alias to APK file path
case "$TARGET" in
  ""|"fat"|"universal"|"default")
    ARCH_NAME="Universal (Fat)"
    if compgen -G "$APK_DIR/poka-*-universal.apk" >/dev/null; then
      APK_PATH=$(ls -t "$APK_DIR"/poka-*-universal.apk | head -n 1)
    elif [ -f "$APK_DIR/poka-universal.apk" ]; then
      APK_PATH="$APK_DIR/poka-universal.apk"
    elif [ -f "$APK_DIR/app-universal-release.apk" ]; then
      APK_PATH="$APK_DIR/app-universal-release.apk"
    elif [ -f "$APK_DIR/app-release.apk" ]; then
      APK_PATH="$APK_DIR/app-release.apk"
    elif [ -f "$APK_DIR/app-debug.apk" ]; then
      APK_PATH="$APK_DIR/app-debug.apk"
    else
      APK_PATH="$APK_DIR/poka-universal.apk"
    fi
    ;;
  "arm64"|"arm64-v8a"|"aarch64"|"v8a")
    ARCH_NAME="arm64-v8a"
    if compgen -G "$APK_DIR/poka-*-arm64-v8a.apk" >/dev/null; then
      APK_PATH=$(ls -t "$APK_DIR"/poka-*-arm64-v8a.apk | head -n 1)
    elif [ -f "$APK_DIR/poka-arm64-v8a.apk" ]; then
      APK_PATH="$APK_DIR/poka-arm64-v8a.apk"
    else
      APK_PATH="$APK_DIR/app-arm64-v8a-release.apk"
    fi
    ;;
  "arm"|"armv7"|"armeabi"|"armeabi-v7a"|"v7a")
    ARCH_NAME="armeabi-v7a"
    if compgen -G "$APK_DIR/poka-*-armeabi-v7a.apk" >/dev/null; then
      APK_PATH=$(ls -t "$APK_DIR"/poka-*-armeabi-v7a.apk | head -n 1)
    elif [ -f "$APK_DIR/poka-armeabi-v7a.apk" ]; then
      APK_PATH="$APK_DIR/poka-armeabi-v7a.apk"
    else
      APK_PATH="$APK_DIR/app-armeabi-v7a-release.apk"
    fi
    ;;
  "x86_64"|"x64"|"x86-64")
    ARCH_NAME="x86_64"
    if compgen -G "$APK_DIR/poka-*-x86_64.apk" >/dev/null; then
      APK_PATH=$(ls -t "$APK_DIR"/poka-*-x86_64.apk | head -n 1)
    elif [ -f "$APK_DIR/poka-x86_64.apk" ]; then
      APK_PATH="$APK_DIR/poka-x86_64.apk"
    else
      APK_PATH="$APK_DIR/app-x86_64-release.apk"
    fi
    ;;
  *)
    ARCH_NAME="$TARGET"
    if [ -f "$TARGET" ]; then
      APK_PATH="$TARGET"
    elif [ -f "$APK_DIR/app-${TARGET}-release.apk" ]; then
      APK_PATH="$APK_DIR/app-${TARGET}-release.apk"
    elif [ -f "$APK_DIR/app-${TARGET}.apk" ]; then
      APK_PATH="$APK_DIR/app-${TARGET}.apk"
    else
      APK_PATH="$APK_DIR/$TARGET"
    fi
    ;;
esac

# Check if file exists
if [ ! -f "$APK_PATH" ]; then
  echo "❌ Error: Target APK not found for '$TARGET' ($ARCH_NAME)."
  echo "   Expected: $APK_PATH"
  echo ""
  echo "Available APKs in $APK_DIR/:"
  if compgen -G "$APK_DIR/*.apk" >/dev/null; then
    for f in "$APK_DIR"/*.apk; do
      SIZE=$(du -h "$f" | cut -f1 | tr -d ' ')
      echo "  • $(basename "$f") ($SIZE)"
    done
  else
    echo "  (None found. Please build first.)"
  fi
  echo ""
  if [ "$TARGET" = "fat" ] || [ "$TARGET" = "universal" ]; then
    echo "💡 To build the universal APK, run: rune build:apk"
  else
    echo "💡 To build split-per-ABI APKs, run: rune build:apk --split"
  fi
  exit 1
fi

APK_FILENAME=$(basename "$APK_PATH")
APK_SIZE=$(du -h "$APK_PATH" | cut -f1 | tr -d ' ')

echo "📦 Target: $ARCH_NAME"
echo "📁 APK:    $APK_FILENAME ($APK_SIZE)"
echo "🚀 Installing to connected Android device..."

adb install -r "$APK_PATH"

if command -v rune >/dev/null 2>&1; then
  rune done "Installed $APK_FILENAME successfully!"
else
  echo "✅ Installed $APK_FILENAME successfully!"
fi
