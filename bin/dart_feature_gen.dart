import 'package:args/command_runner.dart';
import 'package:dart_feature_gen/src/cli/cli_feature_gen_config.dart';
import 'package:dart_feature_gen/src/cli/generate_command.dart';
import 'package:dart_feature_gen/src/config_parser.dart';
import 'package:dart_feature_gen/src/feature_gen_config.dart';
import 'package:dart_feature_gen/src/generators/feature_generator.dart';
import 'package:dart_feature_gen/src/io/feature_gen_io.dart';
import 'package:dart_feature_gen/src/project/dependencies.dart.dart';
import 'package:dart_feature_gen/src/project/find_nearest_file.dart';
import 'package:dart_feature_gen/src/runners/runner_requirements.dart';
import 'package:dart_feature_gen/src/runners/system_process_runner.dart';
import 'package:dart_feature_gen/src/yaml/yaml_config_loader.dart';
import 'package:dart_feature_gen/src/yaml/yaml_feature_gen_config.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:file/local.dart';

Future<void> main(List<String> arguments) async {
  final logger = Logger();
  final io = FeatureGenIO(fileSystem: LocalFileSystem(), logger: logger);

  try {
    final cliConfig = await _parseCliConfig(arguments, logger);
    if (cliConfig == null) return;

    final pubspecFile = await findNearestFile(
      io: io,
      startingDirectory: io.getCwdDir(),
      targetFileName: 'pubspec.yaml',
    );

    if (pubspecFile == null) {
      logger.err('Could not find file named "pubspec.yaml"');
      return;
    }

    final deps = await YamlDependencies.fromFile(
      file: pubspecFile,
      logger: logger,
    );

    final yamlConfig = await _loadYamlConfig(io, logger);
    final mergedConfig = mergeConfigs(
      cli: cliConfig,
      yaml: yamlConfig,
      rootDirectoryPath: pubspecFile.parent.path,
    );

    final requiredPackages = mergedConfig.getRequiredPackages();
    if (!validateDependencies(requiredPackages, deps, logger)) {
      return;
    }

    await _runGenerators(mergedConfig, requiredPackages, logger, io);
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

Future<YamlFeatureGenConfig> _loadYamlConfig(
  FeatureGenIO io,
  Logger logger,
) async {
  logger.info('Searching for dart_feature_gen.yaml configuration file ...');
  final configFile = await findNearestFile(
    io: io,
    startingDirectory: io.getCwdDir(),
    targetFileName: 'dart_feature_gen.yaml',
  );

  if (configFile != null && await configFile.exists()) {
    logger.info('Configuration file found. Reading contents ...');
    final contents = await configFile.readAsString();
    final configLoader = YamlConfigLoader(io: io, logger: logger);
    return await configLoader.loadConfigFromSource(contents);
  }

  return YamlFeatureGenConfig(
    featurePrefix: null,
    outputDir: null,
    stateManagement: null,
    dataClassFormat: null,
    runCodeFormatter: null,
    runCodeGenerator: null,
  );
}

Future<void> _runGenerators(
  FeatureGenConfig mergedConfig,
  Set<ExternalDependency> packages,
  Logger logger,
  FeatureGenIO io,
) async {
  final generator = FeatureGenerator(logger: logger, io: io);
  await generator.generate(mergedConfig);

  final processRunner = SystemProcessRunner(logger: logger);

  if (mergedConfig.runCodeGenerator &&
      packages.contains(ExternalDependency.buildRunner)) {
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
