// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feature_gen_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeatureGenConfig {
  String get featureName;
  String? get featurePrefix;
  String get outputDirectory;
  StateManagement get stateManagement;

  /// Create a copy of FeatureGenConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FeatureGenConfigCopyWith<FeatureGenConfig> get copyWith =>
      _$FeatureGenConfigCopyWithImpl<FeatureGenConfig>(
          this as FeatureGenConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FeatureGenConfig &&
            (identical(other.featureName, featureName) ||
                other.featureName == featureName) &&
            (identical(other.featurePrefix, featurePrefix) ||
                other.featurePrefix == featurePrefix) &&
            (identical(other.outputDirectory, outputDirectory) ||
                other.outputDirectory == outputDirectory) &&
            (identical(other.stateManagement, stateManagement) ||
                other.stateManagement == stateManagement));
  }

  @override
  int get hashCode => Object.hash(runtimeType, featureName, featurePrefix,
      outputDirectory, stateManagement);

  @override
  String toString() {
    return 'FeatureGenConfig(featureName: $featureName, featurePrefix: $featurePrefix, outputDirectory: $outputDirectory, stateManagement: $stateManagement)';
  }
}

/// @nodoc
abstract mixin class $FeatureGenConfigCopyWith<$Res> {
  factory $FeatureGenConfigCopyWith(
          FeatureGenConfig value, $Res Function(FeatureGenConfig) _then) =
      _$FeatureGenConfigCopyWithImpl;
  @useResult
  $Res call(
      {String featureName,
      String? featurePrefix,
      String outputDirectory,
      StateManagement stateManagement});
}

/// @nodoc
class _$FeatureGenConfigCopyWithImpl<$Res>
    implements $FeatureGenConfigCopyWith<$Res> {
  _$FeatureGenConfigCopyWithImpl(this._self, this._then);

  final FeatureGenConfig _self;
  final $Res Function(FeatureGenConfig) _then;

  /// Create a copy of FeatureGenConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? featureName = null,
    Object? featurePrefix = freezed,
    Object? outputDirectory = null,
    Object? stateManagement = null,
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
      outputDirectory: null == outputDirectory
          ? _self.outputDirectory
          : outputDirectory // ignore: cast_nullable_to_non_nullable
              as String,
      stateManagement: null == stateManagement
          ? _self.stateManagement
          : stateManagement // ignore: cast_nullable_to_non_nullable
              as StateManagement,
    ));
  }
}

/// Adds pattern-matching-related methods to [FeatureGenConfig].
extension FeatureGenConfigPatterns on FeatureGenConfig {
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
    TResult Function(_FeatureGenConfig value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FeatureGenConfig() when $default != null:
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
    TResult Function(_FeatureGenConfig value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FeatureGenConfig():
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
    TResult? Function(_FeatureGenConfig value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FeatureGenConfig() when $default != null:
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
            String outputDirectory, StateManagement stateManagement)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FeatureGenConfig() when $default != null:
        return $default(_that.featureName, _that.featurePrefix,
            _that.outputDirectory, _that.stateManagement);
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
            String outputDirectory, StateManagement stateManagement)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FeatureGenConfig():
        return $default(_that.featureName, _that.featurePrefix,
            _that.outputDirectory, _that.stateManagement);
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
            String outputDirectory, StateManagement stateManagement)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FeatureGenConfig() when $default != null:
        return $default(_that.featureName, _that.featurePrefix,
            _that.outputDirectory, _that.stateManagement);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _FeatureGenConfig implements FeatureGenConfig {
  const _FeatureGenConfig(
      {required this.featureName,
      required this.featurePrefix,
      required this.outputDirectory,
      required this.stateManagement});

  @override
  final String featureName;
  @override
  final String? featurePrefix;
  @override
  final String outputDirectory;
  @override
  final StateManagement stateManagement;

  /// Create a copy of FeatureGenConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FeatureGenConfigCopyWith<_FeatureGenConfig> get copyWith =>
      __$FeatureGenConfigCopyWithImpl<_FeatureGenConfig>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FeatureGenConfig &&
            (identical(other.featureName, featureName) ||
                other.featureName == featureName) &&
            (identical(other.featurePrefix, featurePrefix) ||
                other.featurePrefix == featurePrefix) &&
            (identical(other.outputDirectory, outputDirectory) ||
                other.outputDirectory == outputDirectory) &&
            (identical(other.stateManagement, stateManagement) ||
                other.stateManagement == stateManagement));
  }

  @override
  int get hashCode => Object.hash(runtimeType, featureName, featurePrefix,
      outputDirectory, stateManagement);

  @override
  String toString() {
    return 'FeatureGenConfig(featureName: $featureName, featurePrefix: $featurePrefix, outputDirectory: $outputDirectory, stateManagement: $stateManagement)';
  }
}

/// @nodoc
abstract mixin class _$FeatureGenConfigCopyWith<$Res>
    implements $FeatureGenConfigCopyWith<$Res> {
  factory _$FeatureGenConfigCopyWith(
          _FeatureGenConfig value, $Res Function(_FeatureGenConfig) _then) =
      __$FeatureGenConfigCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String featureName,
      String? featurePrefix,
      String outputDirectory,
      StateManagement stateManagement});
}

