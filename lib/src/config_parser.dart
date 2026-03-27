import 'package:dart_feature_gen/src/cli/cli_feature_gen_config.dart';
import 'package:dart_feature_gen/src/feature_gen_config.dart';
import 'package:dart_feature_gen/src/yaml/yaml_feature_gen_config.dart';
import 'package:path/path.dart';

FeatureGenConfig mergeConfigs({
  required CliFeatureGenConfig cli,
  required YamlFeatureGenConfig yaml,
  required String rootDirectoryPath,
}) {
  return FeatureGenConfig(
    featureName: cli.featureName,
    featurePrefix: cli.featurePrefix ?? yaml.featurePrefix,
    outputDirectory: _makeOutputDir(
      rootDirectoryPath,
      cli.outputDir ?? yaml.outputDir ?? 'lib/features',
    ),
    stateManagement:
        _parseStateManagement(cli.stateManagement ?? yaml.stateManagement),
    dataClassFormat:
        _parseDataClassFormat(cli.dataClassFormat ?? yaml.dataClassFormat),
    runCodeFormatter: cli.runCodeFormatter ?? yaml.runCodeFormatter ?? true,
    runCodeGenerator: cli.runCodeGenerator ?? yaml.runCodeGenerator ?? true,
  );
}

String _makeOutputDir(String rootDirectoryPath, String? parsed) {
  if (parsed != null) {
    return join(rootDirectoryPath, parsed);
  }

  return rootDirectoryPath;
}

StateManagement _parseStateManagement(String? value) {
  if (value == null) {
    return StateManagement.bloc;
  }

  if (value == 'bloc') return StateManagement.bloc;
  if (value == 'cubit') return StateManagement.cubit;
  if (value == 'riverpod') return StateManagement.riverpod;

  throw ArgumentError.value(value);
}

DataClassFormat _parseDataClassFormat(String? value) {
  if (value == null) {
    return DataClassFormat.freezed;
  }

  if (value == 'freezed') return DataClassFormat.freezed;
  if (value == 'native') return DataClassFormat.native;

  throw ArgumentError.value(value);
}
