#!/bin/bash
# Script to easily generate launcher and splash logos for Poka CE

if [ -z "$1" ]; then
  echo "Usage: ./scripts/logo.sh <path_to_master_logo.png>"
  echo "Example: ./scripts/logo.sh ~/Downloads/new_logo.png"
  exit 1
fi

INPUT_FILE="$1"

if [ ! -f "$INPUT_FILE" ]; then
  echo "Error: File '$INPUT_FILE' not found!"
  exit 1
fi

if ! command -v convert &> /dev/null && ! command -v magick &> /dev/null; then
  echo "Error: ImageMagick is not installed."
  echo "Please install it first: brew install imagemagick"
  exit 1
fi

echo "🔄 Converting logo..."

# Determine the magick command
MAGICK_CMD="convert"
if command -v magick &> /dev/null; then
  MAGICK_CMD="magick"
fi

# Resize to 1024x1024 (maintain aspect ratio, center, add transparent padding)
$MAGICK_CMD "$INPUT_FILE" -resize 1024x1024 -background transparent -gravity center -extent 1024x1024 assets/images/launcher.png
$MAGICK_CMD "$INPUT_FILE" -resize 1024x1024 -background transparent -gravity center -extent 1024x1024 assets/images/splash.png

echo "✅ Generated assets/images/launcher.png (1024x1024)"
echo "✅ Generated assets/images/splash.png (1024x1024)"

echo "🚀 Running make assets to generate Android/iOS icons..."
make assets

echo "🎉 Done! New logos have been applied to the app."
