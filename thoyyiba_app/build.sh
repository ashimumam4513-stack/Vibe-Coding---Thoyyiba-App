#!/bin/bash
echo "Setting up CI environment..."
export CI=true
export FLUTTER_ROOT="$PWD/flutter"
export PATH="$PATH:$FLUTTER_ROOT/bin"

echo "Downloading Flutter..."
git clone https://github.com/flutter/flutter.git -b stable --depth 1

echo "Disabling analytics and suppressing prompts..."
flutter config --no-analytics

echo "Flutter version:"
flutter --version

echo "Building web app..."
flutter clean
flutter pub get
flutter build web
