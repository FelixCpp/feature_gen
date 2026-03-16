import 'dart:io';
import 'package:dart_feature_gen/src/process/process_runner.dart';
import 'package:file/file.dart';
import 'package:path/path.dart' as path;

import 'package:mason_logger/mason_logger.dart';

class SystemProcessRunner implements ProcessRunner {
  const SystemProcessRunner({
    required this.logger,
    required this.workingDirectory,
    required this.fileSystem,
  });

  final Logger logger;
  final String workingDirectory;
  final FileSystem fileSystem;

  @override
  Future<void> runBuildRunner(String featurePath) async {
    final progress = logger.progress('Running build_runner ...');
    if (!await _hasBuildRunner()) {
      progress.fail(
        'Could not run build_runner due to missing dependency in project. Make sure your pubspec.yaml file contains the build_runner dependency.',
      );

      return;
    }

    try {
      final buildFilter = '$featurePath/**';

      final result = await Process.run(
        'dart',
        [
          'run',
          'build_runner',
          'build',
          '--build-filter=$buildFilter',
          '--delete-conflicting-outputs',
        ],
        workingDirectory: workingDirectory,
      );

      if (result.exitCode == 0) {
        progress.complete('build_runner finished');
      } else {
        progress.fail('build_runner failed');
        logger.err(result.stderr.toString());
      }
    } catch (e) {
      progress.fail('Could not run build_runner: $e');
    }
  }

  @override
  Future<void> runDartFormat(String featurePath) async {
    final progress = logger.progress('Running dart format...');

    try {
      final result = await Process.run(
        'dart',
        ['format', featurePath],
        workingDirectory: workingDirectory,
      );

      if (result.exitCode == 0) {
        progress.complete('dart format finished');
      } else {
        progress.fail('dart format failed');
        logger.err(result.stderr.toString());
      }
    } catch (e) {
      progress.fail('Could not run dart format: $e');
    }
  }

  Future<bool> _hasBuildRunner() async {
    final pubspecFile = fileSystem.file(
      path.join(workingDirectory, 'pubspec.yaml'),
    );

    if (!await pubspecFile.exists()) {
      return false;
    }

    // TODO(Felix): Be aware of commented out lines
    final content = await pubspecFile.readAsString();
    return content.contains('build_runner');
  }
}
