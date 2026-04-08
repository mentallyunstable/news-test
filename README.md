# news_test

Flutter app for the news test task.

## Run

```bash
fvm flutter pub get
fvm flutter analyze
fvm flutter run --dart-define-from-file=config.json
```

## Config

The app reads `ENV`, `BASE_URL`, and `API_KEY` from Dart defines. You can keep
them in `config.json` and pass the file with `--dart-define-from-file`.

Example `config.json`:
Provide these Dart defines:
```json
{
  "ENV": "dev",
  "BASE_URL": "https://newsapi.org/",
  "API_KEY": "your_api_key"
}
```
