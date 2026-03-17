import 'package:args/command_runner.dart';
import 'package:dart_feature_gen/src/cli/cli_feature_gen_config.dart';
import 'package:dart_feature_gen/src/cli/generate_command.dart';
import 'package:dart_feature_gen/src/config_parser.dart';
import 'package:dart_feature_gen/src/generators/feature_generator.dart';
import 'package:dart_feature_gen/src/io/feature_gen_io.dart';
import 'package:dart_feature_gen/src/yaml/yaml_loader.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:file/local.dart';

Future<void> main(List<String> arguments) async {
  final logger = Logger();
  final io = FeatureGenIO(fileSystem: LocalFileSystem(), logger: logger);
  final runner = CommandRunner<CliFeatureGenConfig>(
    'generate',
    'Generate a feature directory',
  );

  runner.addCommand(GenerateCommand(logger: logger));
  final yamlLoader = YamlLoader(logger: logger);

  final contents = await io.readFile('dart_feature_gen.yaml') ?? '';
  final yamlConfig = await yamlLoader.run(contents);
  final cliConfig = await runner.run(arguments);
  if (cliConfig == null) {
    logger.err('Failed to read cli configuration');
    return;
  }

  final mergedConfig = mergeConfigs(io: io, cli: cliConfig, yaml: yamlConfig);
  final generator = FeatureGenerator(logger: logger, io: io);
  await generator.generate(mergedConfig);
}
