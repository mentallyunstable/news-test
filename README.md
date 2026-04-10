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

## Maestro E2E

The initial Maestro coverage lives in:

- `e2e/flows/news_browse_search_android.yaml`
- `e2e/flows/news_browse_search_ios.yaml`
- `e2e/flows/favorites_add_article_android.yaml`
- `e2e/flows/favorites_add_article_ios.yaml`

Start the app with the normal live API configuration:

```bash
fvm flutter run --dart-define-from-file=config.json
```

Run the Maestro smoke flow against Android:

```bash
maestro test e2e/flows/news_browse_search_android.yaml
```

Run the same flow against iOS:

```bash
maestro test e2e/flows/news_browse_search_ios.yaml
```

Run the favorites add/remove smoke flow against Android:

```bash
maestro test e2e/flows/favorites_add_article_android.yaml
```

Run the favorites add/remove smoke flow against iOS:

```bash
maestro test e2e/flows/favorites_add_article_ios.yaml
```

This flow uses live News API data, so it behaves like a smoke test rather than a fully deterministic fixture-based test.
