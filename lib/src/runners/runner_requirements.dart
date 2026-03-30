import 'package:dart_feature_gen/src/feature_gen_config.dart';
import 'package:dart_feature_gen/src/project/dependencies.dart.dart';
import 'package:mason_logger/mason_logger.dart';

enum ExternalDependency {
  flutterBloc,
  riverpodAnnotation,
  flutterRiverpod,
  riverpodGenerator,

  freezed,
  freezedAnnotation,
  buildRunner,
}

extension RequiredPackagesOfConfig on FeatureGenConfig {
  Set<ExternalDependency> getRequiredPackages() {
    final packages = <ExternalDependency>{};

    if (stateManagement == StateManagement.bloc ||
        stateManagement == StateManagement.cubit) {
      packages.add(ExternalDependency.flutterBloc);
    }

    if (stateManagement == StateManagement.riverpod) {
      packages.addAll([
        ExternalDependency.riverpodAnnotation,
        ExternalDependency.flutterRiverpod,
        ExternalDependency.riverpodGenerator,
        if (runCodeGenerator) ExternalDependency.buildRunner,
      ]);
    }

    if (dataClassFormat == DataClassFormat.freezed) {
      packages.addAll({
        ExternalDependency.freezed,
        ExternalDependency.freezedAnnotation,
        if (runCodeGenerator) ExternalDependency.buildRunner,
      });
    }

    return packages;
  }
}

bool validateDependencies(
  Set<ExternalDependency> packages,
  Dependencies deps,
  Logger logger,
) {
  for (final package in packages) {
    switch (package) {
      case ExternalDependency.flutterBloc:
        if (!deps.hasDependency('flutter_bloc')) {
          logger.err('Dependency "flutter_bloc" is required but not found.');
          return false;
        }
      case ExternalDependency.riverpodAnnotation:
        if (!deps.hasDependency('riverpod_annotation')) {
          logger.err(
              'Dependency "riverpod_annotation" is required but not found.');
          return false;
        }
      case ExternalDependency.riverpodGenerator:
        if (!deps.hasDependency('riverpod_generator')) {
          logger.err(
              'Dependency "riverpod_generator" is required but not found.');
          return false;
        }
      case ExternalDependency.flutterRiverpod:
        if (!deps.hasDependency('flutter_riverpod')) {
          logger
              .err('Dependency "flutter_riverpod" is required but not found.');
          return false;
        }
      case ExternalDependency.freezed:
        if (!deps.hasDependency('freezed')) {
          logger.err('Dependency "freezed" is required but not found.');
          return false;
        }
      case ExternalDependency.freezedAnnotation:
        if (!deps.hasDependency('freezed_annotation')) {
          logger.err(
              'Dependency "freezed_annotation" is required but not found.');
          return false;
        }
      case ExternalDependency.buildRunner:
        if (!deps.hasDependency('build_runner')) {
          logger.err('Dependency "build_runner" is required but not found.');
          return false;
        }
    }
  }

  return true;
}
