import 'package:file/file.dart';
import 'package:mason_logger/mason_logger.dart';

class FeatureGenIO {
  const FeatureGenIO({
    required this.fileSystem,
    required this.logger,
  });

  final FileSystem fileSystem;
  final Logger logger;

  String getCwd() {
    return fileSystem.currentDirectory.path;
  }

  Future<void> createDirectory(String path) async {
    await fileSystem.directory(path).create(recursive: true);
    logger.success('Successfully create directory "$path"');
  }

  Future<void> createFile(String path, String contents) async {
    final file = await fileSystem.file(path).create(recursive: true);
    await file.writeAsString(contents);
    logger.success('Successfully create file "$path"');
  }

  Future<String?> readFile(String path) async {
    final file = fileSystem.file(path);
    if (!await file.exists()) {
      logger.warn('File not found: "$path"');
      return null;
    }

    final result = await file.readAsString();
    logger.success('Successfully read contents of file "$path"');
    return result;
  }
}
