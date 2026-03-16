import 'package:dart_feature_gen/src/config/feature_config.dart';
import 'package:dart_feature_gen/src/templates/data_templates.dart';
import 'package:file/file.dart';
import 'package:path/path.dart' as path;

class DataGenerator {
  final FeatureGenConfig config;
  final FileSystem fileSystem;

  const DataGenerator({
    required this.config,
    required this.fileSystem,
  });

  Future<void> generate() async {
    final featurePath = path.join(
      config.outputDirectory,
      config.featureDirName,
      'data',
    );

    await _createFile(
      path.join(
        featurePath,
        'repositories',
        '${config.featureName}_repository_impl.dart',
      ),
      DataTemplates.repositoryImpl(config.featureName),
    );

    await _createFile(
      path.join(
        featurePath,
        'datasources',
        '${config.featureName}_remote_datasource.dart',
      ),
      DataTemplates.remoteDatasource(config.featureName),
    );

    await _createFile(
      path.join(featurePath, 'daos', '${config.featureName}_dao.dart'),
      DataTemplates.dao(config.featureName),
    );

    await _createFile(
      path.join(featurePath, 'di', '${config.featureName}_data_module.dart'),
      DataTemplates.diModule(config.featureName),
    );
  }

  Future<void> _createFile(String filepath, String content) async {
    final file = fileSystem.file(filepath);
    await file.parent.create(recursive: true);
    await file.writeAsString(content);
  }
}
