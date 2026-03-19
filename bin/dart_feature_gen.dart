import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dart_feature_gen/src/cli/cli_feature_gen_config.dart';
import 'package:dart_feature_gen/src/cli/generate_command.dart';
import 'package:dart_feature_gen/src/config_parser.dart';
import 'package:dart_feature_gen/src/feature_gen_config.dart';
import 'package:dart_feature_gen/src/generators/feature_generator.dart';
import 'package:dart_feature_gen/src/io/feature_gen_io.dart';
import 'package:dart_feature_gen/src/runners/system_process_runner.dart';
import 'package:dart_feature_gen/src/utility/find_nearest_file.dart';
import 'package:dart_feature_gen/src/yaml/yaml_config_loader.dart';
import 'package:dart_feature_gen/src/yaml/yaml_feature_gen_config.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:file/local.dart';
import 'package:path/path.dart';

Future<void> main(List<String> arguments) async {
  final logger = Logger();
  final io = FeatureGenIO(fileSystem: LocalFileSystem(), logger: logger);

  try {
    final cliConfig = await _parseCliConfig(arguments, logger);
    if (cliConfig == null) return;

    final projectFile = await _findProjectRoot(io, logger);
    if (projectFile == null) return;

    final yamlConfig = await _loadYamlConfig(
      io,
      logger,
      projectFile.parent.path,
    );

    final mergedConfig = mergeConfigs(
      cli: cliConfig,
      yaml: yamlConfig,
      rootDirectoryPath: projectFile.parent.path,
    );

    await _runGenerators(mergedConfig, logger, io);
  } catch (e, stack) {
    logger.err('An error occurred: $e');
    logger.detail(stack.toString());
  }
}

Future<CliFeatureGenConfig?> _parseCliConfig(
  List<String> arguments,
  Logger logger,
) async {
  final runner = CommandRunner<CliFeatureGenConfig>(
    'generate',
    'Generate a feature directory',
  );
  runner.addCommand(GenerateCommand(logger: logger));
  return await runner.run(arguments);
}

Future<File?> _findProjectRoot(FeatureGenIO io, Logger logger) async {
  final projectFile = await findNearestFile(
    io: io,
    startingDirectory: io.getCwdDir(),
    targetFileName: 'pubspec.yaml',
  );
  if (projectFile == null) {
    logger.err(
      "No pubspec file found. Could not determine root of your project.",
    );

    return null;
  }

  logger.success('Project root found at ${projectFile.parent.path}.');
  return projectFile;
}

Future<YamlFeatureGenConfig> _loadYamlConfig(
  FeatureGenIO io,
  Logger logger,
  String rootPath,
) async {
  logger.info('Searching for dart_feature_gen.yaml configuration file ...');
  final configFile = io.getFile(join(rootPath, 'dart_feature_gen.yaml'));
  if (await configFile.exists()) {
    logger.info('Configuration file found. Reading contents ...');
    final contents = await configFile.readAsString();
    final configLoader = YamlConfigLoader(io: io, logger: logger);
    return await configLoader.loadConfigFromSource(contents);
  }

  return YamlFeatureGenConfig(
    featurePrefix: null,
    outputDir: null,
    stateManagement: null,
    runCodeFormatter: null,
    runCodeGenerator: null,
  );
}

Future<void> _runGenerators(
  FeatureGenConfig mergedConfig,
  Logger logger,
  FeatureGenIO io,
) async {
  final generator = FeatureGenerator(logger: logger, io: io);
  await generator.generate(mergedConfig);

  final processRunner = SystemProcessRunner(logger: logger);

  if (mergedConfig.runCodeGenerator) {
    await processRunner.runBuildRunner(mergedConfig);
  } else {
    logger.info('Skipping code generation');
  }

  if (mergedConfig.runCodeFormatter) {
    await processRunner.runDartFormat(mergedConfig);
  } else {
    logger.info('Skipping code formatting');
  }
}
