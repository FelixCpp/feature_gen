import 'package:dart_feature_gen/src/io/feature_gen_io.dart';
import 'package:file/file.dart';
import 'package:path/path.dart' as path;

Future<File?> findNearestFile({
  required FeatureGenIO io,
  required Directory startingDirectory,
  required String targetFileName,
}) async {
  var currentDirectory = startingDirectory;

  while (true) {
    final configFile = io.getFile(path.join(
      currentDirectory.path,
      targetFileName,
    ));

    if (await configFile.exists()) {
      return configFile;
    }

    final parent = currentDirectory.parent;
    if (currentDirectory == parent) {
      return null;
    }

    currentDirectory = parent;
  }
}
