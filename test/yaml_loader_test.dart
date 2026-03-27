import 'package:dart_feature_gen/src/io/feature_gen_io.dart';
import 'package:dart_feature_gen/src/yaml/yaml_config_loader.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:test/test.dart';

import 'memory_file_system.dart';

void main() {
  group('YamlLoader', () {
    late YamlConfigLoader yamlLoader;
    setUp(() {
      final logger = Logger(level: Level.quiet);
      final fileSystem = getTestFileSystem();

      yamlLoader = YamlConfigLoader(
        io: FeatureGenIO(fileSystem: fileSystem, logger: logger),
        logger: logger,
      );
    });

    test('should parse default config', () async {
      final config = await yamlLoader.loadConfigFromSource('');

      expect(config.featurePrefix, isNull);
      expect(config.outputDir, isNull);
      expect(config.stateManagement, isNull);
      expect(config.runCodeFormatter, isNull);
      expect(config.runCodeGenerator, isNull);
    });

    test('should parse feature prefix', () async {
      final config = await yamlLoader.loadConfigFromSource('''
        feature-prefix: feat
      ''');

      expect(config.featurePrefix, equals('feat'));
      expect(config.outputDir, isNull);
      expect(config.stateManagement, isNull);
      expect(config.runCodeFormatter, isNull);
      expect(config.runCodeGenerator, isNull);
    });

    test('should parse output directory', () async {
      final config = await yamlLoader.loadConfigFromSource('''
        output-dir: libs/features
      ''');

      expect(config.featurePrefix, isNull);
      expect(config.outputDir, endsWith('libs/features'));
      expect(config.stateManagement, isNull);
      expect(config.runCodeFormatter, isNull);
      expect(config.runCodeGenerator, isNull);
    });

    test('should parse state management bloc', () async {
      final config = await yamlLoader.loadConfigFromSource('''
        state-management: bloc
      ''');

      expect(config.featurePrefix, isNull);
      expect(config.outputDir, isNull);
      expect(config.stateManagement, equals('bloc'));
      expect(config.runCodeFormatter, isNull);
      expect(config.runCodeGenerator, isNull);
    });

    test('should parse state management cubit', () async {
      final config = await yamlLoader.loadConfigFromSource('''
        state-management: cubit
      ''');

      expect(config.featurePrefix, isNull);
      expect(config.outputDir, isNull);
      expect(config.stateManagement, equals('cubit'));
      expect(config.runCodeFormatter, isNull);
      expect(config.runCodeGenerator, isNull);
    });

    test('should parse data class format freezed', () async {
      final config = await yamlLoader.loadConfigFromSource('''
        data-class-format: freezed
      ''');

      expect(config.featurePrefix, isNull);
      expect(config.outputDir, isNull);
      expect(config.stateManagement, isNull);
      expect(config.dataClassFormat, equals('freezed'));
      expect(config.runCodeFormatter, isNull);
      expect(config.runCodeGenerator, isNull);
    });

    test('should parse data class format native', () async {
      final config = await yamlLoader.loadConfigFromSource('''
        data-class-format: native
      ''');

      expect(config.featurePrefix, isNull);
      expect(config.outputDir, isNull);
      expect(config.stateManagement, isNull);
      expect(config.dataClassFormat, equals('native'));
      expect(config.runCodeFormatter, isNull);
      expect(config.runCodeGenerator, isNull);
    });

    test('should parse code format flag', () async {
      final config = await yamlLoader.loadConfigFromSource('''
        code-format: false
      ''');

      expect(config.featurePrefix, isNull);
      expect(config.outputDir, isNull);
      expect(config.stateManagement, isNull);
      expect(config.dataClassFormat, isNull);
      expect(config.runCodeFormatter, isFalse);
      expect(config.runCodeGenerator, isNull);
    });

    test('should parse code generate flag', () async {
      final config = await yamlLoader.loadConfigFromSource('''
        code-generate: false
      ''');

      expect(config.featurePrefix, isNull);
      expect(config.outputDir, isNull);
      expect(config.stateManagement, isNull);
      expect(config.dataClassFormat, isNull);
      expect(config.runCodeFormatter, isNull);
      expect(config.runCodeGenerator, isFalse);
    });
  });
}
