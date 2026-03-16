import 'package:dart_feature_gen/src/config/feature_config.dart';
import 'package:dart_feature_gen/src/generators/data_generator.dart';
import 'package:file/file.dart';
import 'package:test/test.dart';
import 'package:file/memory.dart';

void main() {
  group(DataGenerator, () {
    late FileSystem fileSystem;
    late DataGenerator generator;

    setUp(() {
      fileSystem = MemoryFileSystem.test();
      generator = DataGenerator(
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

    test('should generate data directory', () async {
      await generator.generate();

      expect(
        fileSystem
            .file('lib/features/counter/data/daos/counter_dao.dart')
            .readAsString(),
        completion(
          equals('''
class CounterDao {
  // TODO: Implement DAO
}
'''),
        ),
      );

      expect(
        fileSystem
            .file(
              'lib/features/counter/data/repositories/counter_repository_impl.dart',
            )
            .readAsString(),
        completion(
          equals('''
import '../../domain/repositories/counter_repository.dart';

class CounterRepositoryImpl implements CounterRepository {
  const CounterRepositoryImpl();
}
'''),
        ),
      );

      expect(
        fileSystem
            .file(
              'lib/features/counter/data/datasources/counter_remote_datasource.dart',
            )
            .readAsString(),
        completion(
          equals('''
abstract class CounterRemoteDatasource {
  // TODO: Define datasource contract
}

class CounterRemoteDatasourceImpl implements CounterRemoteDatasource {
  // TODO: Implement datasource
}
'''),
        ),
      );

      expect(
        fileSystem
            .file(
              'lib/features/counter/data/di/counter_data_module.dart',
            )
            .readAsString(),
        completion(
          equals('''
// Dependency Injection for Counter feature (data layer)
'''),
        ),
      );
    });
  });
}
