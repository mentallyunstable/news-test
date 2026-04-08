# RULES.md

This file defines the working conventions for `news_test`.

## Purpose

- Treat this repository as a Flutter app with a clear, maintainable structure.
- Optimize for correctness, small safe changes, and project-specific decisions
  over generic Flutter advice.

## Project Structure

- Keep app startup, initialization, dependency wiring, and root widgets under
  `lib/app`.
- Keep reusable utilities under `lib/core`.
- Keep routing under `lib/shared/router`.
- Keep theme and shared presentation primitives under `lib/shared`.
- Keep feature-facing screens and UI modules under `lib/features`.

## Tooling

- Use `rg` and `rg --files` for search.
- Use non-interactive shell commands.
- Use `apply_patch` for manual code edits.
- All `dart` and `flutter` commands must use the `fvm` prefix in this project.
- Prefer running commands from the project root unless a narrower directory is
  clearly better.

## Flutter and Dart Standards

- Follow Effective Dart and standard Flutter conventions.
- Favor simple, readable, null-safe Dart.
- Prefer composition over inheritance.
- Use immutable widgets and immutable data where practical.
- Keep functions focused and avoid clever abstractions.
- Add comments only when intent is not obvious from the code.
- Use meaningful names and avoid unnecessary abbreviations.
- Use `const` constructors and widgets where practical.

## Architecture Guidance

- Preserve the current split between `app`, `core`, `shared`, and `features`.
- Keep initialization flowing through `lib/app/logic/app_runner.dart` and
  `lib/app/initialization/logic/initialization_processor.dart`.
- Keep dependency setup under `lib/app/dependencies`.
- Prefer the existing `flutter_bloc` and `go_router` choices instead of adding
  new state-management or navigation patterns.
- Avoid speculative boilerplate. Add new layers only when a concrete feature
  needs them.

## Verification

- Verify changes with the smallest relevant command first.
- Prefer:
  - `fvm flutter analyze`
  - `fvm flutter test`
- If verification cannot run, report exactly why.
