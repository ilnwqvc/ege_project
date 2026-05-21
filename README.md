# EGE Russian App

EGE Russian App is a Flutter application for preparing for the Russian Unified State Exam. It combines theory, practice tasks, progress tracking, and account sync in one compact study tool.

## Features

- Theory sections for the main EGE Russian language task types.
- Offline practice bank split into task packages.
- Text-input tasks in EGE-style answer format.
- Local progress storage with Drift and SQLite.
- Optional authorization API for syncing user progress.
- Web-ready Flutter build with deployment files included.

## Tech Stack

- Flutter and Dart
- Provider for state management
- GoRouter for navigation
- Drift and SQLite for local storage
- HTTP client for API calls
- Python backend for authorization and progress sync

## Project Structure

- `lib/` - Flutter application source code.
- `assets/content/` - production study content used by the app.
- `server/` - backend API for auth and progress sync.
- `deploy/` - deployment scripts and service configuration.
- `web/` - Flutter web assets.
- `test/` - automated content and app checks.

## Getting Started

Install Flutter, clone the repository, then run:

```bash
flutter pub get
flutter run
```

For web:

```bash
flutter run -d chrome
```

## Quality Checks

```bash
flutter analyze
flutter test
```

## Content

The repository contains the production content required by the app at build time. Large source documents, intermediate imports, generated logs, and local build artifacts are intentionally excluded from Git.

## Deployment

Deployment files are stored in `deploy/`. They include nginx, systemd, and helper scripts for publishing the Flutter web build and running the API service.
