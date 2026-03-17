import 'package:dart_feature_gen/src/feature_gen_config.dart';
import 'package:dart_feature_gen/src/io/feature_gen_io.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart';
import 'package:recase/recase.dart';

class DomainGenerator {
  const DomainGenerator({required this.logger, required this.io});

  final Logger logger;
  final FeatureGenIO io;

  Future<void> generate(FeatureGenConfig config) async {
    final domainDirectory = joinAll([config.featurePath, 'domain']);
    await io.createDirectory(domainDirectory);
    await io.createDirectory(joinAll([domainDirectory, 'models']));
    await io
        .createDirectory(joinAll([domainDirectory, 'usecases', 'interactors']));
    await io
        .createDirectory(joinAll([domainDirectory, 'usecases', 'observers']));

    await io.createFile(
      joinAll([
        domainDirectory,
        'repositories',
        '${config.featureName}_repository.dart'
      ]),
      _Templates.repository(config.featureName),
    );
  }
}

abstract final class _Templates {
  static String repository(String featureName) {
    final className = featureName.pascalCase;

    return '''
abstract interface class ${className}Repository {
  // TODO: Implement repository contract
}
''';
  }
}
