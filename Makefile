.PHONY: help run build clean generate assets check fix keystore test test\:unit test\:e2e test\:feature

# Default target
help:
	@echo "Poka CE - Available Commands:"
	@echo "--------------------------------------------------------"
	@echo "Development:"
	@echo "  make run      - Run the app on a connected emulator/device"
	@echo "  make generate - Run build_runner to generate files (Riverpod, Freezed, Drift)"
	@echo "  make assets   - Generate launcher icons and native splash screens"
	@echo "  make clean    - Clean the cache and fetch dependencies"
	@echo ""
	@echo "Quality:"
	@echo "  make check    - Analyze code for lints/errors"
	@echo "  make fix      - Automatically fix lints and format code"
	@echo "  make test     - Run unit and e2e test suite"
	@echo "  make test:unit        - Run only unit tests"
	@echo "  make test:e2e         - Run only end-to-end (E2E) headless tests"
	@echo "  make test:feature     - Run only feature-level tests"
	@echo ""
	@echo "Build & Release:"
	@echo "  make build    - Build the application (Android APK)"
	@echo "  make keystore - Generate a new Android Keystore for CI release"
	@echo "--------------------------------------------------------"

# ==========================================
# Development
# ==========================================

run:
	flutter run --dart-define-from-file=.env

generate:
	rm -f lib/i18n/*.g.dart
	dart run build_runner build
	dart format .

assets:
	dart run flutter_launcher_icons
	dart run flutter_native_splash:create

clean:
	flutter clean
	flutter pub get

# ==========================================
# Quality
# ==========================================

check:
	flutter analyze

fix:
	dart fix --apply
	dart format .

test:
	@echo "Running Unit Tests..."
	flutter test test/unit
	@echo "Running Feature Tests..."
	flutter test test/feature
	@echo "Running E2E Headless Tests..."
	flutter test test/e2e

test\:unit:
	flutter test test/unit

test\:e2e:
	flutter test test/e2e

test\:feature:
	flutter test test/feature

# ==========================================
# Build & Release
# ==========================================

build:
	flutter build apk --dart-define-from-file=.env
	mv build/app/outputs/flutter-apk/app-release.apk build/app/outputs/flutter-apk/app-universal-release.apk
	flutter build apk --split-per-abi --dart-define-from-file=.env

keystore:
	@chmod +x scripts/keystore.sh
	@./scripts/keystore.sh
