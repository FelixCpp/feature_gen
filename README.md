# dart_feature_gen

[![pub package](https://img.shields.io/pub/v/dart_feature_gen.svg)](https://pub.dev/packages/dart_feature_gen)
[![codecov](https://codecov.io/gh/FelixCpp/dart_feature_gen/branch/main/graph/badge.svg)](https://codecov.io/gh/FelixCpp/dart_feature_gen)
[![CI](https://github.com/FelixCpp/dart_feature_gen/actions/workflows/ci.yaml/badge.svg)](https://github.com/FelixCpp/dart_feature_gen)

---

## Overview

`dart_feature_gen` is a powerful CLI tool for Flutter projects, automating the creation of feature folders and boilerplate code following clean architecture. Save time, reduce errors, and keep your codebase consistent.

---

## Features

- Generates complete feature structure (`data`, `domain`, `presentation`) in seconds
- Supports multiple state management libraries: Bloc, Cubit, Riverpod
- Customizable output directory and feature prefix
- Pre-populated Dart files with correct class names and imports
- Runs `dart format` and optionally `build_runner` for code generation
- Easily configurable via CLI flags or `dart_feature_gen.yaml`

---

## Getting Started

### Installation

#### From pub.dev (recommended)

```bash
dart pub global activate dart_feature_gen
```

#### From source

```bash
git clone https://github.com/yourname/dart_feature_gen.git
cd dart_feature_gen
dart pub global activate --source path .
```

#### Run without installing

```bash
dart run bin/dart_feature_gen.dart generate --feature-name=auth
```

---

## Usage

### Basic Example

```bash
dart_feature_gen generate --feature-name=auth
```

### Custom Output Directory

```bash
dart_feature_gen generate --feature-name=auth --output-dir=lib/src/features
```

### Feature Prefix

```bash
dart_feature_gen generate --feature-name=auth --feature-prefix=feat --output-dir=lib/src/features
```

### Skip Code Generation

```bash
dart_feature_gen generate --feature-name=auth --no-code-generate
```

### Multi-word Feature Names

Use `snake_case` for feature names. Class names are automatically converted to `PascalCase`.

```bash
dart_feature_gen generate user_profile
# → UserProfileBloc, UserProfileRepository, etc.
```

---

## Configuration

Create a `dart_feature_gen.yaml` in your project root to set defaults:

```yaml
output-dir: lib/features
feature-prefix: feat
state-management: bloc
code-format: true
code-generate: true
```

CLI flags always override YAML config.

---

## Generated Structure

Example for `auth` feature:

```
lib/features/auth/
├── data/
│   ├── daos/
│   │   └── auth_dao.dart
│   ├── datasources/
│   │   └── auth_remote_datasource.dart
│   ├── di/
│   │   └── auth_data_module.dart
│   └── repositories/
│       └── auth_repository_impl.dart
├── domain/
│   ├── models/
│   ├── repositories/
│   │   └── auth_repository.dart
│   └── usecases/
└── presentation/
    ├── bloc/
    │   ├── auth_bloc.dart
    │   ├── auth_event.dart
    │   └── auth_state.dart
    └── auth_screen.dart
```

---

## Options & Flags

| Option / Flag        | Short | Required | Default      | Description                                        |
| -------------------- | ----- | -------- | ------------ | -------------------------------------------------- |
| --help               | -h    |          |              | Show usage information                             |
| --feature-name       | -n    | yes      |              | Name of the feature                                |
| --feature-prefix     | -p    | no       |              | Directory prefix separated by '\_'                 |
| --output-dir         | -o    | no       | lib/features | Directory for generated feature                    |
| --state-management   |       | no       | bloc         | State management library for presentation layer    |
| --(no)-code-format   |       | no       | true         | Run code formatter after generation                |
| --(no)-code-generate |       | no       | true         | Run code generator (build_runner) after generation |

---

## How It Works

1. **File Generation**: Creates directory tree and boilerplate Dart files for `data`, `domain`, and `presentation` layers.
2. **Formatting**: Runs `dart format` on the generated feature directory.
3. **Code Generation**: If `build_runner` is a dependency, runs `dart run build_runner build --delete-conflicting-outputs`.

> **Note:** `build_runner` must be listed as a (dev-)dependency in your `pubspec.yaml`.

---

## Development

### Prerequisites

- Dart SDK `>=3.0.0`

### Running Locally

```bash
git clone https://github.com/yourname/dart_feature_gen.git
cd dart_feature_gen
dart pub get
dart run bin/dart_feature_gen.dart generate auth
```

### Running Tests

```bash
dart test
```

### Dependencies

| Package                                                 | Purpose                                             |
| ------------------------------------------------------- | --------------------------------------------------- |
| [`args`](https://pub.dev/packages/args)                 | CLI argument and flag parsing                       |
| [`mason_logger`](https://pub.dev/packages/mason_logger) | Formatted terminal output with spinners and colours |
| [`yaml`](https://pub.dev/packages/yaml)                 | YAML parsing for config files                       |
| [`path`](https://pub.dev/packages/path)                 | Cross-platform path operations                      |
| [`recase`](https://pub.dev/packages/recase)             | Case conversion utilities                           |

---

## Requirements

- Dart SDK `>=3.0.0`
- Dart/Flutter project with a `pubspec.yaml`
- `build_runner` and `freezed` in `dev_dependencies` (for code generation)
- `flutter_bloc` for Bloc/Cubit state management
- `flutter_riverpod`, `riverpod_annotation`, `riverpod_generator` for Riverpod state management

---

## License

MIT

---

## Contributing

Pull requests and issues are welcome! Please read the [contributing guidelines](CONTRIBUTING.md).
