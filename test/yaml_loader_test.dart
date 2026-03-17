import 'package:dart_feature_gen/src/yaml/yaml_loader.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:test/test.dart';

void main() {
  group('YamlLoader', () {
    late YamlLoader yamlLoader;
    setUp(() {
      yamlLoader = YamlLoader(logger: Logger(level: Level.quiet));
    });

    test('should parse default config', () async {
      final config = await yamlLoader.run('');

      expect(config.featurePrefix, isNull);
      expect(config.outputDir, isNull);
      expect(config.stateManagement, isNull);
    });

    test('should parse feature prefix', () async {
      final config = await yamlLoader.run('''
        feature-prefix: feat
      ''');

      expect(config.featurePrefix, equals('feat'));
      expect(config.outputDir, isNull);
      expect(config.stateManagement, isNull);
    });

    test('should parse output directory', () async {
      final config = await yamlLoader.run('''
        output-dir: libs/features
      ''');

      expect(config.featurePrefix, isNull);
      expect(config.outputDir, endsWith('libs/features'));
      expect(config.stateManagement, isNull);
    });

    test('should parse state management bloc', () async {
      final config = await yamlLoader.run('''
        state-management: bloc
      ''');

      expect(config.featurePrefix, isNull);
      expect(config.outputDir, isNull);
      expect(config.stateManagement, equals('bloc'));
    });

    test('should parse state management cubit', () async {
      final config = await yamlLoader.run('''
        state-management: cubit
      ''');

      expect(config.featurePrefix, isNull);
      expect(config.outputDir, isNull);
      expect(config.stateManagement, equals('cubit'));
    });
  });
}
