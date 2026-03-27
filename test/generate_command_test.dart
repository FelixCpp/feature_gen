import 'package:args/command_runner.dart';
import 'package:dart_feature_gen/src/cli/cli_feature_gen_config.dart';
import 'package:dart_feature_gen/src/cli/generate_command.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:test/test.dart';

void main() {
  group('GenerateCommand', () {
    late CommandRunner<CliFeatureGenConfig> runner;
    late GenerateCommand command;

    setUp(() {
      runner = CommandRunner(
        'generate',
        'Generate a feature',
      );

      command = GenerateCommand(
        logger: Logger(
          level: Level.quiet,
        ),
      );

      runner.addCommand(command);
    });

    test('should create config with default values', () async {
      final config = await runner.run([
        'generate',
        '--feature-name',
        'auth',
      ]);

      expect(config, isNotNull);
      expect(config?.featureName, equals('auth'));
      expect(config?.featurePrefix, isNull);
      expect(config?.outputDir, isNull);
      expect(config?.stateManagement, isNull);
      expect(config?.dataClassFormat, isNull);
      expect(config?.runCodeFormatter, isNull);
      expect(config?.runCodeGenerator, isNull);
    });

    test('should create config with prefix', () async {
      final config = await runner.run([
        'generate',
        '--feature-name',
        'auth',
        '--feature-prefix',
        'feat',
      ]);

      expect(config, isNotNull);
      expect(config?.featureName, equals('auth'));
      expect(config?.featurePrefix, equals('feat'));
      expect(config?.outputDir, isNull);
      expect(config?.stateManagement, isNull);
      expect(config?.dataClassFormat, isNull);
      expect(config?.runCodeFormatter, isNull);
      expect(config?.runCodeGenerator, isNull);
    });

    test('should create config with output-dir', () async {
      final config = await runner.run([
        'generate',
        '--feature-name',
        'auth',
        '--output-dir',
        'my_features',
      ]);

      expect(config, isNotNull);
      expect(config?.featureName, equals('auth'));
      expect(config?.featurePrefix, isNull);
      expect(config?.outputDir, equals('my_features'));
      expect(config?.stateManagement, isNull);
      expect(config?.dataClassFormat, isNull);
      expect(config?.runCodeFormatter, isNull);
      expect(config?.runCodeGenerator, isNull);
    });

    test('should create config with state-management bloc', () async {
      final config = await runner.run([
        'generate',
        '--feature-name',
        'auth',
        '--state-management',
        'bloc',
      ]);

      expect(config, isNotNull);
      expect(config?.featureName, equals('auth'));
      expect(config?.featurePrefix, isNull);
      expect(config?.outputDir, isNull);
      expect(config?.stateManagement, equals('bloc'));
      expect(config?.dataClassFormat, isNull);
      expect(config?.runCodeFormatter, isNull);
      expect(config?.runCodeGenerator, isNull);
    });

    test('should create config with state-management cubit', () async {
      final config = await runner.run([
        'generate',
        '--feature-name',
        'auth',
        '--state-management',
        'cubit',
      ]);

      expect(config, isNotNull);
      expect(config?.featureName, equals('auth'));
      expect(config?.featurePrefix, isNull);
      expect(config?.outputDir, isNull);
      expect(config?.stateManagement, equals('cubit'));
      expect(config?.dataClassFormat, isNull);
      expect(config?.runCodeFormatter, isNull);
      expect(config?.runCodeGenerator, isNull);
    });

    test('should create config with data-class-format freezed', () async {
      final config = await runner.run([
        'generate',
        '--feature-name',
        'auth',
        '--data-class-format',
        'freezed',
      ]);

      expect(config, isNotNull);
      expect(config?.featureName, equals('auth'));
      expect(config?.featurePrefix, isNull);
      expect(config?.outputDir, isNull);
      expect(config?.stateManagement, isNull);
      expect(config?.dataClassFormat, equals('freezed'));
      expect(config?.runCodeFormatter, isNull);
      expect(config?.runCodeGenerator, isNull);
    });

    test('should create config with data-class-format native', () async {
      final config = await runner.run([
        'generate',
        '--feature-name',
        'auth',
        '--data-class-format',
        'native',
      ]);

      expect(config, isNotNull);
      expect(config?.featureName, equals('auth'));
      expect(config?.featurePrefix, isNull);
      expect(config?.outputDir, isNull);
      expect(config?.stateManagement, isNull);
      expect(config?.dataClassFormat, equals('native'));
      expect(config?.runCodeFormatter, isNull);
      expect(config?.runCodeGenerator, isNull);
    });

    test('should create config with code formatter turned on', () async {
      final config = await runner.run([
        'generate',
        '--feature-name',
        'auth',
        '--code-format',
      ]);

      expect(config, isNotNull);
      expect(config?.featureName, equals('auth'));
      expect(config?.featurePrefix, isNull);
      expect(config?.outputDir, isNull);
      expect(config?.stateManagement, isNull);
      expect(config?.dataClassFormat, isNull);
      expect(config?.runCodeFormatter, isTrue);
      expect(config?.runCodeGenerator, isNull);
    });

    test('should create config with code formatter turned off', () async {
      final config = await runner.run([
        'generate',
        '--feature-name',
        'auth',
        '--no-code-format',
      ]);

      expect(config, isNotNull);
      expect(config?.featureName, equals('auth'));
      expect(config?.featurePrefix, isNull);
      expect(config?.outputDir, isNull);
      expect(config?.stateManagement, isNull);
      expect(config?.dataClassFormat, isNull);
      expect(config?.runCodeFormatter, isFalse);
      expect(config?.runCodeGenerator, isNull);
    });

    test('should create config with code generator turned on', () async {
      final config = await runner.run([
        'generate',
        '--feature-name',
        'auth',
        '--code-generate',
      ]);

      expect(config, isNotNull);
      expect(config?.featureName, equals('auth'));
      expect(config?.featurePrefix, isNull);
      expect(config?.outputDir, isNull);
      expect(config?.stateManagement, isNull);
      expect(config?.dataClassFormat, isNull);
      expect(config?.runCodeFormatter, isNull);
      expect(config?.runCodeGenerator, isTrue);
    });

    test('should create config with code generator turned off', () async {
      final config = await runner.run([
        'generate',
        '--feature-name',
        'auth',
        '--no-code-generate',
      ]);

      expect(config, isNotNull);
      expect(config?.featureName, equals('auth'));
      expect(config?.featurePrefix, isNull);
      expect(config?.outputDir, isNull);
      expect(config?.stateManagement, isNull);
      expect(config?.dataClassFormat, isNull);
      expect(config?.runCodeFormatter, isNull);
      expect(config?.runCodeGenerator, isFalse);
    });
  });
}
