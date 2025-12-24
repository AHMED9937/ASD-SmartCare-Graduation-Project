#!/bin/bash
# ==============================================================================
# Keystore Base64 Encoder for GitHub Secrets
# ==============================================================================
# This script encodes an Android keystore file to Base64 for use in GitHub Actions
#
# Usage:
#   ./encode-keystore.sh path/to/upload-keystore.jks
#
# Output:
#   - Prints Base64 string to console
#   - Saves to keystore_base64.txt
#   - Copies to clipboard (macOS/Linux)
# ==============================================================================

set -e

# Check argument
if [ -z "$1" ]; then
    echo "Usage: $0 <keystore-path>"
    echo "Example: $0 upload-keystore.jks"
    exit 1
fi

KEYSTORE_PATH="$1"
OUTPUT_FILE="keystore_base64.txt"

# Verify file exists
if [ ! -f "$KEYSTORE_PATH" ]; then
    echo "❌ Error: Keystore file not found: $KEYSTORE_PATH"
    exit 1
fi

# Get file info
FILE_SIZE=$(stat -f%z "$KEYSTORE_PATH" 2>/dev/null || stat -c%s "$KEYSTORE_PATH" 2>/dev/null)
echo "📁 Encoding keystore: $(basename "$KEYSTORE_PATH")"
echo "   Size: $FILE_SIZE bytes"

# Encode to Base64 (remove line breaks)
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    BASE64=$(base64 -i "$KEYSTORE_PATH" | tr -d '\n')
else
    # Linux
    BASE64=$(base64 -w 0 "$KEYSTORE_PATH")
fi

# Save to file
echo -n "$BASE64" > "$OUTPUT_FILE"

echo ""
echo "✅ Keystore encoded successfully!"
echo ""
echo "Output saved to: $OUTPUT_FILE"
echo "Base64 length: ${#BASE64} characters"

# Copy to clipboard
if command -v pbcopy &> /dev/null; then
    # macOS
    echo -n "$BASE64" | pbcopy
    echo ""
    echo "📋 Copied to clipboard!"
elif command -v xclip &> /dev/null; then
    # Linux with xclip
    echo -n "$BASE64" | xclip -selection clipboard
    echo ""
    echo "📋 Copied to clipboard!"
elif command -v xsel &> /dev/null; then
    # Linux with xsel
    echo -n "$BASE64" | xsel --clipboard
    echo ""
    echo "📋 Copied to clipboard!"
else
    echo ""
    echo "⚠️  Could not copy to clipboard. Copy from $OUTPUT_FILE manually."
fi

echo ""
echo "Next steps:"
echo "1. Go to GitHub → Repository → Settings → Secrets → Actions"
echo "2. Add new secret: KEYSTORE_BASE64"
echo "3. Paste the Base64 content from clipboard or $OUTPUT_FILE"
echo ""
echo "⚠️  SECURITY: Delete $OUTPUT_FILE after copying to GitHub Secrets!"
