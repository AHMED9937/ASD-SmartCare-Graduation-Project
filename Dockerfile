# ==============================================================================
# ASD SmartCare - Flutter Mobile Application Build Environment
# ==============================================================================
#
# PROJECT ANALYSIS RESULTS (Auto-generated based on project scan):
#   - Dart SDK: ^3.5.4
#   - Flutter: 3.32.2 (stable)
#   - Android minSdk: 24 | compileSdk: 34 | targetSdk: 34
#   - Android Gradle Plugin: 8.6.0 (requires JDK 17+)
#   - Native Plugins: flutter_stripe, speech_to_text, record, flutter_sound,
#                     just_audio, permission_handler, image_picker, file_picker
#   - Tests: 58+ files using mocktail, bloc_test
#   - Firebase: NOT configured
#
# SUPPORTED OPERATIONS:
#   - flutter pub get       → Install dependencies
#   - flutter test          → Run unit/widget tests
#   - flutter analyze       → Static analysis
#   - flutter build apk     → Build Android APK
#   - flutter build appbundle → Build Android App Bundle
#
# CROSS-PLATFORM: Works on Linux, macOS, and Windows Docker hosts
#
# ==============================================================================

# ------------------------------------------------------------------------------
# BUILD ARGUMENTS
# ------------------------------------------------------------------------------
# Customize Flutter version and build-time configuration
# Override with: docker build --build-arg FLUTTER_VERSION=3.32.2 .
# ------------------------------------------------------------------------------
ARG FLUTTER_VERSION=3.32.2

# ==============================================================================
# STAGE 1: FLUTTER BASE ENVIRONMENT
# ==============================================================================
# Using Cirrus Labs Flutter image which includes:
#   - Flutter SDK (stable channel)
#   - Android SDK with build-tools, platform-tools, cmdline-tools
#   - OpenJDK 17 (required for Android Gradle Plugin 8.6.0)
#   - All environment variables pre-configured
# ==============================================================================
FROM ghcr.io/cirruslabs/flutter:${FLUTTER_VERSION} AS flutter-base

# Image metadata
LABEL maintainer="ASD SmartCare Team"
LABEL project="ASD-SmartCare-Graduation-Project"
LABEL description="Flutter build environment for ASD SmartCare mobile app"
LABEL flutter.version="${FLUTTER_VERSION}"
LABEL android.minSdk="24"
LABEL android.compileSdk="34"

# ------------------------------------------------------------------------------
# Environment Configuration
# ------------------------------------------------------------------------------
# Set paths and disable analytics for CI/CD
ENV FLUTTER_HOME=/sdks/flutter
ENV ANDROID_HOME=/opt/android-sdk
ENV ANDROID_SDK_ROOT=/opt/android-sdk
ENV PATH="${FLUTTER_HOME}/bin:${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}/platform-tools:${PATH}"

# Locale for consistent output
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# CI/CD optimizations
ENV CI=true
ENV FLUTTER_SUPPRESS_ANALYTICS=true
ENV PUB_CACHE=/opt/pub-cache

# Gradle memory settings (matches android/gradle.properties)
ENV GRADLE_OPTS="-Xmx4G -XX:MaxMetaspaceSize=2G -XX:+HeapDumpOnOutOfMemoryError"

WORKDIR /app

# ------------------------------------------------------------------------------
# Accept Android SDK Licenses
# ------------------------------------------------------------------------------
# Required for automated builds; accepts all licenses non-interactively
RUN yes | flutter doctor --android-licenses 2>/dev/null || true

# ------------------------------------------------------------------------------
# Pre-cache Flutter Artifacts
# ------------------------------------------------------------------------------
# Download Android-specific tools upfront for faster subsequent builds
RUN flutter precache --android

# Verify Flutter installation (useful for debugging)
RUN flutter doctor -v

# ==============================================================================
# STAGE 2: DEPENDENCIES (Cached Layer)
# ==============================================================================
# This stage isolates dependency installation for optimal Docker layer caching.
# The layer only rebuilds when pubspec.yaml or pubspec.lock change.
# ==============================================================================
FROM flutter-base AS dependencies

WORKDIR /app

# Copy ONLY dependency specification files first
COPY pubspec.yaml pubspec.lock ./

# Download all pub dependencies
# --no-example: Skip example code from dependencies
RUN flutter pub get --no-example

# ==============================================================================
# STAGE 3: SOURCE CODE + CODE GENERATION
# ==============================================================================
# Copy source code and run build_runner for generated files
# (Freezed classes, JSON serialization, Retrofit clients)
# ==============================================================================
FROM dependencies AS source

WORKDIR /app

# Copy all source code (respects .dockerignore)
COPY . .

# Re-run pub get to ensure all packages are linked correctly
RUN flutter pub get

# Run code generation for:
#   - freezed: Immutable data classes
#   - json_serializable: JSON encoding/decoding
#   - retrofit_generator: API client generation
RUN dart run build_runner build --delete-conflicting-outputs \
    || echo "⚠️ build_runner completed with warnings or no tasks"

