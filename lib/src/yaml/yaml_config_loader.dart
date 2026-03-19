import 'package:dart_feature_gen/src/io/feature_gen_io.dart';
import 'package:dart_feature_gen/src/yaml/yaml_feature_gen_config.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:yaml/yaml.dart';

class YamlConfigLoader {
  const YamlConfigLoader({
    required this.io,
    required this.logger,
  });

  final FeatureGenIO io;
  final Logger logger;

  Future<YamlFeatureGenConfig> loadConfigFromSource(String source) async {
    var yaml = {};
    try {
      yaml = loadYaml(source) as Map? ?? {};
    } catch (exception) {
      logger.err('Failed to decode configuration file (yaml): $exception');
    }

    return YamlFeatureGenConfig(
      featurePrefix: yaml['feature-prefix'] as String?,
      outputDir: yaml['output-dir'] as String?,
      stateManagement: yaml['state-management'] as String?,
      runCodeFormatter: yaml['code-format'] as bool?,
      runCodeGenerator: yaml['code-generate'] as bool?,
    );
  }
}
