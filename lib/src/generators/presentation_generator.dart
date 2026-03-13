import 'package:feature_gen/src/templates/presentation_templates.dart';
import 'package:file/file.dart';
import 'package:path/path.dart' as path;

class PresentationGenerator {
  final String featureName;
  final String outputDirectory;
  final FileSystem fileSystem;

  const PresentationGenerator({
    required this.featureName,
    required this.outputDirectory,
    required this.fileSystem,
  });

  Future<void> generate() async {
    final featurePath = path.join(outputDirectory, featureName, 'presentation');

    await _createFile(
      path.join(featurePath, '${featureName}_screen.dart'),
      PresentationTemplates.screen(featureName),
    );

    await _createDirectory(path.join(featurePath, 'bloc'));

    await _createFile(
      path.join(featurePath, 'bloc', '${featureName}_bloc.dart'),
      PresentationTemplates.bloc(featureName),
    );

    await _createFile(
      path.join(featurePath, 'bloc', '${featureName}_event.dart'),
      PresentationTemplates.event(featureName),
    );

    await _createFile(
      path.join(featurePath, 'bloc', '${featureName}_state.dart'),
      PresentationTemplates.state(featureName),
    );
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
