# news_test

Flutter project for the news test task.

## What's Included

- App startup flow under `lib/app`
- Dependency container with basic services:
  - `SharedPreferences`
  - `FlutterSecureStorage`
  - `Dio`
- `go_router` setup with shell branching
- `fvm` pinned Flutter SDK via `.fvmrc`

## Project Structure

- `lib/app` — app runner, initialization, root widgets, dependencies
- `lib/core` — shared utilities
- `lib/shared` — router and theme
- `lib/features` — feature screens

## Commands

```bash
fvm flutter pub get
fvm flutter analyze
fvm flutter run
```
