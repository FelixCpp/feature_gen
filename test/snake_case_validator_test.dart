import 'package:dart_feature_gen/src/feature_config_field_validators/feature_config_field_validator.dart';
import 'package:dart_feature_gen/src/feature_config_field_validators/snake_case_validator.dart';
import 'package:dart_feature_gen/src/feature_config_fields.dart';
import 'package:test/test.dart';

void main() {
  group('snakeCaseValidator', () {
    test('should be able to convert valid snake_case value', () {
      expect(
        snakeCaseValidator(
          FeatureConfigFields.featureNameKey,
          'auth_feature_field',
        ),
        isA<ValidInput>(),
      );
    });

    test('should not be able to convert invalid snake_case value', () {
      expect(
        snakeCaseValidator(
          FeatureConfigFields.featureNameKey,
          'authFeature_field',
        ),
        isA<InvalidInput>(),
      );
    });

    test(
        'should not be able to convert invalid snake_case value due to capitalization',
        () {
      expect(
        snakeCaseValidator(
          FeatureConfigFields.featureNameKey,
          'auth_Feature_field',
        ),
        isA<InvalidInput>(),
      );
    });
  });
}
