import 'package:dart_feature_gen/src/cli/cli_feature_gen_config.dart';
import 'package:dart_feature_gen/src/config_parser.dart';
import 'package:dart_feature_gen/src/feature_gen_config.dart';
import 'package:dart_feature_gen/src/io/feature_gen_io.dart';
import 'package:dart_feature_gen/src/yaml/yaml_feature_gen_config.dart';
import 'package:file/memory.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:test/test.dart';

void main() {
  group('merges yaml into cli', () {
    late FeatureGenIO io;

    setUp(() {
      io = FeatureGenIO(
        fileSystem: MemoryFileSystem.test(),
        logger: Logger(level: Level.quiet),
      );
    });

    test('should apply default values to non-parsed configs', () {
      final config = mergeConfigs(
        io: io,
        cli: CliFeatureGenConfig(
          featureName: 'auth',
          featurePrefix: null,
          outputDir: null,
          stateManagement: null,
        ),
        yaml: YamlFeatureGenConfig(
          featurePrefix: null,
          outputDir: null,
          stateManagement: null,
        ),
      );

      expect(config.featureName, equals('auth'));
      expect(config.featurePrefix, isNull);
      expect(config.outputDirectory, endsWith('lib/features'));
      expect(config.stateManagement, equals(StateManagement.bloc));
    });

    test('should merge feature prefix from yaml into cli', () {
      final config = mergeConfigs(
        io: io,
        cli: CliFeatureGenConfig(
          featureName: 'auth',
          featurePrefix: null,
          outputDir: null,
          stateManagement: null,
        ),
        yaml: YamlFeatureGenConfig(
          featurePrefix: 'feat',
          outputDir: null,
          stateManagement: null,
        ),
      );

      expect(config.featureName, equals('auth'));
      expect(config.featurePrefix, equals('feat'));
      expect(config.outputDirectory, endsWith('lib/features'));
      expect(config.stateManagement, equals(StateManagement.bloc));
    });

    test('should merge output directory from yaml into cli', () {
      final config = mergeConfigs(
        io: io,
        cli: CliFeatureGenConfig(
          featureName: 'auth',
          featurePrefix: null,
          outputDir: null,
          stateManagement: null,
        ),
        yaml: YamlFeatureGenConfig(
          featurePrefix: null,
          outputDir: 'my_features',
          stateManagement: null,
        ),
      );

      expect(config.featureName, equals('auth'));
      expect(config.featurePrefix, isNull);
      expect(config.outputDirectory, endsWith('my_features'));
      expect(config.stateManagement, equals(StateManagement.bloc));
    });

    test('should merge state management from yaml into cli', () {
      final config = mergeConfigs(
        io: io,
        cli: CliFeatureGenConfig(
          featureName: 'auth',
          featurePrefix: null,
          outputDir: null,
          stateManagement: null,
        ),
        yaml: YamlFeatureGenConfig(
          featurePrefix: null,
          outputDir: null,
          stateManagement: 'cubit',
        ),
      );

      expect(config.featureName, equals('auth'));
      expect(config.featurePrefix, isNull);
      expect(config.outputDirectory, endsWith('lib/features'));
      expect(config.stateManagement, equals(StateManagement.cubit));
    });
  });

  group('prefers cli over yaml', () {
    late FeatureGenIO io;

    setUp(() {
      io = FeatureGenIO(
        fileSystem: MemoryFileSystem.test(),
        logger: Logger(level: Level.quiet),
      );
    });

    test('takes feature prefix from cli instead of yaml', () {
      final config = mergeConfigs(
        io: io,
        cli: CliFeatureGenConfig(
          featureName: 'auth',
          featurePrefix: 'cli_feat',
          outputDir: null,
          stateManagement: null,
        ),
        yaml: YamlFeatureGenConfig(
          featurePrefix: 'yaml_feat',
          outputDir: null,
          stateManagement: null,
        ),
      );

      expect(config.featureName, equals('auth'));
      expect(config.featurePrefix, equals('cli_feat'));
      expect(config.outputDirectory, endsWith('lib/features'));
      expect(config.stateManagement, equals(StateManagement.bloc));
    });

    test('takes output dir from cli instead of yaml', () {
      final config = mergeConfigs(
        io: io,
        cli: CliFeatureGenConfig(
          featureName: 'auth',
          featurePrefix: null,
          outputDir: 'cli_output',
          stateManagement: null,
        ),
        yaml: YamlFeatureGenConfig(
          featurePrefix: null,
          outputDir: 'yaml_output',
          stateManagement: null,
        ),
      );

      expect(config.featureName, equals('auth'));
      expect(config.featurePrefix, isNull);
      expect(config.outputDirectory, endsWith('cli_output'));
      expect(config.stateManagement, equals(StateManagement.bloc));
    });

    test('takes state management from cli instead of yaml', () {
      final config = mergeConfigs(
        io: io,
        cli: CliFeatureGenConfig(
          featureName: 'auth',
          featurePrefix: null,
          outputDir: null,
          stateManagement: 'cubit',
        ),
        yaml: YamlFeatureGenConfig(
          featurePrefix: null,
          outputDir: null,
          stateManagement: 'bloc',
        ),
      );

      expect(config.featureName, equals('auth'));
      expect(config.featurePrefix, isNull);
      expect(config.outputDirectory, endsWith('lib/features'));
      expect(config.stateManagement, equals(StateManagement.cubit));
    });
  });
}
