import 'package:args/command_runner.dart';
import 'package:dart_feature_gen/src/cli/cli_feature_gen_config.dart';
import 'package:dart_feature_gen/src/cli/generate_command.dart';
import 'package:dart_feature_gen/src/config_parser.dart';
import 'package:dart_feature_gen/src/feature_generator.dart';
import 'package:dart_feature_gen/src/yaml/yaml_loader.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:file/local.dart';

Future<void> main(List<String> arguments) async {
  final logger = Logger();
  final runner = CommandRunner<CliFeatureGenConfig>(
    'generate',
    'Generate a feature directory',
  );

  runner.addCommand(GenerateCommand(logger: logger));
  final yamlLoader = YamlLoader(logger: logger);

  final readFileProgress =
      logger.progress('Reading dart_feature_gen.yaml file ...');
  final fileSystem = LocalFileSystem();
  final file = fileSystem.file('dart_feature_gen.yaml');
  String contents;
  if (await file.exists()) {
    contents = await file.readAsString();
    readFileProgress.complete('File has been read successfully.');
  } else {
    contents = '';
    readFileProgress.complete(
      'Failed to read dart_feature_gen.yaml. Using fallback.',
    );
  }

  final yamlConfig = await yamlLoader.run(contents);
  final cliConfig = await runner.run(arguments);
  if (cliConfig == null) {
    logger.err('Failed to read cli configuration');
    return;
  }

  final mergedConfig = mergeConfigs(cli: cliConfig, yaml: yamlConfig);
  final generator = FeatureGenerator(logger: logger);
  await generator.generate(mergedConfig);
}
