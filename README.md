# vidusskola

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### Running
Chromium
```sh
flutter run lib/main.dart --web-renderer=html
```

### Application launcher icon
#### Install 
```sh
flutter packages add flutter_launcher_icons
```
#### Generate
```sh
flutter pub run flutter_launcher_icons -f flutter_launcher_icons.yaml
```

### Build and install
```sh
flutter build apk
adb install ./build/app/outputs/flutter-apk/app-release.apk
```