# ==============================================================================
# STAGE 4: TEST RUNNER
# ==============================================================================
# Optimized stage for running tests
# Usage: docker build --target test -t asd-test .
#        docker run --rm asd-test
# ==============================================================================
FROM source AS test

WORKDIR /app

# Default: Run all tests
CMD ["flutter", "test", "--no-pub", "--reporter=expanded"]

# ==============================================================================
# STAGE 5: ANALYZER
# ==============================================================================
# Run static analysis
# Usage: docker build --target analyze -t asd-analyze .
# ==============================================================================
FROM source AS analyze

WORKDIR /app

CMD ["flutter", "analyze", "--no-pub"]

# ==============================================================================
# STAGE 6: APK BUILDER
# ==============================================================================
# Build release APK
# Usage: docker build --target build-apk -t asd-apk .
#        docker run --rm -v $(pwd)/build:/app/build asd-apk
# ==============================================================================
FROM source AS build-apk

WORKDIR /app

# Build arguments for environment configuration (optional)
# Pass via: docker build --build-arg API_BASE_URL=https://... .
ARG API_BASE_URL=""
ARG STRIPE_PUBLISHABLE_KEY=""

# Build release APK with optional dart-defines
RUN if [ -n "$API_BASE_URL" ] && [ -n "$STRIPE_PUBLISHABLE_KEY" ]; then \
    flutter build apk --release --no-pub \
    --dart-define=API_BASE_URL=$API_BASE_URL \
    --dart-define=STRIPE_PUBLISHABLE_KEY=$STRIPE_PUBLISHABLE_KEY; \
    else \
    flutter build apk --release --no-pub; \
    fi

# Output location: /app/build/app/outputs/flutter-apk/app-release.apk
CMD ["echo", "APK built at: /app/build/app/outputs/flutter-apk/app-release.apk"]

# ==============================================================================
# STAGE 7: APP BUNDLE BUILDER
# ==============================================================================
# Build release App Bundle for Google Play Store
# Usage: docker build --target build-aab -t asd-aab .
# ==============================================================================
FROM source AS build-aab

WORKDIR /app

ARG API_BASE_URL=""
ARG STRIPE_PUBLISHABLE_KEY=""

RUN if [ -n "$API_BASE_URL" ] && [ -n "$STRIPE_PUBLISHABLE_KEY" ]; then \
    flutter build appbundle --release --no-pub \
    --dart-define=API_BASE_URL=$API_BASE_URL \
    --dart-define=STRIPE_PUBLISHABLE_KEY=$STRIPE_PUBLISHABLE_KEY; \
    else \
    flutter build appbundle --release --no-pub; \
    fi

# Output: /app/build/app/outputs/bundle/release/app-release.aab
CMD ["echo", "AAB built at: /app/build/app/outputs/bundle/release/app-release.aab"]

# ==============================================================================
# STAGE 8: DEFAULT (Full Development Environment)
# ==============================================================================
# Default stage with all capabilities
# Usage: docker build -t asd-smartcare .
# ==============================================================================
FROM source AS app

WORKDIR /app

# Final verification
RUN flutter doctor -v

# Default command: Run tests
CMD ["flutter", "test", "--no-pub"]

# ==============================================================================
# USAGE QUICK REFERENCE
# ==============================================================================
#
# ┌─────────────────────────────────────────────────────────────────────────────┐
# │ BUILD COMMANDS                                                              │
# ├─────────────────────────────────────────────────────────────────────────────┤
# │ Full image:        docker build -t asd-smartcare .                         │
# │ Test stage only:   docker build --target test -t asd-test .                │
# │ APK builder:       docker build --target build-apk -t asd-apk .            │
# │ With env vars:     docker build --build-arg API_BASE_URL=https://... .     │
# └─────────────────────────────────────────────────────────────────────────────┘
#
# ┌─────────────────────────────────────────────────────────────────────────────┐
# │ RUN COMMANDS                                                                │
# ├─────────────────────────────────────────────────────────────────────────────┤
# │ Run tests:         docker run --rm asd-smartcare                           │
# │ Run analysis:      docker run --rm asd-smartcare flutter analyze           │
# │ Build APK:         docker run --rm -v $(pwd)/build:/app/build \            │
# │                        asd-smartcare flutter build apk --release           │
# │ Interactive shell: docker run --rm -it asd-smartcare bash                  │
# └─────────────────────────────────────────────────────────────────────────────┘
#
# ┌─────────────────────────────────────────────────────────────────────────────┐
# │ PLATFORM-SPECIFIC VOLUME MOUNTING                                          │
# ├─────────────────────────────────────────────────────────────────────────────┤
# │ Linux/macOS:    -v $(pwd)/build:/app/build                                 │
# │ PowerShell:     -v ${PWD}/build:/app/build                                 │
# │ CMD:            -v %cd%/build:/app/build                                   │
# └─────────────────────────────────────────────────────────────────────────────┘
#
# ==============================================================================
