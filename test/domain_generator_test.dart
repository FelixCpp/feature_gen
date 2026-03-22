import 'package:dart_feature_gen/src/feature_gen_config.dart';
import 'package:dart_feature_gen/src/generators/domain_generator.dart';
import 'package:dart_feature_gen/src/io/feature_gen_io.dart';
import 'package:file/file.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as path;

import 'memory_file_system.dart';

void main() {
  group(DomainGenerator, () {
    late FileSystem fileSystem;
    late DomainGenerator generator;

    setUp(() {
      final logger = Logger(level: Level.quiet);
      fileSystem = getTestFileSystem();
      generator = DomainGenerator(
        logger: logger,
        io: FeatureGenIO(
          fileSystem: fileSystem,
          logger: logger,
        ),
      );
    });

    test('should generate directories and files with correct content',
        () async {
      final config = FeatureGenConfig(
        featureName: 'auth',
        featurePrefix: null,
        outputDirectory: '',
        stateManagement: StateManagement.bloc,
        runCodeFormatter: true,
        runCodeGenerator: true,
      );

      await generator.generate(config);

      expect(
        fileSystem.isDirectory(path.join('auth', 'domain', 'models')),
        completion(isTrue),
      );
      expect(
        fileSystem
            .file(path.join(
              'auth',
              'domain',
              'repositories',
              'auth_repository.dart',
            ))
            .readAsString(),
        completion(equals('''
abstract interface class AuthRepository {
  // TODO: Implement repository contract
}
''')),
      );
      expect(
        fileSystem.isDirectory(path.join(
          'auth',
          'domain',
          'usecases',
          'interactors',
        )),
        completion(isTrue),
      );
      expect(
        fileSystem.isDirectory(path.join(
          'auth',
          'domain',
          'usecases',
          'observers',
        )),
        completion(isTrue),
      );
    });
  });
}
