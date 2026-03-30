import 'dart:io';

import 'package:mason_logger/mason_logger.dart';
import 'package:yaml/yaml.dart';

enum DependencyType {
  dependency,
  devDependency,
}

abstract interface class Dependencies {
  bool hasDependency(String packageName);
}

class YamlDependencies implements Dependencies {
  static Future<YamlDependencies> fromFile({
    required File file,
    required Logger logger,
  }) async {
    final contents = await file.readAsString();
    final yaml = loadYaml(contents) as Map? ?? {};
    return YamlDependencies(yaml: yaml, logger: logger);
  }

  const YamlDependencies({required this.yaml, required this.logger});
  final Map yaml;
  final Logger logger;

  @override
  bool hasDependency(String packageName) {
    final dependencies = yaml['dependencies'];
    if (dependencies != null) {
      if (dependencies.containsKey(packageName)) {
        logger.success('Found dependency "$packageName" in pubspec.yaml');
        return true;
      }
    }

    final devDependencies = yaml['dev_dependencies'];
    if (devDependencies != null) {
      if (devDependencies.containsKey(packageName)) {
        logger.success('Found dev_dependency "$packageName" in pubspec.yaml');
        return true;
      }
    }

    logger.warn(
      'Did not find "$packageName" whether in dependencies nor in dev_dependencies inside pubspec.yaml',
    );

    return false;
  }
}