/// @nodoc
class __$FeatureGenConfigCopyWithImpl<$Res>
    implements _$FeatureGenConfigCopyWith<$Res> {
  __$FeatureGenConfigCopyWithImpl(this._self, this._then);

  final _FeatureGenConfig _self;
  final $Res Function(_FeatureGenConfig) _then;

  /// Create a copy of FeatureGenConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? featureName = null,
    Object? featurePrefix = freezed,
    Object? outputDirectory = null,
    Object? stateManagement = null,
  }) {
    return _then(_FeatureGenConfig(
      featureName: null == featureName
          ? _self.featureName
          : featureName // ignore: cast_nullable_to_non_nullable
              as String,
      featurePrefix: freezed == featurePrefix
          ? _self.featurePrefix
          : featurePrefix // ignore: cast_nullable_to_non_nullable
              as String?,
      outputDirectory: null == outputDirectory
          ? _self.outputDirectory
          : outputDirectory // ignore: cast_nullable_to_non_nullable
              as String,
      stateManagement: null == stateManagement
          ? _self.stateManagement
          : stateManagement // ignore: cast_nullable_to_non_nullable
              as StateManagement,
    ));
  }
}

/// @nodoc
mixin _$RawFeatureGenConfig {
  String? get featureName;
  String? get featurePrefix;
  String? get outputDir;
  String? get stateManagement;

  /// Create a copy of RawFeatureGenConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RawFeatureGenConfigCopyWith<RawFeatureGenConfig> get copyWith =>
      _$RawFeatureGenConfigCopyWithImpl<RawFeatureGenConfig>(
          this as RawFeatureGenConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RawFeatureGenConfig &&
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
    return 'RawFeatureGenConfig(featureName: $featureName, featurePrefix: $featurePrefix, outputDir: $outputDir, stateManagement: $stateManagement)';
  }
}

/// @nodoc
abstract mixin class $RawFeatureGenConfigCopyWith<$Res> {
  factory $RawFeatureGenConfigCopyWith(
          RawFeatureGenConfig value, $Res Function(RawFeatureGenConfig) _then) =
      _$RawFeatureGenConfigCopyWithImpl;
  @useResult
  $Res call(
      {String? featureName,
      String? featurePrefix,
      String? outputDir,
      String? stateManagement});
}

/// @nodoc
class _$RawFeatureGenConfigCopyWithImpl<$Res>
    implements $RawFeatureGenConfigCopyWith<$Res> {
  _$RawFeatureGenConfigCopyWithImpl(this._self, this._then);

  final RawFeatureGenConfig _self;
  final $Res Function(RawFeatureGenConfig) _then;

  /// Create a copy of RawFeatureGenConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? featureName = freezed,
    Object? featurePrefix = freezed,
    Object? outputDir = freezed,
    Object? stateManagement = freezed,
  }) {
    return _then(_self.copyWith(
      featureName: freezed == featureName
          ? _self.featureName
          : featureName // ignore: cast_nullable_to_non_nullable
              as String?,
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

/// Adds pattern-matching-related methods to [RawFeatureGenConfig].
extension RawFeatureGenConfigPatterns on RawFeatureGenConfig {
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
    TResult Function(_RawFeatureGenConfig value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RawFeatureGenConfig() when $default != null:
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
    TResult Function(_RawFeatureGenConfig value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RawFeatureGenConfig():
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
    TResult? Function(_RawFeatureGenConfig value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RawFeatureGenConfig() when $default != null:
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
    TResult Function(String? featureName, String? featurePrefix,
            String? outputDir, String? stateManagement)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RawFeatureGenConfig() when $default != null:
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
    TResult Function(String? featureName, String? featurePrefix,
            String? outputDir, String? stateManagement)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RawFeatureGenConfig():
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
    TResult? Function(String? featureName, String? featurePrefix,
            String? outputDir, String? stateManagement)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RawFeatureGenConfig() when $default != null:
        return $default(_that.featureName, _that.featurePrefix, _that.outputDir,
            _that.stateManagement);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _RawFeatureGenConfig implements RawFeatureGenConfig {
  const _RawFeatureGenConfig(
      {required this.featureName,
      required this.featurePrefix,
      required this.outputDir,
      required this.stateManagement});

  @override
  final String? featureName;
  @override
  final String? featurePrefix;
  @override
  final String? outputDir;
  @override
  final String? stateManagement;

  /// Create a copy of RawFeatureGenConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RawFeatureGenConfigCopyWith<_RawFeatureGenConfig> get copyWith =>
      __$RawFeatureGenConfigCopyWithImpl<_RawFeatureGenConfig>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RawFeatureGenConfig &&
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
    return 'RawFeatureGenConfig(featureName: $featureName, featurePrefix: $featurePrefix, outputDir: $outputDir, stateManagement: $stateManagement)';
  }
}

/// @nodoc
abstract mixin class _$RawFeatureGenConfigCopyWith<$Res>
    implements $RawFeatureGenConfigCopyWith<$Res> {
  factory _$RawFeatureGenConfigCopyWith(_RawFeatureGenConfig value,
          $Res Function(_RawFeatureGenConfig) _then) =
      __$RawFeatureGenConfigCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? featureName,
      String? featurePrefix,
      String? outputDir,
      String? stateManagement});
}

/// @nodoc
class __$RawFeatureGenConfigCopyWithImpl<$Res>
    implements _$RawFeatureGenConfigCopyWith<$Res> {
  __$RawFeatureGenConfigCopyWithImpl(this._self, this._then);

  final _RawFeatureGenConfig _self;
  final $Res Function(_RawFeatureGenConfig) _then;

  /// Create a copy of RawFeatureGenConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? featureName = freezed,
    Object? featurePrefix = freezed,
    Object? outputDir = freezed,
    Object? stateManagement = freezed,
  }) {
    return _then(_RawFeatureGenConfig(
      featureName: freezed == featureName
          ? _self.featureName
          : featureName // ignore: cast_nullable_to_non_nullable
              as String?,
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
