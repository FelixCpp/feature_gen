import 'package:args/command_runner.dart';
import 'package:feature_gen/src/commands/generate_command.dart';
import 'package:file/local.dart';

void main(List<String> arguments) {
  final runner = CommandRunner<void>(
    'feature_gen',
    'Generates Flutter feature structure',
  );

  runner.addCommand(GenerateCommand(fileSystem: LocalFileSystem()));
  runner.run(arguments);
}
