# BigShop

BigShop is a Flutter e‑commerce demo showcasing authentication, product browsing, and a cart flow integrated with Firebase. It supports English and Arabic localization and runs on Android, iOS, Web, Windows, macOS, and Linux.

---

## Features
* __Authentication__: Firebase Authentication for user sessions
* __Products__: Browse a list of products
* __Cart__: Add to cart and view cart
* __Saved Cards__: Store payment card info in Cloud Firestore and select a card during checkout
* __Localization__: `en-US` and `ar-EG` via Easy Localization
* __Responsive__: Works across mobile and desktop targets

## Tech Stack
* __Flutter__ (Dart)
* __Firebase__: Auth, Cloud Firestore, Core
* __easy_localization__ for i18n
* __flutter_svg__ for vector assets

## Project Structure
```
lib/
  core/
    shared_data/
    routes/
  dependency injection/
  features/
    auth/
    products/
    cart/
      data/model/cartModel.dart
      presentation/pages/
        addcart.dart
        allcarts.dart
  firebase_options.dart
assets/
  translations/
    en-US.json
    ar-EG.json
  credit-card/
```

## Getting Started

### Prerequisites
* Flutter SDK installed and configured
* A Firebase project with platforms you plan to run (Android/iOS/Web/etc.)

### 1) Clone and install dependencies
```
flutter pub get
```

### 2) Firebase configuration
This project expects a standard Flutter + Firebase setup using `flutterfire`.

Steps (high-level):
1. Install FlutterFire CLI (one-time):
   ```bash
   dart pub global activate flutterfire_cli
   ```
2. Configure Firebase for your project:
   ```bash
   flutterfire configure
   ```
   This will generate/refresh `lib/firebase_options.dart` (already present) and platform configs (e.g., `android/app/google-services.json`).
3. Ensure plugins are added in native platforms (Gradle for Android, CocoaPods for iOS). The project already includes standard setup files.

### 3) Run the app
```
flutter run
```
Use `-d` to target a specific device (e.g., `-d chrome` for Web).

## Localization
Localization files live under `assets/translations/` with `en-US.json` and `ar-EG.json`.

To add/modify strings:
1. Update both JSON files with matching keys
2. Rebuild/run the app

Runtime locale switching is managed by Easy Localization.

## Saved Cards (Firestore)
* Cards are saved under: `users/{uid}/cart`
* Model: `Cartmodel` with `cartNumbers`, `cartExpiration`, `cartCVV`
* Example flows:
  - Add card: `features/cart/presentation/pages/addcart.dart`
  - List cards: `features/cart/presentation/pages/allcarts.dart`

## App Name: BigShop
If you need the platform display name to show "BigShop":
* __Android__: edit `android/app/src/main/AndroidManifest.xml`, change the `android:label` in the `<application>` tag to `BigShop`.
* __iOS__: in Xcode, set the target’s Display Name (Runner) to `BigShop` or edit `ios/Runner/Info.plist` (`CFBundleDisplayName`).
* __Web__: update `<title>` in `web/index.html`.
* __Desktop__: update respective runner resources/titles if needed.

Optionally, you can also change the Dart package name in `pubspec.yaml` (affects pub name, not platform display name).

## Build
* Android: `flutter build apk` or `flutter build appbundle`
* iOS: `flutter build ios`
* Web: `flutter build web`

## Notes
* Ensure you are signed in to Firebase in the running app before accessing user-specific data (like saved cards).
* Replace any placeholder Firebase configs with your project’s credentials.

---

Made with Flutter • BigShop
