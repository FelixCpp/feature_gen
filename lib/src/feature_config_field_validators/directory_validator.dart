import 'package:dart_feature_gen/src/feature_config_field_validators/feature_config_field_validator.dart';
import 'package:recase/recase.dart';

final FeatureConfigFieldValidator directoryValidator = (field, input) {
  final converted = input.pathCase;
  if (converted != input) {
    return ValidatedInput.invalid(
      '${field.key} must be provided in path-case (e.g. libs/features)',
    );
  }

  return ValidatedInput.valid(input);
};
