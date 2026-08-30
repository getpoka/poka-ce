#!/bin/bash

# Generates a fresh Android Keystore and encodes it to Base64 for GitHub Actions.
# Only run this ONCE. Keep the generated passwords safe!

echo "==========================================="
echo " Poka CE - Keystore Generator for GitHub"
echo "==========================================="

KEYSTORE_FILE="upload-keystore.jks"
KEY_ALIAS="poka-ce"
read -p "Enter a secure password for the keystore (min 6 chars): " KEY_PASSWORD

if [ ${#KEY_PASSWORD} -lt 6 ]; then
  echo "Error: Password must be at least 6 characters long."
  exit 1
fi

echo "Generating keystore..."
rm -f $KEYSTORE_FILE
keytool -genkey -v -keystore $KEYSTORE_FILE -keyalg RSA -keysize 2048 -validity 10000 -alias $KEY_ALIAS -storepass "$KEY_PASSWORD" -keypass "$KEY_PASSWORD" -dname "CN=Poka CE, OU=App, O=Octopy ID, L=Banjarbaru, S=Kalimantan Selatan, C=ID"

if [ $? -eq 0 ]; then
  echo "✅ Keystore generated successfully: $KEYSTORE_FILE"
  
  echo "Encoding to Base64..."
  # Linux uses -w 0 to disable wrapping, macOS uses -b 0, we can just use base64 and strip newlines
  BASE64_STRING=$(base64 < $KEYSTORE_FILE | tr -d '\n')
  
  echo ""
  echo "==========================================="
  echo " ACTION REQUIRED: Add to GitHub Secrets"
  echo "==========================================="
  echo "Go to your GitHub Repository -> Settings -> Secrets and variables -> Actions"
  echo "Add the following Repository Secrets:"
  echo ""
  echo "1. ANDROID_KEYSTORE_BASE64"
  echo "Value: $BASE64_STRING"
  echo ""
  echo "2. ANDROID_KEY_ALIAS"
  echo "Value: $KEY_ALIAS"
  echo ""
  echo "3. ANDROID_KEY_PASSWORD"
  echo "Value: $KEY_PASSWORD"
  echo ""
  echo "4. ANDROID_STORE_PASSWORD"
  echo "Value: $KEY_PASSWORD"
  echo "==========================================="
  echo ""
  echo "⚠️ IMPORTANT: Do NOT commit $KEYSTORE_FILE to Git!"
  echo "Make sure to back up $KEYSTORE_FILE somewhere safe."
else
  echo "❌ Failed to generate keystore."
fi
