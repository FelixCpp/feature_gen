import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';

import 'package:mason_logger/mason_logger.dart';

class ProcessRunner {
  const ProcessRunner({
    required this.logger,
    required this.workingDirectory,
  });

  final Logger logger;
  final String workingDirectory;

  Future<void> runBuildRunner(String featurePath) async {
    final progress = logger.progress('Running build_runner ...');

    try {
      final packageName = await _readPackageName();

      // featurePath z.B. "lib/features/auth" → "myapp|lib/features/auth/**"
      final buildFilter = '$packageName|$featurePath/**';

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

  Future<String> _readPackageName() async {
    final pubspecFile = File(path.join(workingDirectory, 'pubspec.yaml'));

    if (!await pubspecFile.exists()) {
      throw Exception('pubspec.yaml not found in $workingDirectory');
    }

    final content = await pubspecFile.readAsString();
    final yaml = loadYaml(content) as Map;
    final name = yaml['name'] as String?;

    if (name == null)
      throw Exception('Could not read package name from pubspec.yaml');
    return name;
  }
}
