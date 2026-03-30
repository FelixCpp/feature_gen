import 'package:dart_feature_gen/src/project/dependencies.dart.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:test/test.dart';

import 'memory_file_system.dart';

void main() {
  group(Dependencies, () {
    test('should find dependencies in yaml map', () {
      final yaml = {
        'dependencies': {
          'freezed_annotation': "^1.2.3",
        },
        'dev_dependencies': {
          'build_runner': "^1.2.3",
          'freezed': "^1.2.3",
        },
      };

      final dependencies = YamlDependencies(
        yaml: yaml,
        logger: Logger(level: Level.quiet),
      );

      expect(dependencies.hasDependency('freezed'), isTrue);
      expect(dependencies.hasDependency('freezed_annotation'), isTrue);
      expect(dependencies.hasDependency('build_runner'), isTrue);
    });

    test('should find dependencies in pubspec.yaml', () async {
      final fileSystem = getTestFileSystem();
      final file = await fileSystem.file('pubspec.yaml').create();

      await file.writeAsString('''
dependencies:
  freezed_annotation: ^1.2.3

dev_dependencies:
  build_runner: ^1.2.3
  freezed: ^1.2.3
''');

      final dependencies = await YamlDependencies.fromFile(
        file: file,
        logger: Logger(level: Level.quiet),
      );

      expect(dependencies.hasDependency('freezed'), isTrue);
      expect(dependencies.hasDependency('freezed_annotation'), isTrue);
      expect(dependencies.hasDependency('build_runner'), isTrue);
    });
  });
}
