import 'dart:async';
import 'dart:io' as io;

import 'package:args/command_runner.dart';
import 'package:dart_feature_gen/src/config/feature_config.dart';
import 'package:dart_feature_gen/src/generators/feature_generator.dart';
import 'package:dart_feature_gen/src/process/process_runner.dart';
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
      help: 'Output directory for feature generation',
    );

    argParser.addOption(
      'feature-prefix',
      defaultsTo: null,
      valueHelp: 'feat',
      help: 'Prefix that is put in front of the feature directory',
    );

    argParser.addOption(
      'state-management-library',
      defaultsTo: 'bloc',
      valueHelp: 'bloc or cubit',
      help: 'Prefix that is put in front of the feature directory',
      allowed: ['bloc', 'cubit'],
      allowedHelp: {
        'bloc':
            'Generate the presentation layer using flutter_bloc (bloc) & freezed',
        'cubit':
            'Generate the presentation layer using flutter_bloc (cubit) & freezed',
      },
    );

    argParser.addFlag(
      'build',
      defaultsTo: true,
      help: 'Run build_runner after generation',
    );

    argParser.addFlag(
      'format',
      defaultsTo: true,
      help: 'Run dart format after generation',
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
    final featureName = argResults?.rest.firstOrNull;
    if (argResults == null || featureName == null) {
      logger.err(
        'Please provide a feature name. Usage: feature_gen generate <name>',
      );
      return;
    }

    final configLoader = ConfigLoader(
      logger: logger,
      fileSystem: fileSystem,
    );

    var config = await configLoader.load(
      workingDirectory: io.Directory.current.path,
      featureName: featureName,
    );

    if (argResults.option('output-dir') case String outputDir) {
      config = config.copyWith(outputDirectory: outputDir);
    }

    if (argResults.wasParsed('format')) {
      config = config.copyWith(format: argResults.flag('format'));
    }

    if (argResults.wasParsed('build')) {
      config = config.copyWith(build: argResults.flag('build'));
    }

    final generator = FeatureGenerator(
      logger: logger,
      fileSystem: fileSystem,
      processRunner: processRunner,
    );

    return generator.generate(config: config);
  }
}
