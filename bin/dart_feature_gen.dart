import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dart_feature_gen/src/commands/generate_command.dart';
import 'package:dart_feature_gen/src/process/system_process_runner.dart';
import 'package:file/local.dart';
import 'package:mason_logger/mason_logger.dart';

void main(List<String> arguments) {
  final runner = CommandRunner<void>(
    'dart_feature_gen',
    'Generates Flutter feature structure',
  );

  final logger = Logger();
  final workingDirectory = Directory.current.path;
  final fileSystem = LocalFileSystem();

  runner.addCommand(
    GenerateCommand(
      logger: logger,
      fileSystem: fileSystem,
      processRunner: SystemProcessRunner(
        logger: logger,
        workingDirectory: workingDirectory,
        fileSystem: fileSystem,
      ),
    ),
  );
  runner.run(arguments);
}
