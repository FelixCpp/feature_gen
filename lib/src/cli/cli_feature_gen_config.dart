import 'package:freezed_annotation/freezed_annotation.dart';

part 'cli_feature_gen_config.freezed.dart';

@freezed
sealed class CliFeatureGenConfig with _$CliFeatureGenConfig {
  const factory CliFeatureGenConfig({
    required String featureName,
    required String? featurePrefix,
    required String? outputDir,
    required String? stateManagement,
  }) = _CliFeatureGenConfig;
}
