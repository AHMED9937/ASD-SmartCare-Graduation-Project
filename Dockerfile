# ==============================================================================
# ASD SmartCare - Flutter Build Environment
# ==============================================================================
# This Dockerfile provides a reproducible environment for:
# - Running tests (flutter test)
# - Building Android APK/AAB (flutter build apk/appbundle)
# - Running static analysis (flutter analyze)
#
# NOTE: This container is for CI/CD and local dev consistency.
#       Mobile apps run on devices/emulators, not in containers.
# ==============================================================================

# Use official Flutter image from Cirrus Labs (includes Android SDK)
FROM ghcr.io/cirruslabs/flutter:3.32.2

# Set working directory
WORKDIR /app

# Accept Android licenses
RUN yes | flutter doctor --android-licenses || true

# Pre-cache Flutter artifacts for faster builds
RUN flutter precache --android

# ==============================================================================
# Dependency Installation (cached layer)
# ==============================================================================
# Copy only dependency files first for better Docker layer caching
COPY pubspec.yaml pubspec.lock ./

# Get dependencies (this layer will be cached if pubspec files don't change)
RUN flutter pub get

# ==============================================================================
# Application Code
# ==============================================================================
# Copy the rest of the application
COPY . .

# Re-run pub get to link local packages
RUN flutter pub get

# ==============================================================================
# Verification
# ==============================================================================
# Verify Flutter is working
RUN flutter doctor -v

# ==============================================================================
# Default Command
# ==============================================================================
# Default: run tests
CMD ["flutter", "test"]

# ==============================================================================
# Usage Examples
# ==============================================================================
# 
# Build the image:
#   docker build -t asd-smartcare-build .
#
# Run tests:
#   docker run --rm asd-smartcare-build flutter test
#
# Run analysis:
#   docker run --rm asd-smartcare-build flutter analyze
#
# Build release APK (output to host):
#   docker run --rm -v $(pwd)/build:/app/build asd-smartcare-build flutter build apk --release
#
# Build release AAB:
#   docker run --rm -v $(pwd)/build:/app/build asd-smartcare-build flutter build appbundle --release
#
# Interactive shell:
#   docker run --rm -it asd-smartcare-build bash
