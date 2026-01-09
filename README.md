# محول الليرة السورية (Syrian Pounds Converter)

A professional Flutter application for converting Syrian Lira amounts between old and new currency, calculating dollar exchange rates, and breaking down amounts into denominations.

## Features

- Convert old Syrian Pounds to new currency
- Convert new Syrian Pounds to old currency  
- Configurable dollar to new Syrian Pounds exchange rate
- Break down new Lira into specific denominations
- Dark Metal UI with Material 3 design
- RTL (Right-to-Left) support for Arabic
- Clean Architecture with flutter_bloc state management

## Getting Started

### Prerequisites

- Flutter SDK 3.6.1 or higher
- Android Studio / Xcode
- JDK 8 or higher (for Android builds)

### Installation

1. Clone the repository
2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Building for Production

### Android Release Build

#### Prerequisites
- Keystore file configured in `android/gradle.properties`
- Release signing configured in `android/app/build.gradle`

#### Build App Bundle (for Google Play)
```bash
# Clean previous builds
flutter clean

# Get dependencies
flutter pub get

# Build release App Bundle
flutter build appbundle --release
```

The output file will be located at:
`build/app/outputs/bundle/release/app-release.aab`

#### Build APK (for direct installation)
```bash
flutter build apk --release
```

The output file will be located at:
`build/app/outputs/flutter-apk/app-release.apk`

### Testing Release Build

Install the release APK on a physical device:
```bash
adb install build/app/outputs/flutter-apk/app-release.apk
```

## Project Structure

```
lib/
├── core/                 # Core utilities and base classes
├── features/            # Feature modules (Clean Architecture)
│   └── currency/        # Currency conversion feature
│       ├── data/        # Data layer (datasources, repositories)
│       ├── domain/      # Domain layer (entities, use cases)
│       └── presentation/ # Presentation layer (pages, widgets, bloc)
└── main.dart           # Application entry point
```

## Configuration

### Signing Configuration
Signing credentials are stored in `android/gradle.properties`:
- `MY_KEYSTORE_PASSWORD`: Keystore password
- `MY_KEY_ALIAS`: Key alias
- `MY_KEY_PASSWORD`: Key password
- `storeFile`: Path to keystore file

**⚠️ Important:** Never commit `gradle.properties` or `*.jks` files to version control.

## Google Play Submission Checklist

- [x] Target SDK 34 (Android 14)
- [x] App signed with release keystore
- [x] App Bundle (.aab) generated
- [x] ProGuard/R8 code shrinking enabled
- [ ] Screenshots prepared (minimum 2 per device type)
- [ ] Store listing description written
- [ ] Privacy policy URL (if applicable)
- [ ] Content rating completed in Play Console

## License

This project is licensed for personal/commercial use.

## Support

For issues and feature requests, please contact the development team.
