import 'package:dart_feature_gen/src/cli/cli_feature_gen_config.dart';
import 'package:dart_feature_gen/src/feature_gen_config.dart';
import 'package:dart_feature_gen/src/io/feature_gen_io.dart';
import 'package:dart_feature_gen/src/yaml/yaml_feature_gen_config.dart';
import 'package:path/path.dart';

FeatureGenConfig mergeConfigs({
  required FeatureGenIO io,
  required CliFeatureGenConfig cli,
  required YamlFeatureGenConfig yaml,
}) {
  return FeatureGenConfig(
    featureName: cli.featureName,
    featurePrefix: cli.featurePrefix ?? yaml.featurePrefix,
    outputDirectory:
        _makeOutputDir(io, cli.outputDir ?? yaml.outputDir ?? 'lib/features'),
    stateManagement:
        _parseStateManagement(cli.stateManagement ?? yaml.stateManagement),
    runCodeFormatter: cli.runCodeFormatter ?? yaml.runCodeFormatter ?? true,
    runCodeGenerator: cli.runCodeGenerator ?? yaml.runCodeGenerator ?? true,
  );
}

String _makeOutputDir(FeatureGenIO io, String? parsed) {
  if (parsed != null) {
    return join(io.getCwd(), parsed);
  }

  return io.getCwd();
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
