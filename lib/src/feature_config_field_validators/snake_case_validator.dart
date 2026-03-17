import 'package:dart_feature_gen/src/feature_config_field_validators/feature_config_field_validator.dart';
import 'package:recase/recase.dart';

final FeatureConfigFieldValidator snakeCaseValidator = (field, input) {
  final converted = input.snakeCase;
  if (converted != input) {
    return ValidatedInput.invalid(
      '${field.key} must be provided in snake_case',
    );
  }

  return ValidatedInput.valid(input);
};
