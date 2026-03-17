import 'package:dart_feature_gen/src/feature_config_fields.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'feature_config_field_validator.freezed.dart';

@Freezed(genericArgumentFactories: true)
sealed class ValidatedInput<T> with _$ValidatedInput<T> {
  factory ValidatedInput<T>.invalid(String errorMessage) = InvalidInput;
  factory ValidatedInput<T>.valid(String transformed) = ValidInput;
}

typedef FeatureConfigFieldValidator = ValidatedInput Function(
  FeatureConfigFields field,
  String input,
);
