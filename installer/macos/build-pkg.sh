#!/usr/bin/env bash
# Build an (unsigned) macOS .pkg that installs the Tutorial Gain module into the
# system GMPI modules folder. Run from the repo root after CMake has built the module.
# Usage: installer/macos/build-pkg.sh [version]
set -euo pipefail

VERSION="${1:-0.0.0}"
VENDOR="SynthEdit Tutorial"
IDENTIFIER="com.synthedit-tutorial.gain"

MODULE="build/Gain/Release/Gain.gmpi"     # the .gmpi bundle (a folder on macOS)
ROOT="installer/macos/pkgroot"
OUT="installer/macos/out"

rm -rf "$ROOT" "$OUT"
mkdir -p "$ROOT/Library/Audio/Plug-Ins/GMPI/$VENDOR" "$OUT"
cp -R "$MODULE" "$ROOT/Library/Audio/Plug-Ins/GMPI/$VENDOR/"

# A component package that drops the module into /Library/Audio/Plug-Ins/GMPI at install.
pkgbuild \
  --root "$ROOT" \
  --install-location "/" \
  --identifier "$IDENTIFIER" \
  --version "$VERSION" \
  "$OUT/TutorialGain-$VERSION-macOS.pkg"

echo "Built $OUT/TutorialGain-$VERSION-macOS.pkg"
