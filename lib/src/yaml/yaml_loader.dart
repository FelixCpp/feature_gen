import 'package:dart_feature_gen/src/yaml/yaml_feature_gen_config.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:yaml/yaml.dart';

class YamlLoader {
  const YamlLoader({required this.logger});

  final Logger logger;

  Future<YamlFeatureGenConfig> run(String yamlSource) async {
    Map<dynamic, dynamic> yaml;
    try {
      yaml = loadYaml(yamlSource) as Map;
      logger.success('Yaml file has been read successfully.');
    } catch (exception) {
      logger.success(
        'Failed to read valid feature configuration. Using fallback',
      );
      yaml = {};
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
