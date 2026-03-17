import 'package:dart_feature_gen/src/yaml/yaml_feature_gen_config.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:yaml/yaml.dart';

class YamlLoader {
  const YamlLoader({required this.logger});

  final Logger logger;

  Future<YamlFeatureGenConfig> run(String yamlSource) async {
    final progress = logger.progress(
      'Reading feature configuration from yaml source.',
    );

    Map<dynamic, dynamic> yaml;
    try {
      yaml = loadYaml(yamlSource) as Map;
    } catch (exception) {
      progress.complete(
        'Failed to read valid feature configuration. Using fallback',
      );
      yaml = {};
    }

    return YamlFeatureGenConfig(
      featurePrefix: yaml['feature-prefix'] as String?,
      outputDir: yaml['output-dir'] as String?,
      stateManagement: yaml['state-management'] as String?,
    );
  }
}
