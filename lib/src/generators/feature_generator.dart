import 'dart:io' as io;

import 'package:dart_feature_gen/src/config/feature_config.dart';
import 'package:dart_feature_gen/src/generators/data_generator.dart';
import 'package:dart_feature_gen/src/generators/domain_generator.dart';
import 'package:dart_feature_gen/src/generators/presentation_generator.dart';
import 'package:dart_feature_gen/src/process/process_runner.dart';
import 'package:file/file.dart';
import 'package:path/path.dart' as path;
import 'package:mason_logger/mason_logger.dart';

class FeatureGenerator {
  const FeatureGenerator({
    required this.logger,
    required this.fileSystem,
    required this.processRunner,
  });

  final Logger logger;
  final FileSystem fileSystem;
  final ProcessRunner processRunner;

  String get workingDirectory => io.Directory.current.path;

  Future<void> generate({
    required FeatureGenConfig config,
  }) async {
    final featurePath = path.join(
      config.outputDirectory,
      config.featureDirName,
    );

    final progress = logger.progress(
      'Generating feature "${config.featureName}"',
    );

    try {
      await DataGenerator(config: config, fileSystem: fileSystem).generate();
      await DomainGenerator(config: config, fileSystem: fileSystem).generate();
      await PresentationGenerator(config: config, fileSystem: fileSystem)
          .generate();

      progress
          .complete('Feature "${config.featureName}" created successfully!');
    } catch (e) {
      progress.fail('Failed to generate feature: $e');
      return;
    }

    if (config.format) {
      await processRunner.runDartFormat(featurePath);
    } else {
      logger.info('Skipping code formatting (disabled via config)');
    }

    if (config.build) {
      await processRunner.runBuildRunner(featurePath);
    } else {
      logger.info('Skipping build_runner (disabled via config)');
    }
  }
}
