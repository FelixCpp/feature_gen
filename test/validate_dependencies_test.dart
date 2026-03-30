import 'package:dart_feature_gen/src/project/dependencies.dart.dart';
import 'package:dart_feature_gen/src/runners/runner_requirements.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:test/test.dart';

void main() {
  group('validateDependencies', () {
    test('dev_dependencies should contain build_runner', () {
      final logger = Logger(level: Level.quiet);
      final packages = {
        ExternalDependency.buildRunner,
      };

      final dependencies = YamlDependencies(
        yaml: {
          'dev_dependencies': {
            'build_runner': '^1.2.3',
          },
        },
        logger: logger,
      );

      final validationResult = validateDependencies(
        packages,
        dependencies,
        logger,
      );

      expect(validationResult, isTrue);
    });

    test('dev_dependencies should contain freezed & freezed_annotation', () {
      final logger = Logger(level: Level.quiet);
      final packages = {
        ExternalDependency.freezed,
        ExternalDependency.freezedAnnotation,
      };

      final dependencies = YamlDependencies(
        yaml: {
          'dependencies': {
            'freezed_annotation': '^1.2.3',
          },
          'dev_dependencies': {
            'freezed': '^1.2.3',
          },
        },
        logger: logger,
      );

      final validationResult = validateDependencies(
        packages,
        dependencies,
        logger,
      );

      expect(validationResult, isTrue);
    });
  });
}
