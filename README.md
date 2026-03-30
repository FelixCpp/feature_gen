# dart_feature_gen

[![pub package](https://img.shields.io/pub/v/dart_feature_gen.svg)](https://pub.dev/packages/dart_feature_gen)
[![codecov](https://codecov.io/gh/FelixCpp/dart_feature_gen/branch/main/graph/badge.svg)](https://codecov.io/gh/FelixCpp/dart_feature_gen)
[![CI](https://github.com/FelixCpp/dart_feature_gen/actions/workflows/ci.yaml/badge.svg)](https://github.com/FelixCpp/dart_feature_gen)

---

## Overview

`dart_feature_gen` is a powerful feature structure generator following best-practices from clean-architecture principals approaches. It is capable of generating code-blocks using different strategies defined by the user.

## Generation configuration

The primary usage of this package is provided via an CLI. This means, you can execute a `dart run ...` command which generates folder structures & file contents for you. Customization
can be archived by passing additional CLI-Arguments to the command or providing a seaparate dart_feature_gen.yaml file.
Configuration options may contain the output-directory relative to the pubspec.yaml file or data class types to use inside your feature.

An example usage of a command might look like this where the first line is the command written by you:

![command: dart run dart_feature_gen --feature-name=auth](./images/example_cli_command.png)

Available configuration options are:

| Name | Abbr. | Example | Default | Description |
| ---- | ----- | ------- | ------- | ----------- |
| output-dir | -o | lib/feats | lib/features | The output directory relative to your pubspec.yaml file |
| feature-prefix | -p | feat | - | A prefix to use before naming the folder of your feature. |
| state-management | - | cubit | bloc | The state management library to use. |
| data-class-format | - | native | freezed | The data class foramt library to use inside the presentation layer. |
| (no)-code-format | - | false | true | Whether to format the code using `dart format` after generating. |
| (no)-code-generate | - | true | true | Whether to generate the code using `build_runner` after generating. |

A concrete example might look like this:

```bash
dart run dart_feature_gen generate --feature-name=auth --feature-prefix=feat --data-class-format=native
```

As usual there is more help using the `--help` command providing information about usage, allowed values and more.

```bash
dart run dart_feature_gen generate --help
```

### State-Management options

Supported state-management options are:

| Library | Required Dependencies |
| ------- | --------------------- |
| bloc | `flutter_bloc` |
| cubit | `flutter_bloc` |
| riverpod | `riverpod_annotation`, `flutter_riverpod`, `riverpod_generator` |


### Data-Class-Format options

Supported data-class-format options are:

| Library | Required Dependencies |
| ------- | --------------------- |
| freezed | `freezed_annotation`, `freezed` |
| native | - |

### Configuration via yaml

Earlier i've teased the ability to configure your command using a configuration file. This file must be named 'dart_feature_gen.yaml'.
All command listed above except the feature-name can be configured here as well. Note that the CLI overwrites options defined inside the yaml as it has a higher priority.

An example file might contain the following:
```yaml
output-dir: lib/my_features
feature-prefix: feat
state-management: riverpod
data-class-format: freezed # No need since freezed is the default
code-format: false
code-generate: true
```

## Output folder structure
The output of a command with basic configuration might look like this:

[output-folder-structure image](./images/example_cli_output.png)


## Additional information

This library detects missing dependencies along the way and will fail when you try to generate code using freezed but haven't specified a dependency on it yet. This behavior will probably extend in the future to opt-in adding the dependency automatically.

## Package related

If you like this package feel free to give a star on [github](https://github.com/FelixCpp/dart_feature_gen) and leave a like on [pub.dev](https://pub.dev/packages/dart_feature_gen).
In case you miss any feature or notice a bug, you're welcome to submit a [pull-request](https://github.com/FelixCpp/dart_feature_gen/pulls) or open an [issue](https://github.com/FelixCpp/dart_feature_gen/issues).
