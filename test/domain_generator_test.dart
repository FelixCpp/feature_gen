import 'package:dart_feature_gen/src/config/feature_config.dart';
import 'package:dart_feature_gen/src/generators/domain_generator.dart';
import 'package:file/file.dart';
import 'package:test/test.dart';
import 'package:file/memory.dart';

void main() {
  group(DomainGenerator, () {
    late FileSystem fileSystem;
    late DomainGenerator generator;

    setUp(() {
      fileSystem = MemoryFileSystem.test();
      generator = DomainGenerator(
        config: FeatureGenConfig(
          featureName: 'counter',
          outputDirectory: 'lib/features',
          featurePrefix: null,
          format: true,
          build: true,
          smLibrary: StateManagementLibrary.bloc,
        ),
        fileSystem: fileSystem,
      );
    });

    test('should generate domain directory', () async {
      await generator.generate();

      expect(
        fileSystem.isDirectory('lib/features/counter/domain/models'),
        completion(isTrue),
      );

      expect(
        fileSystem
            .file(
              'lib/features/counter/domain/repositories/counter_repository.dart',
            )
            .readAsString(),
        completion(
          equals('''
abstract interface class CounterRepository {
  // TODO: Define repository contract
}
'''),
        ),
      );

      expect(
        fileSystem.isDirectory(
          'lib/features/counter/domain/usecases/interactors',
        ),
        completion(isTrue),
      );

      expect(
        fileSystem.isDirectory(
          'lib/features/counter/domain/usecases/observers',
        ),
        completion(isTrue),
      );
    });
  });
}
