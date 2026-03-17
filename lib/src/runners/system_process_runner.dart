import 'dart:io';

import 'package:dart_feature_gen/src/feature_gen_config.dart';
import 'package:dart_feature_gen/src/runners/process_runner.dart';
import 'package:mason_logger/mason_logger.dart';

class SystemProcessRunner implements ProcessRunner {
  const SystemProcessRunner({required this.logger});
  final Logger logger;

  @override
  Future<void> runBuildRunner(FeatureGenConfig config) async {
    final progress = logger.progress('Running build_runner...');

    try {
      final result = await Process.run(
        'dart',
        ['run', 'build_runner', 'build', '--delete-conflicting-outputs'],
      );

      if (result.exitCode != 0) {
        progress.fail('Failed to run build_runner: ${result.stderr}');
        return;
      }

      progress.complete('build_runner finished successfully.');
    } catch (exception) {
      progress.fail('Failed to run build_runner: $exception');
    }
  }

  @override
  Future<void> runDartFormat(FeatureGenConfig config) async {
    final progress = logger.progress('Running dart format ...');

    try {
      final result = await Process.run(
        'dart',
        ['format', config.featurePath],
      );

      if (result.exitCode != 0) {
        progress.fail('Failed to run dart format: ${result.stderr}');
        return;
      }

      progress.complete('Dart code formatted successfully');
    } catch (exception) {
      progress.fail('Failed to run dart format: $exception');
    }
  }
}
