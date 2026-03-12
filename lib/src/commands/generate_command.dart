import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:feature_gen/src/generators/feature_generator.dart';
import 'package:file/file.dart';
import 'package:mason_logger/mason_logger.dart';

class GenerateCommand extends Command<void> {
  GenerateCommand({
    required FileSystem fileSystem,
  }) : _logger = Logger(),
       _fileSystem = fileSystem {
    argParser.addOption(
      'path',
      abbr: 'p',
      defaultsTo: 'lib/features',
      help: 'Base path for feature generation',
    );
  }

  final Logger _logger;
  final FileSystem _fileSystem;

  @override
  String get name => 'generate';

  @override
  String get description => 'Generates a new feature structure';

  @override
  FutureOr<void> run() async {
    final args = argResults?.rest;
    if (args == null || args.isEmpty) {
      _logger.err('Please provide a feature name');
      return;
    }

    final featureName = args.first;
    final basePath = argResults?['path'] as String;

    final generator = FeatureGenerator(
      logger: _logger,
      fileSystem: _fileSystem,
    );

    return generator.generate(featureName: featureName, basePath: basePath);
  }
}
