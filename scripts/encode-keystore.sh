#!/bin/bash
# =============================================================================
# ASD SmartCare - Keystore Encoding Script (Bash)
# =============================================================================
#
# This script encodes your Android keystore file to Base64 for use with
# GitHub Secrets in CI/CD workflows.
#
# Usage:
#   ./scripts/encode-keystore.sh [path/to/keystore.jks]
#
# Default keystore path: android/upload-keystore.jks
#
# The output can be copied directly to GitHub Secrets as KEYSTORE_BASE64.
#
# =============================================================================

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
KEYSTORE_PATH="${1:-android/upload-keystore.jks}"

echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}  ASD SmartCare - Keystore Encoder for GitHub Secrets${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo ""

# Resolve path
RESOLVED_PATH=""
for path in "$KEYSTORE_PATH" "$PROJECT_ROOT/$KEYSTORE_PATH" "$PWD/$KEYSTORE_PATH"; do
    if [ -f "$path" ]; then
        RESOLVED_PATH="$path"
        break
    fi
done

if [ -z "$RESOLVED_PATH" ]; then
    echo -e "${RED}✗ Keystore file not found: $KEYSTORE_PATH${NC}"
    echo ""
    echo -e "${YELLOW}Searched locations:${NC}"
    echo "  - $KEYSTORE_PATH"
    echo "  - $PROJECT_ROOT/$KEYSTORE_PATH"
    echo "  - $PWD/$KEYSTORE_PATH"
    echo ""
    echo -e "${CYAN}Usage:${NC}"
    echo "  ./scripts/encode-keystore.sh [path/to/keystore.jks]"
    echo ""
    echo -e "${CYAN}Example:${NC}"
    echo "  ./scripts/encode-keystore.sh android/upload-keystore.jks"
    exit 1
fi

echo -e "${GREEN}✓ Found keystore: $RESOLVED_PATH${NC}"

# Get file info
FILE_SIZE=$(du -h "$RESOLVED_PATH" | cut -f1)
FILE_DATE=$(stat -c %y "$RESOLVED_PATH" 2>/dev/null || stat -f %Sm "$RESOLVED_PATH")

echo "  Size: $FILE_SIZE"
echo "  Modified: $FILE_DATE"
echo ""

# Encode to Base64
echo -e "${CYAN}Encoding to Base64...${NC}"

# Use different base64 command based on OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    BASE64=$(base64 -i "$RESOLVED_PATH" | tr -d '\n')
else
    # Linux
    BASE64=$(base64 -w 0 "$RESOLVED_PATH")
fi

BASE64_LENGTH=${#BASE64}

echo -e "${GREEN}✓ Encoded successfully!${NC}"
echo "  Base64 length: $BASE64_LENGTH characters"
echo ""

# Instructions
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}  GitHub Secrets Setup Instructions${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo ""
echo "1. Go to your GitHub repository"
echo "2. Navigate to: Settings → Secrets and variables → Actions"
echo "3. Click 'New repository secret'"
echo "4. Add these secrets:"
echo ""
echo -e "${YELLOW}   Secret Name: KEYSTORE_BASE64${NC}"
echo "   Value: (see below or copied to clipboard)"
echo ""
echo -e "${YELLOW}   Secret Name: KEYSTORE_PASSWORD${NC}"
echo "   Value: (your keystore password)"
echo ""
echo -e "${YELLOW}   Secret Name: KEY_ALIAS${NC}"
echo "   Value: upload (or your key alias)"
echo ""
echo -e "${YELLOW}   Secret Name: KEY_PASSWORD${NC}"
echo "   Value: (your key password)"
echo ""

# Try to copy to clipboard
if command -v pbcopy &> /dev/null; then
    echo "$BASE64" | pbcopy
    echo -e "${GREEN}✓ Base64 string copied to clipboard! (macOS)${NC}"
elif command -v xclip &> /dev/null; then
    echo "$BASE64" | xclip -selection clipboard
    echo -e "${GREEN}✓ Base64 string copied to clipboard! (Linux)${NC}"
else
    echo -e "${YELLOW}Clipboard not available. Base64 saved to file.${NC}"
fi

# Save to file
OUTPUT_FILE="$PROJECT_ROOT/keystore-base64.txt"
echo -n "$BASE64" > "$OUTPUT_FILE"
echo ""
echo "Base64 also saved to: $OUTPUT_FILE"
echo ""
echo -e "${RED}⚠ SECURITY WARNING:${NC}"
echo -e "${RED}  Delete the keystore-base64.txt file after copying to GitHub!${NC}"
echo -e "${RED}  Do NOT commit this file to version control!${NC}"
echo ""

# Ask to display
echo -n -e "${CYAN}Display the Base64 string? (y/n): ${NC}"
read -r RESPONSE

if [[ "$RESPONSE" =~ ^[Yy]$ ]]; then
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  KEYSTORE_BASE64 Value (copy this entire string)${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo ""
    echo "$BASE64"
    echo ""
fi

echo -e "${GREEN}Done!${NC}"
