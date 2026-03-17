# dart_feature_gen

A Dart CLI tool that generates clean, consistent feature structures for Flutter apps following clean architecture principles.

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

In larger Flutter projects, every feature tends to follow the same folder structure: a `data` layer, a `domain` layer, and a `presentation` layer. Creating this by hand is really repetitive.

`dart_feature_gen` automates this entirely. One command creates the full directory tree, populates every file with the correct boilerplate.

---

## Generated Structure

Running `dart_feature_gen generate auth` inside your Flutter project root produces:

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

Each file is pre-populated with the correct class name (derived from the feature name), imports, and interface stubs — ready for you to fill in the business logic.

---

## Installation

### Option A: Global activation (recommended)

```bash
dart pub global activate dart_feature_gen
```

### Option B: From source

```bash
git clone https://github.com/yourname/dart_feature_gen.git
cd dart_feature_gen
dart pub global activate --source path .
```

### Option C: Run without installing

```bash
dart run bin/dart_feature_gen.dart generate --feature-name=auth
```

---

## Usage

### Basic

```bash
# Generate a feature named "auth" under lib/features/
dart_feature_gen generate --feature-name=auth
```

### Custom output directory

```bash
# Generate under a different directory
dart_feature_gen generate --feature-name=auth --output-dir=lib/src/features
```

### Directory prefix

```bash
# Generate using a prefix. Output: lib/src/features/feat_auth/...
dart_feature_gen generate --feature-name=auth --feature-prefix=feat --output-dir=lib/src/features
```

### Skip build_runner

```bash
# Only generate files and run dart format — skip build_runner
dart_feature_gen generate --feature-name=auth --no-code-generate
```

### Multi-word feature names

Use `snake_case` — class names are automatically converted to `PascalCase`:

```bash
dart_feature_gen generate user_profile
# → UserProfileBloc, UserProfileRepository, etc.
```

---

## Configuration

Place a `dart_feature_gen.yaml` file in your Flutter project root to set defaults:

```yaml
# dart_feature_gen.yaml

# Base path for generated features (default: lib/features)
output-dir: lib/features

# Prefix that is being put in front of the requested feature name.
# Output might be "feat_auth" in case the feature has been named "auth"
# Note that the prefix is being put separated using a "_" character.
feature-prefix: feat

# Run dart format after generation (default: true)
code-format: true

# Run build_runner after generation, if available (default: true)
code-generate: true
```

CLI flags always take precedence over `dart_feature_gen.yaml` values.

---

## Options & Flags

| Option / Flag | Short | Mandatory | Default | Description |
|---|---|---|---|---|
| --help | -h | | | Show usage information |
| --feature-name | -n | yes | | Name of the feature |
| --feature-prefix | -p | no | | Directory prefix separated by '_' |
| --output-dir | -o | no | lib/features | Directory where the feature is being generated to |
| --state-management | | no | bloc | Which state management library to use for the presentation layer |
| --(no)-code-format | | no | true | Whether to run the code formatter (dart format) afterwards |
| --(no)-code-generate | | no | true | Whether to run the code generator (build_runner) afterwards |

---

## How It Works

1. **File generation** — Creates the full directory tree and writes boilerplate Dart files for the `data`, `domain`, and `presentation` layers.

2. **`dart format`** — Runs `dart format <feature_path>` scoped to the newly created feature directory.

3. **`build_runner`** — If `build_runner` is listed as a dependency in your project's `pubspec.yaml`, it runs:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

> **Note:** `build_runner is required to be listed as a (dev-)dependency inside your pubspec.yaml file.

---

## Development

### Prerequisites

- Dart SDK `>=3.0.0`

### Running locally

```bash
git clone https://github.com/yourname/dart_feature_gen.git
cd dart_feature_gen
dart pub get
dart run bin/dart_feature_gen.dart generate auth
```

### Running tests

```bash
dart test
```

### Dependencies

| Package | Purpose |
|---|---|
| [`args`](https://pub.dev/packages/args) | CLI argument and flag parsing |
| [`mason_logger`](https://pub.dev/packages/mason_logger) | Formatted terminal output with spinners and colours |
| [`yaml`](https://pub.dev/packages/yaml) | Parsing `dart_feature_gen.yaml` and `pubspec.yaml` |
| [`path`](https://pub.dev/packages/path) | Cross-platform path operations |
| [`recase`](https://pub.dev/packages/recase) | Map between several coding styles |

---

## Requirements

- **Dart SDK** `>=3.0.0`
- **Dart/Flutter project** with a `pubspec.yaml` in the working directory
- `build_runner` and `freezed` in your Flutter project's `dev_dependencies` (only required if you want the build step)
