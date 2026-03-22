import 'package:dart_feature_gen/src/feature_gen_config.dart';
import 'package:dart_feature_gen/src/generators/data_generator.dart';
import 'package:dart_feature_gen/src/io/feature_gen_io.dart';
import 'package:file/file.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as path;

import 'memory_file_system.dart';

void main() {
  group(DataGenerator, () {
    late FileSystem fileSystem;
    late DataGenerator generator;

    setUp(() {
      fileSystem = getTestFileSystem();

      final logger = Logger(level: Level.quiet);
      final io = FeatureGenIO(fileSystem: fileSystem, logger: logger);
      generator = DataGenerator(logger: logger, io: io);
    });

    test(
      'should generate directories and files with correct content',
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
          fileSystem
              .file(path.join('auth', 'data', 'daos', 'auth_dao.dart'))
              .readAsString(),
          completion(equals('''
class AuthDao {
  // TODO: Implement Database-Access-Object
}
''')),
        );

        expect(
          fileSystem
              .file(path.join(
                  'auth', 'data', 'datasources', 'auth_datasource.dart'))
              .readAsString(),
          completion(equals('''
abstract interface class AuthDatasource {
  // TODO: Implement datasource contract
}

class RemoteAuthDatasource implements AuthDatasource {
  // TODO: Implement remote datasource
}
''')),
        );

        expect(
            fileSystem
                .file(path.join(
                  'auth',
                  'data',
                  'repositories',
                  'auth_repository_impl.dart',
                ))
                .readAsString(),
            completion(equals('''
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  // TODO: Implement repository
}
''')));

        expect(
            fileSystem
                .file(path.join('auth', 'data', 'di', 'auth_module.dart'))
                .readAsString(),
            completion(equals('''
class AuthModule {
  // TODO: Implement module
}
''')));
      },
    );
  });
}
