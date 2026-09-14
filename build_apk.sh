#!/usr/bin/env bash
set -e
cd "$(dirname "$0")/../mobile"
command -v flutter >/dev/null || { echo "Flutter not found"; exit 1; }
[ -d android ] || flutter create .
flutter clean
flutter pub get
flutter analyze
flutter test
flutter build apk --release
echo "APK: $PWD/build/app/outputs/flutter-apk/app-release.apk"
