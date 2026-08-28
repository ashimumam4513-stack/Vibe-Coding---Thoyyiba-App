#!/bin/bash
# Install Flutter
echo "Downloading Flutter..."
git clone https://github.com/flutter/flutter.git -b stable --depth 1

# Add flutter to path
export PATH="$PATH:$PWD/flutter/bin"

echo "Flutter version:"
flutter --version

echo "Building web app..."
flutter clean
flutter pub get
flutter build web
