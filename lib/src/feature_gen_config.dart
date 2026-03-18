import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart';

part 'feature_gen_config.freezed.dart';

enum StateManagement {
  bloc,
  cubit,
  riverpod,
}

@freezed
sealed class FeatureGenConfig with _$FeatureGenConfig {
  const factory FeatureGenConfig({
    required String featureName,
    required String? featurePrefix,
    required String outputDirectory,
    required StateManagement stateManagement,
    required bool runCodeFormatter,
    required bool runCodeGenerator,
  }) = _FeatureGenConfig;
}

extension FeaturePath on FeatureGenConfig {
  String get featurePath {
    final featureNameWithPrefix =
        '${featurePrefix != null ? '${featurePrefix}_' : ''}$featureName';

    return join(outputDirectory, featureNameWithPrefix);
  }
}
