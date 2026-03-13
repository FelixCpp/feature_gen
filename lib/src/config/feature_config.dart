import 'package:file/file.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';

part 'feature_config.freezed.dart';

@freezed
sealed class FeatureGenConfig with _$FeatureGenConfig {
  const factory FeatureGenConfig({
    required String outputDirectory,
    required bool format,
    required bool buildRunner,
  }) = _FeatureGenConfig;

  factory FeatureGenConfig.fallback() {
    return FeatureGenConfig(
      outputDirectory: 'lib/features',
      format: true,
      buildRunner: true,
    );
  }
}

extension MergeFeatureGenConfigs on FeatureGenConfig {
  FeatureGenConfig merge({
    String? outputDirectory,
    bool? format,
    bool? buildRunner,
  }) {
    return FeatureGenConfig(
      outputDirectory: outputDirectory ?? this.outputDirectory,
      format: format ?? this.format,
      buildRunner: buildRunner ?? this.buildRunner,
    );
  }
}

class ConfigLoader {
  static const _configFileName = 'feature_gen.yaml';

  const ConfigLoader({
    required this.logger,
    required this.fileSystem,
  });

  final Logger logger;
  final FileSystem fileSystem;

  Future<FeatureGenConfig> load({required String workingDirectory}) async {
    final yamlPath = path.join(workingDirectory, _configFileName);
    final configFile = fileSystem.file(yamlPath);

    if (!await configFile.exists()) {
      logger.info(
        '"$_configFileName" could not be found inside working directory. Falling back to default configuration.',
      );

      return FeatureGenConfig.fallback();
    }

    final progress = logger.progress('Loading "$_configFileName" file ...');
    try {
      final contents = await configFile.readAsString();
      final yaml = loadYaml(contents) as YamlMap?;

      if (yaml == null) {
        throw FormatException(
          '"$_configFileName" does not contain expected format',
        );
      }

      progress.complete('"$_configFileName" has been loaded successfully.');
      return FeatureGenConfig.fallback().merge(
        outputDirectory: yaml['output_dir'] as String?,
        format: yaml['format'] as bool?,
        buildRunner: yaml['build_runner'] as bool?,
      );
    } catch (exception) {
      progress.fail('Error occurred: $exception');
      logger.info('Falling back to default config.');
      return FeatureGenConfig.fallback();
    }
  }
}
