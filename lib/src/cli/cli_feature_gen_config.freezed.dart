// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cli_feature_gen_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CliFeatureGenConfig {
  String get featureName;
  String? get featurePrefix;
  String? get outputDir;
  String? get stateManagement;

  /// Create a copy of CliFeatureGenConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CliFeatureGenConfigCopyWith<CliFeatureGenConfig> get copyWith =>
      _$CliFeatureGenConfigCopyWithImpl<CliFeatureGenConfig>(
          this as CliFeatureGenConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CliFeatureGenConfig &&
            (identical(other.featureName, featureName) ||
                other.featureName == featureName) &&
            (identical(other.featurePrefix, featurePrefix) ||
                other.featurePrefix == featurePrefix) &&
            (identical(other.outputDir, outputDir) ||
                other.outputDir == outputDir) &&
            (identical(other.stateManagement, stateManagement) ||
                other.stateManagement == stateManagement));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, featureName, featurePrefix, outputDir, stateManagement);

  @override
  String toString() {
    return 'CliFeatureGenConfig(featureName: $featureName, featurePrefix: $featurePrefix, outputDir: $outputDir, stateManagement: $stateManagement)';
  }
}

/// @nodoc
abstract mixin class $CliFeatureGenConfigCopyWith<$Res> {
  factory $CliFeatureGenConfigCopyWith(
          CliFeatureGenConfig value, $Res Function(CliFeatureGenConfig) _then) =
      _$CliFeatureGenConfigCopyWithImpl;
  @useResult
  $Res call(
      {String featureName,
      String? featurePrefix,
      String? outputDir,
      String? stateManagement});
}

/// @nodoc
class _$CliFeatureGenConfigCopyWithImpl<$Res>
    implements $CliFeatureGenConfigCopyWith<$Res> {
  _$CliFeatureGenConfigCopyWithImpl(this._self, this._then);

  final CliFeatureGenConfig _self;
  final $Res Function(CliFeatureGenConfig) _then;

  /// Create a copy of CliFeatureGenConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? featureName = null,
    Object? featurePrefix = freezed,
    Object? outputDir = freezed,
    Object? stateManagement = freezed,
  }) {
    return _then(_self.copyWith(
      featureName: null == featureName
          ? _self.featureName
          : featureName // ignore: cast_nullable_to_non_nullable
              as String,
      featurePrefix: freezed == featurePrefix
          ? _self.featurePrefix
          : featurePrefix // ignore: cast_nullable_to_non_nullable
              as String?,
      outputDir: freezed == outputDir
          ? _self.outputDir
          : outputDir // ignore: cast_nullable_to_non_nullable
              as String?,
      stateManagement: freezed == stateManagement
          ? _self.stateManagement
          : stateManagement // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [CliFeatureGenConfig].
extension CliFeatureGenConfigPatterns on CliFeatureGenConfig {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_CliFeatureGenConfig value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CliFeatureGenConfig() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_CliFeatureGenConfig value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CliFeatureGenConfig():
        return $default(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_CliFeatureGenConfig value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CliFeatureGenConfig() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String featureName, String? featurePrefix,
            String? outputDir, String? stateManagement)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CliFeatureGenConfig() when $default != null:
        return $default(_that.featureName, _that.featurePrefix, _that.outputDir,
            _that.stateManagement);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String featureName, String? featurePrefix,
            String? outputDir, String? stateManagement)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CliFeatureGenConfig():
        return $default(_that.featureName, _that.featurePrefix, _that.outputDir,
            _that.stateManagement);
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String featureName, String? featurePrefix,
            String? outputDir, String? stateManagement)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CliFeatureGenConfig() when $default != null:
        return $default(_that.featureName, _that.featurePrefix, _that.outputDir,
            _that.stateManagement);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _CliFeatureGenConfig implements CliFeatureGenConfig {
  const _CliFeatureGenConfig(
      {required this.featureName,
      required this.featurePrefix,
      required this.outputDir,
      required this.stateManagement});

  @override
  final String featureName;
  @override
  final String? featurePrefix;
  @override
  final String? outputDir;
  @override
  final String? stateManagement;

  /// Create a copy of CliFeatureGenConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CliFeatureGenConfigCopyWith<_CliFeatureGenConfig> get copyWith =>
      __$CliFeatureGenConfigCopyWithImpl<_CliFeatureGenConfig>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CliFeatureGenConfig &&
            (identical(other.featureName, featureName) ||
                other.featureName == featureName) &&
            (identical(other.featurePrefix, featurePrefix) ||
                other.featurePrefix == featurePrefix) &&
            (identical(other.outputDir, outputDir) ||
                other.outputDir == outputDir) &&
            (identical(other.stateManagement, stateManagement) ||
                other.stateManagement == stateManagement));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, featureName, featurePrefix, outputDir, stateManagement);

  @override
  String toString() {
    return 'CliFeatureGenConfig(featureName: $featureName, featurePrefix: $featurePrefix, outputDir: $outputDir, stateManagement: $stateManagement)';
  }
}

/// @nodoc
abstract mixin class _$CliFeatureGenConfigCopyWith<$Res>
    implements $CliFeatureGenConfigCopyWith<$Res> {
  factory _$CliFeatureGenConfigCopyWith(_CliFeatureGenConfig value,
          $Res Function(_CliFeatureGenConfig) _then) =
      __$CliFeatureGenConfigCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String featureName,
      String? featurePrefix,
      String? outputDir,
      String? stateManagement});
}

/// @nodoc
class __$CliFeatureGenConfigCopyWithImpl<$Res>
    implements _$CliFeatureGenConfigCopyWith<$Res> {
  __$CliFeatureGenConfigCopyWithImpl(this._self, this._then);

  final _CliFeatureGenConfig _self;
  final $Res Function(_CliFeatureGenConfig) _then;

  /// Create a copy of CliFeatureGenConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? featureName = null,
    Object? featurePrefix = freezed,
    Object? outputDir = freezed,
    Object? stateManagement = freezed,
  }) {
    return _then(_CliFeatureGenConfig(
      featureName: null == featureName
          ? _self.featureName
          : featureName // ignore: cast_nullable_to_non_nullable
              as String,
      featurePrefix: freezed == featurePrefix
          ? _self.featurePrefix
          : featurePrefix // ignore: cast_nullable_to_non_nullable
              as String?,
      outputDir: freezed == outputDir
          ? _self.outputDir
          : outputDir // ignore: cast_nullable_to_non_nullable
              as String?,
      stateManagement: freezed == stateManagement
          ? _self.stateManagement
          : stateManagement // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
