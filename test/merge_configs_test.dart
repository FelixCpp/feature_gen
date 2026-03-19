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
        cli: CliFeatureGenConfig(
          featureName: 'auth',
          featurePrefix: null,
          outputDir: null,
          stateManagement: null,
          runCodeFormatter: null,
          runCodeGenerator: null,
        ),
        yaml: YamlFeatureGenConfig(
          featurePrefix: null,
          outputDir: null,
          stateManagement: null,
          runCodeFormatter: null,
          runCodeGenerator: null,
        ),
        rootDirectoryPath: io.getCwd(),
      );

      expect(config.featureName, equals('auth'));
      expect(config.featurePrefix, isNull);
      expect(config.outputDirectory, endsWith('lib/features'));
      expect(config.stateManagement, equals(StateManagement.bloc));
      expect(config.runCodeFormatter, isTrue);
      expect(config.runCodeGenerator, isTrue);
    });

    test('should merge feature prefix from yaml into cli', () {
      final config = mergeConfigs(
        cli: CliFeatureGenConfig(
          featureName: 'auth',
          featurePrefix: null,
          outputDir: null,
          stateManagement: null,
          runCodeFormatter: null,
          runCodeGenerator: null,
        ),
        yaml: YamlFeatureGenConfig(
          featurePrefix: 'feat',
          outputDir: null,
          stateManagement: null,
          runCodeFormatter: null,
          runCodeGenerator: null,
        ),
        rootDirectoryPath: io.getCwd(),
      );

      expect(config.featureName, equals('auth'));
      expect(config.featurePrefix, equals('feat'));
      expect(config.outputDirectory, endsWith('lib/features'));
      expect(config.stateManagement, equals(StateManagement.bloc));
      expect(config.runCodeFormatter, isTrue);
      expect(config.runCodeGenerator, isTrue);
    });

    test('should merge output directory from yaml into cli', () {
      final config = mergeConfigs(
        cli: CliFeatureGenConfig(
          featureName: 'auth',
          featurePrefix: null,
          outputDir: null,
          stateManagement: null,
          runCodeFormatter: null,
          runCodeGenerator: null,
        ),
        yaml: YamlFeatureGenConfig(
          featurePrefix: null,
          outputDir: 'my_features',
          stateManagement: null,
          runCodeFormatter: null,
          runCodeGenerator: null,
        ),
        rootDirectoryPath: io.getCwd(),
      );

      expect(config.featureName, equals('auth'));
      expect(config.featurePrefix, isNull);
      expect(config.outputDirectory, endsWith('my_features'));
      expect(config.stateManagement, equals(StateManagement.bloc));
      expect(config.runCodeFormatter, isTrue);
      expect(config.runCodeGenerator, isTrue);
    });

    test('should merge state management from yaml into cli', () {
      final config = mergeConfigs(
        cli: CliFeatureGenConfig(
          featureName: 'auth',
          featurePrefix: null,
          outputDir: null,
          stateManagement: null,
          runCodeFormatter: null,
          runCodeGenerator: null,
        ),
        yaml: YamlFeatureGenConfig(
          featurePrefix: null,
          outputDir: null,
          stateManagement: 'cubit',
          runCodeFormatter: null,
          runCodeGenerator: null,
        ),
        rootDirectoryPath: io.getCwd(),
      );

      expect(config.featureName, equals('auth'));
      expect(config.featurePrefix, isNull);
      expect(config.outputDirectory, endsWith('lib/features'));
      expect(config.stateManagement, equals(StateManagement.cubit));
      expect(config.runCodeFormatter, isTrue);
      expect(config.runCodeGenerator, isTrue);
    });

    test('should merge run code formatter from yaml into cli', () {
      final config = mergeConfigs(
        cli: CliFeatureGenConfig(
          featureName: 'auth',
          featurePrefix: null,
          outputDir: null,
          stateManagement: null,
          runCodeFormatter: null,
          runCodeGenerator: null,
        ),
        yaml: YamlFeatureGenConfig(
          featurePrefix: null,
          outputDir: null,
          stateManagement: null,
          runCodeFormatter: false,
          runCodeGenerator: null,
        ),
        rootDirectoryPath: io.getCwd(),
      );

      expect(config.featureName, equals('auth'));
      expect(config.featurePrefix, isNull);
      expect(config.outputDirectory, endsWith('lib/features'));
      expect(config.stateManagement, equals(StateManagement.bloc));
      expect(config.runCodeFormatter, isFalse);
      expect(config.runCodeGenerator, isTrue);
    });

    test('should merge run code generator from yaml into cli', () {
      final config = mergeConfigs(
        cli: CliFeatureGenConfig(
          featureName: 'auth',
          featurePrefix: null,
          outputDir: null,
          stateManagement: null,
          runCodeFormatter: null,
          runCodeGenerator: null,
        ),
        yaml: YamlFeatureGenConfig(
          featurePrefix: null,
          outputDir: null,
          stateManagement: null,
          runCodeFormatter: null,
          runCodeGenerator: false,
        ),
        rootDirectoryPath: io.getCwd(),
      );

      expect(config.featureName, equals('auth'));
      expect(config.featurePrefix, isNull);
      expect(config.outputDirectory, endsWith('lib/features'));
      expect(config.stateManagement, equals(StateManagement.bloc));
      expect(config.runCodeFormatter, isTrue);
      expect(config.runCodeGenerator, isFalse);
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
        cli: CliFeatureGenConfig(
          featureName: 'auth',
          featurePrefix: 'cli_feat',
          outputDir: null,
          stateManagement: null,
          runCodeFormatter: null,
          runCodeGenerator: null,
        ),
        yaml: YamlFeatureGenConfig(
          featurePrefix: 'yaml_feat',
          outputDir: null,
          stateManagement: null,
          runCodeFormatter: null,
          runCodeGenerator: null,
        ),
        rootDirectoryPath: io.getCwd(),
      );

      expect(config.featureName, equals('auth'));
      expect(config.featurePrefix, equals('cli_feat'));
      expect(config.outputDirectory, endsWith('lib/features'));
      expect(config.stateManagement, equals(StateManagement.bloc));
      expect(config.runCodeFormatter, isTrue);
      expect(config.runCodeGenerator, isTrue);
    });

    test('takes output dir from cli instead of yaml', () {
      final config = mergeConfigs(
        cli: CliFeatureGenConfig(
          featureName: 'auth',
          featurePrefix: null,
          outputDir: 'cli_output',
          stateManagement: null,
          runCodeFormatter: null,
          runCodeGenerator: null,
        ),
        yaml: YamlFeatureGenConfig(
          featurePrefix: null,
          outputDir: 'yaml_output',
          stateManagement: null,
          runCodeFormatter: null,
          runCodeGenerator: null,
        ),
        rootDirectoryPath: io.getCwd(),
      );

      expect(config.featureName, equals('auth'));
      expect(config.featurePrefix, isNull);
      expect(config.outputDirectory, endsWith('cli_output'));
      expect(config.stateManagement, equals(StateManagement.bloc));
      expect(config.runCodeFormatter, isTrue);
      expect(config.runCodeGenerator, isTrue);
    });

    test('takes state management from cli instead of yaml', () {
      final config = mergeConfigs(
        cli: CliFeatureGenConfig(
          featureName: 'auth',
          featurePrefix: null,
          outputDir: null,
          stateManagement: 'cubit',
          runCodeFormatter: null,
          runCodeGenerator: null,
        ),
        yaml: YamlFeatureGenConfig(
          featurePrefix: null,
          outputDir: null,
          stateManagement: 'bloc',
          runCodeFormatter: null,
          runCodeGenerator: null,
        ),
        rootDirectoryPath: io.getCwd(),
      );

      expect(config.featureName, equals('auth'));
      expect(config.featurePrefix, isNull);
      expect(config.outputDirectory, endsWith('lib/features'));
      expect(config.stateManagement, equals(StateManagement.cubit));
      expect(config.runCodeFormatter, isTrue);
      expect(config.runCodeGenerator, isTrue);
    });

    test('takes run code formatter from cli instead of yaml', () {
      final config = mergeConfigs(
        cli: CliFeatureGenConfig(
          featureName: 'auth',
          featurePrefix: null,
          outputDir: null,
          stateManagement: null,
          runCodeFormatter: false,
          runCodeGenerator: null,
        ),
        yaml: YamlFeatureGenConfig(
          featurePrefix: null,
          outputDir: null,
          stateManagement: null,
          runCodeFormatter: true,
          runCodeGenerator: null,
        ),
        rootDirectoryPath: io.getCwd(),
      );

      expect(config.featureName, equals('auth'));
      expect(config.featurePrefix, isNull);
      expect(config.outputDirectory, endsWith('lib/features'));
      expect(config.stateManagement, equals(StateManagement.bloc));
      expect(config.runCodeFormatter, isFalse);
      expect(config.runCodeGenerator, isTrue);
    });

    test('takes run code generator from cli instead of yaml', () {
      final config = mergeConfigs(
        cli: CliFeatureGenConfig(
          featureName: 'auth',
          featurePrefix: null,
          outputDir: null,
          stateManagement: null,
          runCodeFormatter: null,
          runCodeGenerator: false,
        ),
        yaml: YamlFeatureGenConfig(
          featurePrefix: null,
          outputDir: null,
          stateManagement: null,
          runCodeFormatter: null,
          runCodeGenerator: true,
        ),
        rootDirectoryPath: io.getCwd(),
      );

      expect(config.featureName, equals('auth'));
      expect(config.featurePrefix, isNull);
      expect(config.outputDirectory, endsWith('lib/features'));
      expect(config.stateManagement, equals(StateManagement.bloc));
      expect(config.runCodeFormatter, isTrue);
      expect(config.runCodeGenerator, isFalse);
    });
  });
}
