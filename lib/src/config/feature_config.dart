import 'package:file/file.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';

part 'feature_config.freezed.dart';

enum StateManagementLibrary {
  bloc,
  cubit;

  static StateManagementLibrary? parse(String value) {
    final lowercased = value.toLowerCase();

    if (lowercased == 'bloc') return StateManagementLibrary.bloc;
    if (lowercased == 'cubit') return StateManagementLibrary.cubit;
    return null;
  }
}

@freezed
sealed class FeatureGenConfig with _$FeatureGenConfig {
  const factory FeatureGenConfig({
    required String featureName,
    required String outputDirectory,
    required String? featurePrefix,
    required bool format,
    required bool build,
    required StateManagementLibrary smLibrary,
  }) = _FeatureGenConfig;

  factory FeatureGenConfig.fallback(String featureName) {
    return FeatureGenConfig(
      featureName: featureName,
      outputDirectory: 'lib/features',
      featurePrefix: null,
      format: true,
      build: true,
      smLibrary: StateManagementLibrary.bloc,
    );
  }
}

extension FeatureDirName on FeatureGenConfig {
  String get featureDirName {
    final buffer = StringBuffer();

    if (featurePrefix case String prefix) {
      buffer.write('${prefix}_');
    }

    buffer.write(featureName);
    return buffer.toString();
  }
}

class ConfigLoader {
  static const _configFileName = 'dart_feature_gen.yaml';

  const ConfigLoader({
    required this.logger,
    required this.fileSystem,
  });

  final Logger logger;
  final FileSystem fileSystem;

  Future<FeatureGenConfig> load({
    required String workingDirectory,
    required String featureName,
  }) async {
    final yamlPath = path.join(workingDirectory, _configFileName);
    final configFile = fileSystem.file(yamlPath);

    if (!await configFile.exists()) {
      logger.info(
        '"$_configFileName" could not be found inside working directory. Falling back to default configuration.',
      );

      return FeatureGenConfig.fallback(featureName);
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
      var config = FeatureGenConfig.fallback(featureName);
      if (yaml['output-dir'] case String outputDir) {
        config = config.copyWith(outputDirectory: outputDir);
      }

      if (yaml['feature-prefix'] case String featurePrefix) {
        config = config.copyWith(featurePrefix: featurePrefix);
      }

      if (yaml['build'] case bool build) {
        config = config.copyWith(build: build);
      }

      if (yaml['format'] case bool format) {
        config = config.copyWith(format: format);
      }

      if (yaml['state-management-library'] case String smLibrary) {
        final lib = StateManagementLibrary.parse(smLibrary);
        if (lib != null) {
          config = config.copyWith(smLibrary: lib);
        } else {
          logger.warn('Invalid state management library detected.');
        }
      }

      return config;
    } catch (exception) {
      progress.fail('Error occurred: $exception');
      logger.info('Falling back to default config.');
      return FeatureGenConfig.fallback(featureName);
    }
  }
}
