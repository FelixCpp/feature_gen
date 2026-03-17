import 'package:dart_feature_gen/src/feature_config_field_validators/directory_validator.dart';
import 'package:dart_feature_gen/src/feature_config_field_validators/feature_config_field_validator.dart';
import 'package:dart_feature_gen/src/feature_config_fields.dart';
import 'package:test/test.dart';

void main() {
  group('directoryValidator', () {
    test('should be able to convert valid directory value', () {
      expect(
        directoryValidator(
          FeatureConfigFields.featureNameKey,
          'libs/features',
        ),
        equals(ValidInput('libs/features')),
      );
    });

    test('should not be able to convert invalid directory value', () {
      expect(
        directoryValidator(
          FeatureConfigFields.featureNameKey,
          'libs_testing/frameworks',
        ),
        isA<InvalidInput>(),
      );
    });
  });
}
