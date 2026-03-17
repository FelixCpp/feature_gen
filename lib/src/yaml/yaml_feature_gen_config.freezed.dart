// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'yaml_feature_gen_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$YamlFeatureGenConfig {
  String? get featurePrefix;
  String? get outputDir;
  String? get stateManagement;

  /// Create a copy of YamlFeatureGenConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $YamlFeatureGenConfigCopyWith<YamlFeatureGenConfig> get copyWith =>
      _$YamlFeatureGenConfigCopyWithImpl<YamlFeatureGenConfig>(
          this as YamlFeatureGenConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is YamlFeatureGenConfig &&
            (identical(other.featurePrefix, featurePrefix) ||
                other.featurePrefix == featurePrefix) &&
            (identical(other.outputDir, outputDir) ||
                other.outputDir == outputDir) &&
            (identical(other.stateManagement, stateManagement) ||
                other.stateManagement == stateManagement));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, featurePrefix, outputDir, stateManagement);

  @override
  String toString() {
    return 'YamlFeatureGenConfig(featurePrefix: $featurePrefix, outputDir: $outputDir, stateManagement: $stateManagement)';
  }
}

/// @nodoc
abstract mixin class $YamlFeatureGenConfigCopyWith<$Res> {
  factory $YamlFeatureGenConfigCopyWith(YamlFeatureGenConfig value,
          $Res Function(YamlFeatureGenConfig) _then) =
      _$YamlFeatureGenConfigCopyWithImpl;
  @useResult
  $Res call(
      {String? featurePrefix, String? outputDir, String? stateManagement});
}

/// @nodoc
class _$YamlFeatureGenConfigCopyWithImpl<$Res>
    implements $YamlFeatureGenConfigCopyWith<$Res> {
  _$YamlFeatureGenConfigCopyWithImpl(this._self, this._then);

  final YamlFeatureGenConfig _self;
  final $Res Function(YamlFeatureGenConfig) _then;

  /// Create a copy of YamlFeatureGenConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? featurePrefix = freezed,
    Object? outputDir = freezed,
    Object? stateManagement = freezed,
  }) {
    return _then(_self.copyWith(
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

/// Adds pattern-matching-related methods to [YamlFeatureGenConfig].
extension YamlFeatureGenConfigPatterns on YamlFeatureGenConfig {
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
    TResult Function(_YamlFeatureGenConfig value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _YamlFeatureGenConfig() when $default != null:
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
    TResult Function(_YamlFeatureGenConfig value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YamlFeatureGenConfig():
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
    TResult? Function(_YamlFeatureGenConfig value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YamlFeatureGenConfig() when $default != null:
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
    TResult Function(
            String? featurePrefix, String? outputDir, String? stateManagement)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _YamlFeatureGenConfig() when $default != null:
        return $default(
            _that.featurePrefix, _that.outputDir, _that.stateManagement);
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
    TResult Function(
            String? featurePrefix, String? outputDir, String? stateManagement)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YamlFeatureGenConfig():
        return $default(
            _that.featurePrefix, _that.outputDir, _that.stateManagement);
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
    TResult? Function(
            String? featurePrefix, String? outputDir, String? stateManagement)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YamlFeatureGenConfig() when $default != null:
        return $default(
            _that.featurePrefix, _that.outputDir, _that.stateManagement);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _YamlFeatureGenConfig implements YamlFeatureGenConfig {
  const _YamlFeatureGenConfig(
      {required this.featurePrefix,
      required this.outputDir,
      required this.stateManagement});

  @override
  final String? featurePrefix;
  @override
  final String? outputDir;
  @override
  final String? stateManagement;

  /// Create a copy of YamlFeatureGenConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$YamlFeatureGenConfigCopyWith<_YamlFeatureGenConfig> get copyWith =>
      __$YamlFeatureGenConfigCopyWithImpl<_YamlFeatureGenConfig>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _YamlFeatureGenConfig &&
            (identical(other.featurePrefix, featurePrefix) ||
                other.featurePrefix == featurePrefix) &&
            (identical(other.outputDir, outputDir) ||
                other.outputDir == outputDir) &&
            (identical(other.stateManagement, stateManagement) ||
                other.stateManagement == stateManagement));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, featurePrefix, outputDir, stateManagement);

  @override
  String toString() {
    return 'YamlFeatureGenConfig(featurePrefix: $featurePrefix, outputDir: $outputDir, stateManagement: $stateManagement)';
  }
}

/// @nodoc
abstract mixin class _$YamlFeatureGenConfigCopyWith<$Res>
    implements $YamlFeatureGenConfigCopyWith<$Res> {
  factory _$YamlFeatureGenConfigCopyWith(_YamlFeatureGenConfig value,
          $Res Function(_YamlFeatureGenConfig) _then) =
      __$YamlFeatureGenConfigCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? featurePrefix, String? outputDir, String? stateManagement});
}

/// @nodoc
class __$YamlFeatureGenConfigCopyWithImpl<$Res>
    implements _$YamlFeatureGenConfigCopyWith<$Res> {
  __$YamlFeatureGenConfigCopyWithImpl(this._self, this._then);

  final _YamlFeatureGenConfig _self;
  final $Res Function(_YamlFeatureGenConfig) _then;

  /// Create a copy of YamlFeatureGenConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? featurePrefix = freezed,
    Object? outputDir = freezed,
    Object? stateManagement = freezed,
  }) {
    return _then(_YamlFeatureGenConfig(
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
