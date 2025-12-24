# Docker Setup Guide

This document provides complete instructions for building and testing the ASD SmartCare Flutter application using Docker.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Docker Commands Reference](#docker-commands-reference)
- [Building the Docker Image](#building-the-docker-image)
- [Running Tests](#running-tests)
- [Building Release APK](#building-release-apk)
- [Extracting Build Artifacts](#extracting-build-artifacts)
- [Using Docker Compose](#using-docker-compose)
- [Environment Variables](#environment-variables)
- [CI/CD Integration](#cicd-integration)
- [Troubleshooting](#troubleshooting)
- [Image Size Optimization](#image-size-optimization)

---

## Prerequisites

| Requirement | Minimum Version | Notes |
|-------------|-----------------|-------|
| Docker Desktop | 4.0+ | [Download](https://www.docker.com/products/docker-desktop/) |
| Docker Engine | 20.10+ | Included with Docker Desktop |
| Docker Compose | 2.0+ | Included with Docker Desktop |
| Disk Space | **15GB+** | Flutter SDK + Android SDK + build cache |
| RAM | **6GB+** | Recommended for APK builds |

> **Windows Users:** Ensure Docker Desktop is configured to use **Linux containers** (default setting).

---

## Quick Start

```bash
# 1. Build the Docker image
docker compose build

# 2. Run all tests
docker compose up test

# 3. Build release APK
docker compose up build-apk

# 4. Find your APK
ls ./build/app/outputs/flutter-apk/
# → app-release.apk
```

---

## Docker Commands Reference

### Using Docker Compose (Recommended)

| Task | Command |
|------|---------|
| Build all images | `docker compose build` |
| Run tests | `docker compose up test` |
| Run static analysis | `docker compose up analyze` |
| Check formatting | `docker compose up format-check` |
| Build APK | `docker compose up build-apk` |
| Build App Bundle | `docker compose up build-aab` |
| Run full CI | `docker compose up ci` |
| Interactive shell | `docker compose run --rm dev bash` |
| Clean up | `docker compose down -v` |

### Using Docker CLI

| Task | Command |
|------|---------|
| Build image | `docker build -t asd-smartcare .` |
| Run tests | `docker run --rm asd-smartcare` |
| Run analysis | `docker run --rm asd-smartcare flutter analyze` |
| Interactive shell | `docker run --rm -it asd-smartcare bash` |

---

## Building the Docker Image

### Standard Build

```bash
docker build -t asd-smartcare .
```

### Build Specific Stage

The Dockerfile uses multi-stage builds with these targets:

| Stage | Purpose | Usage |
|-------|---------|-------|
| `flutter-base` | Base Flutter SDK | Internal |
| `dependencies` | Cached pub dependencies | `--target dependencies` |
| `source` | Full source code | `--target source` |
| `test` | Optimized for testing | `--target test` |
| `analyze` | Static analysis | `--target analyze` |
| `build-apk` | APK builder | `--target build-apk` |
| `build-aab` | App Bundle builder | `--target build-aab` |
| `app` | Default (full) | Default |

```bash
# Build test-optimized image
docker build --target test -t asd-smartcare:test .

# Build APK builder image
docker build --target build-apk -t asd-smartcare:apk .
```

### Build with Custom Flutter Version

```bash
docker build --build-arg FLUTTER_VERSION=3.32.2 -t asd-smartcare .
```

### Build with Verbose Output

```bash
docker build --progress=plain -t asd-smartcare .
```

---

## Running Tests

### Run All Tests

```bash
# Using Docker Compose
docker compose up test

# Using Docker CLI
docker run --rm asd-smartcare flutter test --no-pub
```

### Run Tests with Coverage

```bash
# Output coverage to host machine
docker run --rm -v $(pwd)/coverage:/app/coverage asd-smartcare \
    flutter test --no-pub --coverage

# View coverage summary (requires lcov on host)
lcov --summary coverage/lcov.info
```

### Run Specific Test File

```bash
docker run --rm asd-smartcare \
    flutter test --no-pub test/parent/home/parent_home_screen_test.dart
```

### Run Tests with Verbose Output

```bash
docker run --rm asd-smartcare \
    flutter test --no-pub --reporter=expanded
```

---

## Building Release APK

### Method 1: Using Docker Compose

```bash
docker compose up build-apk
```

### Method 2: Using Docker CLI

<details>
<summary><strong>Linux / macOS</strong></summary>

```bash
docker run --rm -v $(pwd)/build:/app/build asd-smartcare \
    flutter build apk --release --no-pub
```
</details>

<details>
<summary><strong>Windows PowerShell</strong></summary>

```powershell
docker run --rm -v ${PWD}/build:/app/build asd-smartcare `
    flutter build apk --release --no-pub
```
</details>

<details>
<summary><strong>Windows Command Prompt</strong></summary>

```cmd
docker run --rm -v %cd%/build:/app/build asd-smartcare ^
    flutter build apk --release --no-pub
```
</details>

### Build with Environment Variables

```bash
docker run --rm -v $(pwd)/build:/app/build asd-smartcare \
    flutter build apk --release --no-pub \
    --dart-define=API_BASE_URL=https://your-api.com/ \
    --dart-define=STRIPE_PUBLISHABLE_KEY=pk_live_xxx
```

### Build App Bundle (for Play Store)

```bash
docker run --rm -v $(pwd)/build:/app/build asd-smartcare \
    flutter build appbundle --release --no-pub
```

---

## Extracting Build Artifacts

After building, artifacts are automatically available on your host machine via volume mounting.

### Artifact Locations

| Artifact | Path |
|----------|------|
| Release APK | `./build/app/outputs/flutter-apk/app-release.apk` |
| Debug APK | `./build/app/outputs/flutter-apk/app-debug.apk` |
| App Bundle (AAB) | `./build/app/outputs/bundle/release/app-release.aab` |
| Coverage Report | `./coverage/lcov.info` |
| Coverage HTML | `./coverage/html/index.html` |

### Manual Copy from Container

If you didn't use volume mounting, copy from a running container:

```bash
# Create container without --rm
docker run --name asd-build asd-smartcare flutter build apk --release --no-pub

# Copy APK to host
docker cp asd-build:/app/build/app/outputs/flutter-apk/app-release.apk ./my-app.apk

# Clean up
docker rm asd-build
```

---

## Using Docker Compose

### Available Services

| Service | Description |
|---------|-------------|
| `dev` | Interactive development shell |
| `test` | Run all tests with coverage |
| `analyze` | Static code analysis |
| `format-check` | Check code formatting |
| `build-apk` | Build release APK |
| `build-aab` | Build App Bundle |
| `ci` | Full CI pipeline (format → analyze → test) |

### Build All Services

```bash
docker compose build
```

### Run Full CI Pipeline

```bash
docker compose up ci
```

### Interactive Development

```bash
docker compose run --rm dev bash

# Inside container:
flutter doctor -v
flutter test test/specific_test.dart
flutter build apk --debug
```

### Environment Variables with Docker Compose

Create a `.env` file (not committed to git):

```env
API_BASE_URL=https://your-api.com/
STRIPE_PUBLISHABLE_KEY=pk_live_xxx
```

Then build:

```bash
docker compose up build-apk
```

Or pass inline:

```bash
API_BASE_URL=https://api.example.com STRIPE_PUBLISHABLE_KEY=pk_xxx \
    docker compose up build-apk
```

---

## Environment Variables

The application supports these environment variables:

| Variable | Required | Description |
|----------|----------|-------------|
| `API_BASE_URL` | Yes | Backend API endpoint |
| `STRIPE_PUBLISHABLE_KEY` | Yes | Stripe public key (safe for client) |
| `STRIPE_SECRET_KEY` | Server only | ⚠️ Never include in Docker image! |

### Passing at Build Time

```bash
docker build \
    --build-arg API_BASE_URL=https://api.example.com \
    --build-arg STRIPE_PUBLISHABLE_KEY=pk_live_xxx \
    -t asd-smartcare .
```

### Passing at Runtime

```bash
docker run --rm \
    -e API_BASE_URL=https://api.example.com \
    -e STRIPE_PUBLISHABLE_KEY=pk_live_xxx \
    asd-smartcare flutter build apk --release \
    --dart-define=API_BASE_URL=$API_BASE_URL \
    --dart-define=STRIPE_PUBLISHABLE_KEY=$STRIPE_PUBLISHABLE_KEY
```

---

## CI/CD Integration

### GitHub Actions Example

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Build Docker image
        run: docker build -t asd-smartcare .
      
      - name: Run tests
        run: docker run --rm asd-smartcare flutter test --no-pub
      
      - name: Build APK
        run: |
          docker run --rm -v $(pwd)/build:/app/build asd-smartcare \
            flutter build apk --release --no-pub \
            --dart-define=API_BASE_URL=${{ secrets.API_BASE_URL }} \
            --dart-define=STRIPE_PUBLISHABLE_KEY=${{ secrets.STRIPE_KEY }}
      
      - name: Upload APK
        uses: actions/upload-artifact@v4
        with:
          name: release-apk
          path: build/app/outputs/flutter-apk/app-release.apk
```

### GitLab CI Example

```yaml
build:
  image: docker:24
  services:
    - docker:dind
  script:
    - docker build -t asd-smartcare .
    - docker run --rm asd-smartcare flutter test --no-pub
    - docker run --rm -v $(pwd)/build:/app/build asd-smartcare flutter build apk --release
  artifacts:
    paths:
      - build/app/outputs/flutter-apk/app-release.apk
```

---

## Troubleshooting

<details>
<summary><strong>❌ Build fails with "no space left on device"</strong></summary>

Docker images can be large. Clean up unused resources:

```bash
# Remove unused images, containers, volumes
docker system prune -a --volumes

# Check disk usage
docker system df
```
</details>

<details>
<summary><strong>❌ Build is extremely slow</strong></summary>

1. **Increase Docker resources:**
   - Docker Desktop → Settings → Resources
   - Memory: 6GB+ recommended
   - CPUs: 4+ recommended

2. **Use BuildKit for better caching:**
   ```bash
   DOCKER_BUILDKIT=1 docker build -t asd-smartcare .
   ```

3. **Check .dockerignore:**
   - Ensure `build/`, `.git/`, and large directories are excluded
</details>

<details>
<summary><strong>❌ Volume mounting doesn't work on Windows</strong></summary>

1. Ensure drive sharing is enabled:
   - Docker Desktop → Settings → Resources → File Sharing
   - Add your project drive (e.g., `C:\`)

2. Use forward slashes in paths:
   ```powershell
   docker run -v C:/Projects/build:/app/build asd-smartcare
   ```
</details>

<details>
<summary><strong>❌ Gradle build fails with OutOfMemoryError</strong></summary>

The project requires 4GB JVM heap. This is configured in the Dockerfile, but verify:

```bash
docker run --rm asd-smartcare bash -c 'echo $GRADLE_OPTS'
# Should show: -Xmx4G -XX:MaxMetaspaceSize=2G
```

If still failing, increase Docker memory allocation.
</details>

<details>
<summary><strong>❌ Tests fail with "Invalid kernel binary format version"</strong></summary>

This indicates a Flutter SDK mismatch. Rebuild with no cache:

```bash
docker build --no-cache -t asd-smartcare .
```
</details>

<details>
<summary><strong>❌ Cannot connect to Docker daemon</strong></summary>

1. Ensure Docker Desktop is running
2. On Linux, add user to docker group:
   ```bash
   sudo usermod -aG docker $USER
   # Log out and back in
   ```
</details>

---

## Image Size Optimization

The full image is large (~5-8GB) due to Flutter SDK and Android SDK. To optimize:

### 1. Use Specific Build Stages

```bash
# Test stage (smaller, no build artifacts)
docker build --target test -t asd-smartcare:test .

# Only what you need
docker build --target dependencies -t asd-smartcare:deps .
```

### 2. Clean Up After Build

```bash
# Remove dangling images
docker image prune -f

# Remove build cache
docker builder prune -f
```

### 3. Multi-Platform Considerations

The image is Linux-based. For Mac M1/M2 (ARM):

```bash
# Build for specific platform
docker build --platform linux/amd64 -t asd-smartcare .
```

---

## Summary

| Task | Recommended Command |
|------|---------------------|
| **Build Image** | `docker compose build` |
| **Run Tests** | `docker compose up test` |
| **Build APK** | `docker compose up build-apk` |
| **Get APK** | `./build/app/outputs/flutter-apk/app-release.apk` |
| **Full CI** | `docker compose up ci` |
| **Debug** | `docker compose run --rm dev bash` |
| **Clean Up** | `docker compose down -v && docker system prune` |

---

*Generated for ASD SmartCare Flutter Project - December 2024*
