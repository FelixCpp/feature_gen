import 'package:freezed_annotation/freezed_annotation.dart';

part 'yaml_feature_gen_config.freezed.dart';

@freezed
sealed class YamlFeatureGenConfig with _$YamlFeatureGenConfig {
  const factory YamlFeatureGenConfig({
    required String? featurePrefix,
    required String? outputDir,
    required String? stateManagement,
  }) = _YamlFeatureGenConfig;
}
