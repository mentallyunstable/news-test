# news_test

Flutter app for the news test task.

## Details

- project created and developed with Flutter `3.41.5` version (using `fvm`)
- implemented URL normalization to generate stable article ids
- implemented custom id as hash to identify every article (remote service don't have ids for articles)

## Run

```bash
fvm flutter pub get
fvm flutter run --dart-define-from-file=config.json
make apk_release
```

## Config

The app reads `ENV`, `BASE_URL`, and `API_KEY` from Dart defines.

Example `config.json`:

```json
{
  "ENV": "dev",
  "BASE_URL": "https://newsapi.org/",
  "API_KEY": "your_api_key"
}
```

## Packages

- `flutter_bloc` - state management
- `go_router` - app navigation
- `dio` - HTTP client
- `retrofit` - API client generation
- `cached_network_image` - network image caching

## Makefile

```bash
make builder
make analyze
make apk_release
```
