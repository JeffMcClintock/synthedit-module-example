#!/usr/bin/env bash
# Build an (unsigned) macOS .pkg that installs the Tutorial Gain module into the
# system GMPI modules folder. Run from the repo root after CMake has built the module.
# Usage: installer/macos/build-pkg.sh [version]
set -euo pipefail

VERSION="${1:-0.0.0}"
VENDOR="SynthEdit Tutorial"
IDENTIFIER="com.synthedit-tutorial.gain"

# CMake's output subfolder depends on the generator (a Release/ subfolder with Xcode or
# Visual Studio, none with Unix Makefiles), so locate the built bundle rather than
# hard-coding the path.
MODULE=$(find build -name "Gain.gmpi" -type d | head -n1 || true)
if [ -z "$MODULE" ]; then echo "error: Gain.gmpi not found under build/"; exit 1; fi
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
