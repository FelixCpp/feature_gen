import 'package:args/command_runner.dart';
import 'package:dart_feature_gen/src/cli/cli_feature_gen_config.dart';
import 'package:mason_logger/mason_logger.dart';

class GenerateCommand extends Command<CliFeatureGenConfig> {
  GenerateCommand({required this.logger}) {
    argParser.addOption(
      'feature-name',
      abbr: 'n',
      help: 'The name of the feature',
      valueHelp: 'auth',
      mandatory: true,
    );

    argParser.addOption(
      'feature-prefix',
      abbr: 'p',
      help: 'Prefix of the feature directory',
      valueHelp: 'feat',
    );

    argParser.addOption(
      'output-dir',
      abbr: 'o',
      help: 'Where to generate the feature in',
      valueHelp: 'lib/features',
    );

    argParser.addOption(
      'state-management',
      help: 'Which state management library to use for the presentation layer.',
      valueHelp: 'bloc',
      allowed: {'bloc', 'cubit'},
    );

    argParser.addFlag(
      'code-format',
      defaultsTo: true,
      help: 'Whether to run dart format afterwards.',
    );

    argParser.addFlag(
      'code-generate',
      defaultsTo: true,
      help: 'Whether to run the build_runner afterwards.',
    );
  }

  final Logger logger;

  @override
  String get name => 'generate';

  @override
  String get description => 'generate a feature directory';

  @override
  Future<CliFeatureGenConfig> run() async {
    final results = argResults;
    if (results == null) {
      throw StateError('results must not be null');
    }

    final featureName = results.option('feature-name')!;
    final featurePrefix = results.option('feature-prefix');
    final outputDir = results.option('output-dir');
    final stateManagement = results.option('state-management');
    final runCodeFormatter =
        results.wasParsed('code-format') ? results.flag('code-format') : null;
    final runCodeGenerator = results.wasParsed('code-generate')
        ? results.flag('code-generate')
        : null;

    return CliFeatureGenConfig(
      featureName: featureName,
      featurePrefix: featurePrefix,
      outputDir: outputDir,
      stateManagement: stateManagement,
      runCodeFormatter: runCodeFormatter,
      runCodeGenerator: runCodeGenerator,
    );
  }
}
