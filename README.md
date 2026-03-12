# feature_gen 🚀

A Dart CLI tool that generates clean, consistent feature structures for Flutter apps following clean architecture principles — including automatic `dart format` and optional `build_runner` execution.

---

## Table of Contents

- [Overview](#overview)
- [Generated Structure](#generated-structure)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [Options & Flags](#options--flags)
- [How It Works](#how-it-works)
- [Development](#development)
- [Requirements](#requirements)

---

## Overview

In larger Flutter projects, every feature tends to follow the same folder structure: a `data` layer, a `domain` layer, and a `presentation` layer. Creating this by hand is repetitive and error-prone.

`feature_gen` automates this entirely. One command creates the full directory tree, populates every file with the correct boilerplate, formats the output with `dart format`, and optionally triggers `build_runner` to generate Freezed classes and other code-gen output — scoped only to the new feature to keep build times short.

---

## Generated Structure

Running `feature_gen generate auth` inside your Flutter project root produces:

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
│   │   └── auth_model.dart
│   ├── repositories/
│   │   └── auth_repository.dart
│   └── usecases/
│       └── auth_usecase.dart
└── presentation/
    └── bloc/
        ├── auth_bloc.dart
        ├── auth_event.dart
        └── auth_state.dart
```

Each file is pre-populated with the correct class name (derived from the feature name), imports, and interface stubs — ready for you to fill in the business logic.

---

## Installation

### Option A: Global activation (recommended)

```bash
dart pub global activate feature_gen
```

Make sure your Dart pub cache is on your PATH. Add the following to your shell config (`.zshrc`, `.bashrc`, etc.) if it isn't already:

```bash
export PATH="$PATH:$HOME/.pub-cache/bin"
```

### Option B: From source

```bash
git clone https://github.com/yourname/feature_gen.git
cd feature_gen
dart pub global activate --source path .
```

### Option C: Run without installing

```bash
dart run bin/feature_gen.dart generate auth
```

---

## Usage

### Basic

```bash
# Generate a feature named "auth" under lib/features/
feature_gen generate auth
```

### Custom base path

```bash
# Generate under a different directory
feature_gen generate auth --path lib/src/features
```

### Skip build_runner

```bash
# Only generate files and run dart format — skip build_runner
feature_gen generate auth --no-build
```

### Multi-word feature names

Use `snake_case` — class names are automatically converted to `PascalCase`:

```bash
feature_gen generate user_profile
# → UserProfileBloc, UserProfileRepository, etc.
```

---

## Configuration

Place a `feature_gen.yaml` file in your Flutter project root to set defaults:

```yaml
# feature_gen.yaml

# Base path for generated features (default: lib/features)
base_path: lib/features

# Run dart format after generation (default: true)
format: true

# Run build_runner after generation, if available (default: true)
build_runner: true
```

CLI flags always take precedence over `feature_gen.yaml` values.

---

## Options & Flags

| Option / Flag | Short | Default | Description |
|---|---|---|---|
| `--path` | `-p` | `lib/features` | Base directory for the generated feature |
| `--build` / `--no-build` | | `true` | Run `build_runner` after generation |
| `--help` | `-h` | | Show usage information |

---

## How It Works

1. **File generation** — Creates the full directory tree and writes boilerplate Dart files for the `data`, `domain`, and `presentation` layers.

2. **`dart format`** — Runs `dart format <feature_path>` scoped to the newly created feature directory.

3. **`build_runner`** — If `build_runner` is listed as a dependency in your project's `pubspec.yaml`, it runs:
   ```bash
   dart run build_runner build \
     --build-filter="<package_name>|lib/features/<feature_name>/**" \
     --delete-conflicting-outputs
   ```
   The `--build-filter` flag scopes the build to only the new feature, so existing generated files are not touched and build times stay fast.

> **Note:** `build_runner` is detected automatically from your project's `pubspec.yaml`. If it is not present, the step is skipped without error.

---

## Development

### Prerequisites

- Dart SDK `>=3.0.0`

### Running locally

```bash
git clone https://github.com/yourname/feature_gen.git
cd feature_gen
dart pub get
dart run bin/feature_gen.dart generate auth
```

### Running tests

```bash
dart test
```

### Project structure

```
feature_gen/
├── bin/
│   └── feature_gen.dart          # CLI entrypoint
├── lib/
│   └── src/
│       ├── commands/
│       │   └── generate_command.dart
│       ├── generators/
│       │   ├── feature_generator.dart
│       │   ├── data_generator.dart
│       │   ├── domain_generator.dart
│       │   └── presentation_generator.dart
│       ├── templates/
│       │   ├── data_templates.dart
│       │   ├── domain_templates.dart
│       │   └── presentation_templates.dart
│       ├── utils/
│       │   └── process_runner.dart
│       └── config/
│           └── config_loader.dart
└── test/
```

### Dependencies

| Package | Purpose |
|---|---|
| [`args`](https://pub.dev/packages/args) | CLI argument and flag parsing |
| [`mason_logger`](https://pub.dev/packages/mason_logger) | Formatted terminal output with spinners and colours |
| [`yaml`](https://pub.dev/packages/yaml) | Parsing `feature_gen.yaml` and `pubspec.yaml` |
| [`path`](https://pub.dev/packages/path) | Cross-platform path operations |

---

## Requirements

- **Dart SDK** `>=3.0.0`
- **Flutter project** with a `pubspec.yaml` in the working directory
- `build_runner` and `freezed` in your Flutter project's `dev_dependencies` (only required if you want the build step)
