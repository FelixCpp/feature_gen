import 'package:freezed_annotation/freezed_annotation.dart';

part 'feature_gen_config.freezed.dart';

enum StateManagement {
  bloc,
  cubit,
}

@freezed
sealed class FeatureGenConfig with _$FeatureGenConfig {
  const factory FeatureGenConfig({
    required String featureName,
    required String? featurePrefix,
    required String outputDirectory,
    required StateManagement stateManagement,
  }) = _FeatureGenConfig;
}

@freezed
sealed class RawFeatureGenConfig with _$RawFeatureGenConfig {
  const factory RawFeatureGenConfig({
    required String? featureName,
    required String? featurePrefix,
    required String? outputDir,
    required String? stateManagement,
  }) = _RawFeatureGenConfig;
}
