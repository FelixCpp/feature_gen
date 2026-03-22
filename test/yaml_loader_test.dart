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
    });

    test('should parse feature prefix', () async {
      final config = await yamlLoader.loadConfigFromSource('''
        feature-prefix: feat
      ''');

      expect(config.featurePrefix, equals('feat'));
      expect(config.outputDir, isNull);
      expect(config.stateManagement, isNull);
    });

    test('should parse output directory', () async {
      final config = await yamlLoader.loadConfigFromSource('''
        output-dir: libs/features
      ''');

      expect(config.featurePrefix, isNull);
      expect(config.outputDir, endsWith('libs/features'));
      expect(config.stateManagement, isNull);
    });

    test('should parse state management bloc', () async {
      final config = await yamlLoader.loadConfigFromSource('''
        state-management: bloc
      ''');

      expect(config.featurePrefix, isNull);
      expect(config.outputDir, isNull);
      expect(config.stateManagement, equals('bloc'));
    });

    test('should parse state management cubit', () async {
      final config = await yamlLoader.loadConfigFromSource('''
        state-management: cubit
      ''');

      expect(config.featurePrefix, isNull);
      expect(config.outputDir, isNull);
      expect(config.stateManagement, equals('cubit'));
    });
  });
}
