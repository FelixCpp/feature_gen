import 'package:feature_gen/src/templates/data_templates.dart';
import 'package:file/file.dart';
import 'package:path/path.dart' as path;

class DataGenerator {
  final String featureName;
  final String outputDirectory;
  final FileSystem fileSystem;

  const DataGenerator({
    required this.featureName,
    required this.outputDirectory,
    required this.fileSystem,
  });

  Future<void> generate() async {
    final featurePath = path.join(outputDirectory, featureName, 'data');

    await _createFile(
      path.join(
        featurePath,
        'repositories',
        '${featureName}_repository_impl.dart',
      ),
      DataTemplates.repositoryImpl(featureName),
    );

    await _createFile(
      path.join(
        featurePath,
        'datasources',
        '${featureName}_remote_datasource.dart',
      ),
      DataTemplates.remoteDatasource(featureName),
    );

    await _createFile(
      path.join(featurePath, 'daos', '${featureName}_dao.dart'),
      DataTemplates.dao(featureName),
    );

    await _createFile(
      path.join(featurePath, 'di', '${featureName}_data_module.dart'),
      DataTemplates.diModule(featureName),
    );
  }

  Future<void> _createFile(String filepath, String content) async {
    final file = fileSystem.file(filepath);
    await file.parent.create(recursive: true);
    await file.writeAsString(content);
  }
}
