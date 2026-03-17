import 'package:dart_feature_gen/src/feature_config_field_validators/feature_config_field_validator.dart';
import 'package:dart_feature_gen/src/feature_config_fields.dart';
import 'package:dart_feature_gen/src/state_management.dart';

final _allowedValues = {
  'bloc': StateManagement.bloc,
  'cubit': StateManagement.cubit,
};

ValidatedInput stateManagementValidator(
    FeatureConfigFields field, String input) {
  for (final entry in _allowedValues.entries) {
    if (entry.key == input) {
      return ValidatedInput.valid(input);
    }
  }

  return ValidatedInput.invalid(
    'Invalid input for ${field.key}: $input. Allowed values are [${_allowedValues.keys.join(', ')}]',
  );
}
