import 'package:dart_feature_gen/src/feature_config_field_validators/directory_validator.dart';
import 'package:dart_feature_gen/src/feature_config_field_validators/feature_config_field_validator.dart';
import 'package:dart_feature_gen/src/feature_config_field_validators/snake_case_validator.dart';
import 'package:dart_feature_gen/src/feature_config_field_validators/state_management_validator.dart';
import 'package:dart_feature_gen/src/feature_config_fields.dart';
import 'package:dart_feature_gen/src/state_management.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'feature_config.freezed.dart';

@freezed
sealed class FeatureConfig with _$FeatureConfig {
  const factory FeatureConfig({
    required String featureName,
    required String featurePrefix,
    required String outputDirectory,
    required StateManagement stateManagement,
  }) = _FeatureConfig;
}

final parsers = {
  FeatureConfigFields.featureNameKey: snakeCaseValidator,
  FeatureConfigFields.featurePrefixKey: snakeCaseValidator,
  FeatureConfigFields.outputDirectoryKey: directoryValidator,
  FeatureConfigFields.stateManagementKey: stateManagementValidator,
};

FeatureConfig load(
  ValidInput featureName,
  ValidInput featurePrefix,
  ValidInput outputDirectory,
  ValidInput stateManagement,
) {
  return FeatureConfig(
    featureName: featureName.transformed,
    featurePrefix: featurePrefix.transformed,
    outputDirectory: outputDirectory.transformed,
    stateManagement: stateManagement.transformed,
  );
}
