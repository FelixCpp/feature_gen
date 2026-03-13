import 'dart:async';
import 'dart:io' as io;

import 'package:args/command_runner.dart';
import 'package:feature_gen/src/config/feature_config.dart';
import 'package:feature_gen/src/generators/feature_generator.dart';
import 'package:feature_gen/src/process/process_runner.dart';
import 'package:file/file.dart';
import 'package:mason_logger/mason_logger.dart';

class GenerateCommand extends Command<void> {
  GenerateCommand({
    required this.logger,
    required this.fileSystem,
    required this.processRunner,
  }) {
    argParser.addOption(
      'output-dir',
      abbr: 'o',
      defaultsTo: 'lib/features',
      help:
          'Output directory for feature generation (overrides feature_gen.yaml)',
    );

    argParser.addFlag(
      'build',
      defaultsTo: true,
      help: 'Run build_runner after generation (overrides feature_gen.yaml)',
    );

    argParser.addFlag(
      'format',
      defaultsTo: true,
      help: 'Run dart format after generation (overrides feature_gen.yaml)',
    );
  }

  final Logger logger;
  final FileSystem fileSystem;
  final ProcessRunner processRunner;

  @override
  String get name => 'generate';

  @override
  String get description => 'Generates a new feature structure';

  @override
  FutureOr<void> run() async {
    final argResults = this.argResults;
    final args = argResults?.rest;
    if (argResults == null || args == null || args.isEmpty) {
      logger.err(
        'Please provide a feature name. Usage: feature_gen generate <name>',
      );
      return;
    }

    final configLoader = ConfigLoader(
      logger: logger,
      fileSystem: fileSystem,
    );

    final config = await configLoader.load(
      workingDirectory: io.Directory.current.path,
    );

    final mergedConfig = config.merge(
      outputDirectory: argResults.wasParsed('output-dir')
          ? argResults.option('output-dir')
          : null,
      format: argResults.wasParsed('format') ? argResults.flag('format') : null,
      buildRunner: argResults.wasParsed('build')
          ? argResults.flag('build')
          : null,
    );

    final generator = FeatureGenerator(
      logger: logger,
      fileSystem: fileSystem,
      processRunner: processRunner,
    );

    return generator.generate(
      featureName: args.first,
      config: mergedConfig,
    );
  }
}
