#!/bin/bash
# =============================================================================
# ASD SmartCare - Local Deployment Helper Script
# =============================================================================
#
# This script helps with local release builds and deployment verification.
#
# Usage:
#   ./scripts/deploy.sh [command]
#
# Commands:
#   build-apk     Build signed release APK
#   build-aab     Build signed release App Bundle (for Play Store)
#   build-all     Build both APK and AAB
#   verify        Verify APK signing and show build info
#   clean         Clean build artifacts
#   help          Show this help message
#
# =============================================================================

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Project paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
ANDROID_DIR="$PROJECT_ROOT/android"
APK_PATH="$PROJECT_ROOT/build/app/outputs/flutter-apk/app-release.apk"
AAB_PATH="$PROJECT_ROOT/build/app/outputs/bundle/release/app-release.aab"

# =============================================================================
# Helper Functions
# =============================================================================

print_header() {
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo ""
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

check_prerequisites() {
    print_header "Checking Prerequisites"
    
    # Check Flutter
    if ! command -v flutter &> /dev/null; then
        print_error "Flutter is not installed or not in PATH"
        exit 1
    fi
    print_success "Flutter found: $(flutter --version | head -n 1)"
    
    # Check key.properties
    if [ ! -f "$ANDROID_DIR/key.properties" ]; then
        print_warning "android/key.properties not found"
        print_info "Release builds will use debug signing"
        print_info "See android/key.properties.example for setup instructions"
        echo ""
        read -p "Continue with debug signing? (y/n) " -n 1 -r
        echo ""
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 1
        fi
    else
        print_success "key.properties found"
    fi
    
    # Check keystore file
    if [ -f "$ANDROID_DIR/key.properties" ]; then
        STORE_FILE=$(grep "storeFile" "$ANDROID_DIR/key.properties" | cut -d'=' -f2)
        KEYSTORE_PATH="$ANDROID_DIR/app/$STORE_FILE"
        if [ ! -f "$KEYSTORE_PATH" ]; then
            print_error "Keystore file not found: $KEYSTORE_PATH"
            print_info "Check the storeFile path in key.properties"
            exit 1
        fi
        print_success "Keystore file found"
    fi
}

get_version() {
    # Extract version from pubspec.yaml
    VERSION=$(grep "^version:" "$PROJECT_ROOT/pubspec.yaml" | sed 's/version: //')
    echo "$VERSION"
}

# =============================================================================
# Build Commands
# =============================================================================

build_apk() {
    print_header "Building Release APK"
    
    check_prerequisites
    
    VERSION=$(get_version)
    print_info "Building version: $VERSION"
    
    cd "$PROJECT_ROOT"
    flutter build apk --release
    
    if [ -f "$APK_PATH" ]; then
        SIZE=$(du -h "$APK_PATH" | cut -f1)
        print_success "APK built successfully!"
        echo ""
        echo "  Path: $APK_PATH"
        echo "  Size: $SIZE"
        echo "  Version: $VERSION"
    else
        print_error "APK build failed"
        exit 1
    fi
}

build_aab() {
    print_header "Building Release App Bundle"
    
    check_prerequisites
    
    VERSION=$(get_version)
    print_info "Building version: $VERSION"
    
    cd "$PROJECT_ROOT"
    flutter build appbundle --release
    
    if [ -f "$AAB_PATH" ]; then
        SIZE=$(du -h "$AAB_PATH" | cut -f1)
        print_success "App Bundle built successfully!"
        echo ""
        echo "  Path: $AAB_PATH"
        echo "  Size: $SIZE"
        echo "  Version: $VERSION"
    else
        print_error "App Bundle build failed"
        exit 1
    fi
}

build_all() {
    build_apk
    build_aab
    
    print_header "Build Summary"
    VERSION=$(get_version)
    
    echo "Version: $VERSION"
    echo ""
    echo "Artifacts:"
    if [ -f "$APK_PATH" ]; then
        echo "  APK: $APK_PATH ($(du -h "$APK_PATH" | cut -f1))"
    fi
    if [ -f "$AAB_PATH" ]; then
        echo "  AAB: $AAB_PATH ($(du -h "$AAB_PATH" | cut -f1))"
    fi
}

# =============================================================================
# Verification Commands
# =============================================================================

verify_apk() {
    print_header "Verifying APK Signing"
    
    if [ ! -f "$APK_PATH" ]; then
        print_error "APK not found. Run 'deploy.sh build-apk' first."
        exit 1
    fi
    
    # Check if jarsigner is available
    if ! command -v jarsigner &> /dev/null; then
        print_warning "jarsigner not found. Install JDK for full verification."
        print_info "Showing basic APK info only..."
    else
        echo "Signature verification:"
        jarsigner -verify -verbose -certs "$APK_PATH" 2>&1 | head -20
        echo ""
    fi
    
    # APK info
    print_info "APK Details:"
    echo "  Path: $APK_PATH"
    echo "  Size: $(du -h "$APK_PATH" | cut -f1)"
    echo "  Modified: $(stat -c %y "$APK_PATH" 2>/dev/null || stat -f %Sm "$APK_PATH")"
    
    # Check if aapt is available for more details
    if command -v aapt &> /dev/null; then
        echo ""
        echo "Package info:"
        aapt dump badging "$APK_PATH" 2>/dev/null | grep -E "^package:|^application-label:|^sdkVersion:|^targetSdkVersion:" | head -10
    fi
}

# =============================================================================
# Utility Commands
# =============================================================================

clean_build() {
    print_header "Cleaning Build Artifacts"
    
    cd "$PROJECT_ROOT"
    flutter clean
    
    print_success "Build artifacts cleaned"
}

show_help() {
    echo "ASD SmartCare - Local Deployment Helper"
    echo ""
    echo "Usage: ./scripts/deploy.sh [command]"
    echo ""
    echo "Commands:"
    echo "  build-apk     Build signed release APK"
    echo "  build-aab     Build signed release App Bundle (for Play Store)"
    echo "  build-all     Build both APK and AAB"
    echo "  verify        Verify APK signing and show build info"
    echo "  clean         Clean build artifacts"
    echo "  help          Show this help message"
    echo ""
    echo "Examples:"
    echo "  ./scripts/deploy.sh build-apk"
    echo "  ./scripts/deploy.sh verify"
    echo ""
    echo "Prerequisites:"
    echo "  - Flutter SDK installed and in PATH"
    echo "  - android/key.properties configured (for release signing)"
    echo "  - Keystore file in place"
    echo ""
    echo "See DEPLOYMENT.md for complete deployment instructions."
}

# =============================================================================
# Main Entry Point
# =============================================================================

case "${1:-help}" in
    build-apk)
        build_apk
        ;;
    build-aab)
        build_aab
        ;;
    build-all)
        build_all
        ;;
    verify)
        verify_apk
        ;;
    clean)
        clean_build
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        print_error "Unknown command: $1"
        echo ""
        show_help
        exit 1
        ;;
esac
