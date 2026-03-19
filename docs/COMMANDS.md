# Commands

## Daily development

```bash
flutter pub get
flutter analyze
flutter test
```

## Build APK

```bash
flutter build apk
```

## Regenerate code (when GraphQL/provider/model sources change)

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Optional cleanup and refresh

```bash
flutter clean
flutter pub get
```

## Suggested verification order for risky fixes

1. `flutter analyze`
2. Targeted tests if available
3. Full `flutter test`
4. `flutter build apk` for release-path validation
