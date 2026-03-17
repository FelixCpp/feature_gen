import 'dart:io';

import 'package:dart_feature_gen/src/cli/cli_feature_gen_config.dart';
import 'package:dart_feature_gen/src/feature_gen_config.dart';
import 'package:dart_feature_gen/src/yaml/yaml_feature_gen_config.dart';
import 'package:path/path.dart';

FeatureGenConfig mergeConfigs({
  required CliFeatureGenConfig cli,
  required YamlFeatureGenConfig yaml,
}) {
  return FeatureGenConfig(
    featureName: cli.featureName,
    featurePrefix: cli.featurePrefix ?? yaml.featurePrefix,
    outputDirectory:
        _makeOutputDir(cli.outputDir ?? yaml.outputDir ?? 'lib/features'),
    stateManagement:
        _parseStateManagement(cli.stateManagement ?? yaml.stateManagement),
  );
}

String _makeOutputDir(String? parsed) {
  if (parsed != null) {
    return join(Directory.current.path, parsed);
  }

  return Directory.current.path;
}

StateManagement _parseStateManagement(String? value) {
  if (value == null) {
    return StateManagement.bloc;
  }

  if (value == 'bloc') return StateManagement.bloc;
  if (value == 'cubit') return StateManagement.cubit;

  throw ArgumentError.value(value);
}
