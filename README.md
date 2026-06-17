# A SynthEdit module, built & released by GitHub Actions

This repository is the companion example for the SynthEdit tutorial
**[Building modules with GitHub Actions](https://synthedit.com/new/guides/building-modules-with-github-actions/)**.

It takes one tiny C++ module — [`Gain/Gain.cpp`](Gain/Gain.cpp), a gain control built with
the **GMPI SDK** — and lets GitHub compile and package it for both platforms:

```
   git tag v1.0.0  ─►  GitHub Actions
                          ├─ Windows runner ─► CMake/MSVC  ─► Gain.gmpi ─► Inno Setup ─► TutorialGain-1.0.0-Windows.exe
                          ├─ macOS runner   ─► CMake/clang ─► Gain.gmpi ─► pkgbuild   ─► TutorialGain-1.0.0-macOS.pkg
                          └─ release job ───► GitHub Release  ◄── both installers attached
```

No build machine, and **no Mac required** — GitHub provides both runners, and CMake
downloads the GMPI SDK automatically on the first build, so you clone just this one repo.

## Use it yourself

1. **Fork** this repository (or use it as a template).
2. Edit [`Gain/Gain.cpp`](Gain/Gain.cpp) — change the DSP, rename pins, add parameters. Give
   the module a unique `id` in its XML.
3. **Tag a version** and push it:
   ```bash
   git tag v1.0.0
   git push origin v1.0.0
   ```
4. Watch the **Actions** tab. When it finishes, your installers are on the **Releases** page.

To do a dry run without publishing, use **Actions → Build & Release Module → Run workflow**.

## What's in here

| Path | Purpose |
|------|---------|
| [`Gain/Gain.cpp`](Gain/Gain.cpp) | The module: pins, the audio processing loop, and the XML that registers it with SynthEdit. |
| [`Gain/CMakeLists.txt`](Gain/CMakeLists.txt) | One `gmpi_plugin()` call naming the source files and output format. |
| [`CMakeLists.txt`](CMakeLists.txt) | Master recipe — fetches the GMPI SDK from GitHub, sets compiler options. |
| [`.github/workflows/build-module.yml`](.github/workflows/build-module.yml) | The pipeline: compile → package → release, on Windows + macOS. |
| [`installer/windows/gain.iss`](installer/windows/gain.iss) | Inno Setup script — installs `Gain.gmpi` into `Common Files\SynthEdit\modules`. |
| [`installer/macos/build-pkg.sh`](installer/macos/build-pkg.sh) | `pkgbuild` script — installs the `.gmpi` into `/Library/Audio/Plug-Ins/GMPI`. |

## Build it locally

```bash
cmake -B build -DCMAKE_BUILD_TYPE=Release -S .
cmake --build build --config Release
```

You need **CMake 3.30+** and a C++20 compiler (Visual Studio 2022 on Windows, Xcode on
macOS). The module lands under `build/Gain/` (in a `Release/` subfolder with Visual Studio
or Xcode). To try it, copy it into
`C:\Program Files\Common Files\SynthEdit\modules` (Windows) or
`~/Library/Audio/Plug-Ins/GMPI` (macOS) and restart SynthEdit — it appears in the **Insert**
menu under the *Examples* category.

## GMPI vs. the legacy SEM (SDK3)

This example uses the modern **GMPI SDK**. SynthEdit also still loads modules built with the
older **SDK3** (`.sem` files). The build and packaging in this repo work the same either way
— the differences are in the C++ (base class, pin setup, GUI API). The tutorial has a
side-by-side comparison.

## A note on signing

Modules load unsigned, so there's nothing to sign in the `.gmpi` itself. The **installers**
are unsigned, so first-run shows a Windows SmartScreen prompt ("More info → Run anyway") and
on macOS you'll right-click → **Open** the `.pkg` (or `xattr -dr com.apple.quarantine` it).
The tutorial covers adding real signing for production.

---

Built with the [GMPI SDK](https://github.com/JeffMcClintock/GMPI). Tutorial: **[Building
modules with GitHub Actions](https://synthedit.com/new/guides/building-modules-with-github-actions/)**.
