import 'package:dart_feature_gen/src/feature_gen_config.dart';
import 'package:dart_feature_gen/src/io/feature_gen_io.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart';
import 'package:recase/recase.dart';

class DataGenerator {
  const DataGenerator({
    required this.logger,
    required this.io,
  });

  final Logger logger;
  final FeatureGenIO io;

  Future<void> generate(FeatureGenConfig config) async {
    final dataDirectory = joinAll([config.featurePath, 'data']);
    await io.createDirectory(dataDirectory);

    await io.createFile(
      joinAll([dataDirectory, 'daos', '${config.featureName}_dao.dart']),
      _Templates.dao(config.featureName),
    );

    await io.createFile(
      joinAll([
        dataDirectory,
        'repositories',
        '${config.featureName}_repository_impl.dart'
      ]),
      _Templates.repositoryImpl(config.featureName),
    );

    await io.createFile(
      joinAll([dataDirectory, 'di', '${config.featureName}_module.dart']),
      _Templates.diModule(config.featureName),
    );
  }
}

abstract final class _Templates {
  static String dao(String featureName) {
    final className = featureName.pascalCase;

    return '''
class ${className}Dao {
  // TODO: Implement Database-Access-Object
}
''';
  }

  static String repositoryImpl(String featureName) {
    final className = featureName.pascalCase;
    return '''
import '../../domain/repositories/${featureName}_repository.dart';

class ${className}RepositoryImpl implements ${className}Repository {
  // TODO: Implement repository
}
''';
  }

  static String diModule(String featureName) {
    return '''
// TODO: Implement Dependency-Injection Module
''';
  }
}
