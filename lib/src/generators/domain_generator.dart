import 'package:dart_feature_gen/src/config/feature_config.dart';
import 'package:dart_feature_gen/src/templates/domain_templates.dart';
import 'package:file/file.dart';
import 'package:path/path.dart' as path;

class DomainGenerator {
  final FeatureGenConfig config;
  final FileSystem fileSystem;

  const DomainGenerator({
    required this.config,
    required this.fileSystem,
  });

  Future<void> generate() async {
    final featurePath = path.join(
      config.outputDirectory,
      config.featureDirName,
      'domain',
    );

    await _createFile(
      path.join(
        featurePath,
        'repositories',
        '${config.featureName}_repository.dart',
      ),
      DomainTemplates.repository(config.featureName),
    );

    await _createDirectory(path.join(featurePath, 'models'));
    await _createDirectory(path.join(featurePath, 'usecases', 'interactors'));
    await _createDirectory(path.join(featurePath, 'usecases', 'observers'));
  }

  Future<void> _createFile(String filepath, String content) async {
    final file = fileSystem.file(filepath);
    await file.parent.create(recursive: true);
    await file.writeAsString(content);
  }

  Future<void> _createDirectory(String path) async {
    final file = fileSystem.directory(path);
    await file.create(recursive: true);
  }
}
