import 'package:dart_feature_gen/src/config/feature_config.dart';
import 'package:dart_feature_gen/src/templates/presentation_templates.dart';
import 'package:file/file.dart';
import 'package:path/path.dart' as path;

class PresentationGenerator {
  final FeatureGenConfig config;
  final FileSystem fileSystem;

  const PresentationGenerator({
    required this.config,
    required this.fileSystem,
  });

  Future<void> generate() async {
    final featurePath = path.join(
      config.outputDirectory,
      config.featureDirName,
      'presentation',
    );

    await switch (config.smLibrary) {
      StateManagementLibrary.bloc => _generateBloc(featurePath),
      StateManagementLibrary.cubit => _generateCubit(featurePath)
    };
  }

  Future<void> _generateCubit(String featurePath) async {
    await _createDirectory(path.join(featurePath, 'cubit'));

    await _createFile(
      path.join(featurePath, '${config.featureName}_screen.dart'),
      PresentationCubitTemplates.screen(config.featureName),
    );

    await _createFile(
      path.join(featurePath, 'cubit', '${config.featureName}_cubit.dart'),
      PresentationCubitTemplates.cubit(config.featureName),
    );

    await _createFile(
      path.join(featurePath, 'cubit', '${config.featureName}_state.dart'),
      PresentationCubitTemplates.state(config.featureName),
    );
  }

  Future<void> _generateBloc(String featurePath) async {
    await _createDirectory(path.join(featurePath, 'bloc'));

    await _createFile(
      path.join(featurePath, '${config.featureName}_screen.dart'),
      PresentationBlocTemplates.screen(config.featureName),
    );

    await _createFile(
      path.join(featurePath, 'bloc', '${config.featureName}_bloc.dart'),
      PresentationBlocTemplates.bloc(config.featureName),
    );

    await _createFile(
      path.join(featurePath, 'bloc', '${config.featureName}_event.dart'),
      PresentationBlocTemplates.event(config.featureName),
    );

    await _createFile(
      path.join(featurePath, 'bloc', '${config.featureName}_state.dart'),
      PresentationBlocTemplates.state(config.featureName),
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
