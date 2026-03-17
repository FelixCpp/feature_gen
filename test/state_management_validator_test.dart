import 'package:dart_feature_gen/src/feature_config_field_validators/feature_config_field_validator.dart';
import 'package:dart_feature_gen/src/feature_config_field_validators/state_management_validator.dart';
import 'package:dart_feature_gen/src/feature_config_fields.dart';
import 'package:test/test.dart';

void main() {
  group('stateManagementValidator', () {
    test('should be able to convert bloc value', () {
      expect(
        stateManagementValidator(
          FeatureConfigFields.stateManagementKey,
          'bloc',
        ),
        isA<ValidInput>(),
      );
    });

    test('should be able to convert cubit value', () {
      expect(
        stateManagementValidator(
          FeatureConfigFields.stateManagementKey,
          'cubit',
        ),
        isA<ValidInput>(),
      );
    });

    test('should not be able to convert blOc value', () {
      expect(
        stateManagementValidator(
          FeatureConfigFields.stateManagementKey,
          'blOc',
        ),
        isA<InvalidInput>(),
      );
    });

    test('should not be able to convert Cubit value', () {
      expect(
        stateManagementValidator(
          FeatureConfigFields.stateManagementKey,
          'Cubit',
        ),
        isA<InvalidInput>(),
      );
    });
  });
}
