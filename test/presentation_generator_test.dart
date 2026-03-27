import 'package:dart_feature_gen/src/feature_gen_config.dart';
import 'package:dart_feature_gen/src/generators/presentation_generator.dart';
import 'package:dart_feature_gen/src/io/feature_gen_io.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

import 'memory_file_system.dart';

void main() {
  group('Bloc generation', () {
    late FeatureGenIO io;
    late PresentationGenerator generator;

    setUp(() {
      final logger = Logger(level: Level.quiet);
      io = FeatureGenIO(fileSystem: getTestFileSystem(), logger: logger);
      generator = PresentationGenerator(logger: logger, io: io);
    });

    test('Should generate bloc state using freezed', () async {
      await generator.generate(FeatureGenConfig(
        featureName: 'auth',
        featurePrefix: null,
        outputDirectory: '',
        stateManagement: StateManagement.bloc,
        dataClassFormat: DataClassFormat.freezed,
        runCodeFormatter: true,
        runCodeGenerator: true,
      ));

      expect(
          io
              .getFile(path.join(
                'auth',
                'presentation',
                'bloc',
                'auth_state.dart',
              ))
              .readAsString(),
          completion(equals('''
part of 'auth_bloc.dart';

@freezed
sealed class AuthState with _\$AuthState {
  const factory AuthState() = _AuthState;

  factory AuthState.initial() {
    return const AuthState();
  }
}
''')));
    });

    test('Should generate bloc event using freezed', () async {
      await generator.generate(FeatureGenConfig(
        featureName: 'auth',
        featurePrefix: null,
        outputDirectory: '',
        stateManagement: StateManagement.bloc,
        dataClassFormat: DataClassFormat.freezed,
        runCodeFormatter: true,
        runCodeGenerator: true,
      ));

      expect(
          io
              .getFile(path.join(
                'auth',
                'presentation',
                'bloc',
                'auth_event.dart',
              ))
              .readAsString(),
          completion(equals('''
part of 'auth_bloc.dart';

@freezed
sealed class AuthEvent with _\$AuthEvent {
  const factory AuthEvent.onSetup() = _OnSetup;
}
''')));
    });

    test('Should generate bloc event using native', () async {
      await generator.generate(FeatureGenConfig(
        featureName: 'auth',
        featurePrefix: null,
        outputDirectory: '',
        stateManagement: StateManagement.bloc,
        dataClassFormat: DataClassFormat.native,
        runCodeFormatter: true,
        runCodeGenerator: true,
      ));

      expect(
          io
              .getFile(path.join(
                'auth',
                'presentation',
                'bloc',
                'auth_event.dart',
              ))
              .readAsString(),
          completion(equals('''
part of 'auth_bloc.dart';

sealed class AuthEvent {
  const factory AuthEvent.onSetup() = _OnSetup;
}

class _OnSetup implements AuthEvent {
  const _OnSetup();
}
''')));
    });

    test('Should generate bloc state using native', () async {
      await generator.generate(FeatureGenConfig(
        featureName: 'auth',
        featurePrefix: null,
        outputDirectory: '',
        stateManagement: StateManagement.bloc,
        dataClassFormat: DataClassFormat.native,
        runCodeFormatter: true,
        runCodeGenerator: true,
      ));

      expect(
          io
              .getFile(path.join(
                'auth',
                'presentation',
                'bloc',
                'auth_state.dart',
              ))
              .readAsString(),
          completion(equals('''
part of 'auth_bloc.dart';

sealed class AuthState {
  const factory AuthState.initial() = _Initial;
}

class _Initial implements AuthState {
  const _Initial();
}
''')));
    });

    test('should generate bloc using freezed', () async {
      await generator.generate(FeatureGenConfig(
        featureName: 'auth',
        featurePrefix: null,
        outputDirectory: '',
        stateManagement: StateManagement.bloc,
        dataClassFormat: DataClassFormat.freezed,
        runCodeFormatter: true,
        runCodeGenerator: true,
      ));

      expect(
          io
              .getFile(
                  path.join('auth', 'presentation', 'bloc', 'auth_bloc.dart'))
              .readAsString(),
          completion(equals('''
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState.initial()) {
    on<_OnSetup>(_onSetup);
  }

  FutureOr<void> _onSetup(_OnSetup event, Emitter<AuthState> emit) {
    // TODO: Implement setup logic
  }
}
''')));
    });

    test('should generate bloc using native data class format', () async {
      await generator.generate(FeatureGenConfig(
        featureName: 'auth',
        featurePrefix: null,
        outputDirectory: '',
        stateManagement: StateManagement.bloc,
        dataClassFormat: DataClassFormat.native,
        runCodeFormatter: true,
        runCodeGenerator: true,
      ));

      expect(
          io
              .getFile(
                  path.join('auth', 'presentation', 'bloc', 'auth_bloc.dart'))
              .readAsString(),
          completion(equals('''
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState.initial()) {
    on<_OnSetup>(_onSetup);
  }

  FutureOr<void> _onSetup(_OnSetup event, Emitter<AuthState> emit) {
    // TODO: Implement setup logic
  }
}
''')));
    });

    test('should generate bloc screen', () async {
      await generator.generate(FeatureGenConfig(
        featureName: 'auth',
        featurePrefix: null,
        outputDirectory: '',
        stateManagement: StateManagement.bloc,
        dataClassFormat: DataClassFormat.freezed,
        runCodeFormatter: true,
        runCodeGenerator: true,
      ));

      expect(
          io
              .getFile(path.join('auth', 'presentation', 'auth_screen.dart'))
              .readAsString(),
          completion(equals('''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/auth_bloc.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return AuthBloc()..add(const AuthEvent.onSetup());
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return _Scaffold(state: state);
        }
      ),
    );
  }
}

class _Scaffold extends StatelessWidget {
  const _Scaffold({required this.state});

  final AuthState state;

  @override
  Widget build(BuildContext context) {
      return const Placeholder();
  }
}
''')));
    });
  });

  group('Cubit generation', () {
    late FeatureGenIO io;
    late PresentationGenerator generator;

    setUp(() {
      final logger = Logger(level: Level.quiet);
      io = FeatureGenIO(fileSystem: getTestFileSystem(), logger: logger);
      generator = PresentationGenerator(logger: logger, io: io);
    });

    test('Should generate cubit state using freezed', () async {
      await generator.generate(FeatureGenConfig(
        featureName: 'auth',
        featurePrefix: null,
        outputDirectory: '',
        stateManagement: StateManagement.cubit,
        dataClassFormat: DataClassFormat.freezed,
        runCodeFormatter: true,
        runCodeGenerator: true,
      ));

      expect(
          io
              .getFile(path.join(
                'auth',
                'presentation',
                'cubit',
                'auth_state.dart',
              ))
              .readAsString(),
          completion(equals('''
part of 'auth_cubit.dart';

@freezed
sealed class AuthState with _\$AuthState {
  const factory AuthState() = _AuthState;

  factory AuthState.initial() {
    return const AuthState();
  }
}
''')));
    });

    test('Should generate cubit state using native', () async {
      await generator.generate(FeatureGenConfig(
        featureName: 'auth',
        featurePrefix: null,
        outputDirectory: '',
        stateManagement: StateManagement.cubit,
        dataClassFormat: DataClassFormat.native,
        runCodeFormatter: true,
        runCodeGenerator: true,
      ));

      expect(
          io
              .getFile(path.join(
                'auth',
                'presentation',
                'cubit',
                'auth_state.dart',
              ))
              .readAsString(),
          completion(equals('''
part of 'auth_cubit.dart';

sealed class AuthState {
  const AuthState();

  factory AuthState.initial() = _AuthInitial;
}

class _AuthInitial implements AuthState {
  const _AuthInitial();
}
''')));
    });

    test('Should generate cubit using freezed', () async {
      await generator.generate(FeatureGenConfig(
        featureName: 'auth',
        featurePrefix: null,
        outputDirectory: '',
        stateManagement: StateManagement.cubit,
        dataClassFormat: DataClassFormat.freezed,
        runCodeFormatter: true,
        runCodeGenerator: true,
      ));

      expect(
          io
              .getFile(path.join(
                'auth',
                'presentation',
                'cubit',
                'auth_cubit.dart',
              ))
              .readAsString(),
          completion(equals('''
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState.initial());
}
''')));
    });

    test('Should generate cubit using native data class format', () async {
      await generator.generate(FeatureGenConfig(
        featureName: 'auth',
        featurePrefix: null,
        outputDirectory: '',
        stateManagement: StateManagement.cubit,
        dataClassFormat: DataClassFormat.native,
        runCodeFormatter: true,
        runCodeGenerator: true,
      ));

      expect(
          io
              .getFile(path.join(
                'auth',
                'presentation',
                'cubit',
                'auth_cubit.dart',
              ))
              .readAsString(),
          completion(equals('''
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState.initial());
}
''')));
    });

    test('Should generate cubit screen', () async {
      await generator.generate(FeatureGenConfig(
        featureName: 'auth',
        featurePrefix: null,
        outputDirectory: '',
        stateManagement: StateManagement.cubit,
        dataClassFormat: DataClassFormat.freezed,
        runCodeFormatter: true,
        runCodeGenerator: true,
      ));

      expect(
          io
              .getFile(path.join('auth', 'presentation', 'auth_screen.dart'))
              .readAsString(),
          completion(equals('''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/auth_cubit.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return AuthCubit();
      },
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return _Scaffold(state: state);
        }
      ),
    );
  }
}

class _Scaffold extends StatelessWidget {
  const _Scaffold({required this.state});

  final AuthState state;

  @override
  Widget build(BuildContext context) {
      return const Placeholder();
  }
}
''')));
    });
  });

  group('Riverpod generation', () {
    late FeatureGenIO io;
    late PresentationGenerator generator;

    setUp(() {
      final logger = Logger(level: Level.quiet);
      io = FeatureGenIO(fileSystem: getTestFileSystem(), logger: logger);
      generator = PresentationGenerator(logger: logger, io: io);
    });

    test('Should generate riverpod notifier using freezed', () async {
      await generator.generate(FeatureGenConfig(
        featureName: 'auth',
        featurePrefix: null,
        outputDirectory: '',
        stateManagement: StateManagement.riverpod,
        dataClassFormat: DataClassFormat.freezed,
        runCodeFormatter: true,
        runCodeGenerator: true,
      ));

      expect(
          io
              .getFile(path.join(
                'auth',
                'presentation',
                'riverpod',
                'auth_notifier.dart',
              ))
              .readAsString(),
          completion(equals('''
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_notifier.freezed.dart';
part 'auth_notifier.g.dart';
part 'auth_state.dart';

@riverpod
class AuthNotifier extends _\$AuthNotifier {
  @override
  AuthState build() {
    return AuthState.initial();
  }
}
''')));
    });

    test('Should generate riverpod notifier using native data class format',
        () async {
      await generator.generate(FeatureGenConfig(
        featureName: 'auth',
        featurePrefix: null,
        outputDirectory: '',
        stateManagement: StateManagement.riverpod,
        dataClassFormat: DataClassFormat.native,
        runCodeFormatter: true,
        runCodeGenerator: true,
      ));

      expect(
          io
              .getFile(path.join(
                'auth',
                'presentation',
                'riverpod',
                'auth_notifier.dart',
              ))
              .readAsString(),
          completion(equals('''
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_notifier.g.dart';
part 'auth_state.dart';

@riverpod
class AuthNotifier extends _\$AuthNotifier {
  @override
  AuthState build() {
    return AuthState.initial();
  }
}
''')));
    });

    test('Should generate riverpod state using native', () async {
      await generator.generate(FeatureGenConfig(
        featureName: 'auth',
        featurePrefix: null,
        outputDirectory: '',
        stateManagement: StateManagement.riverpod,
        dataClassFormat: DataClassFormat.native,
        runCodeFormatter: true,
        runCodeGenerator: true,
      ));

      expect(
          io
              .getFile(path.join(
                'auth',
                'presentation',
                'riverpod',
                'auth_state.dart',
              ))
              .readAsString(),
          completion(equals('''
part of 'auth_notifier.dart';

sealed class AuthState {
  const AuthState();

  factory AuthState.initial() = _AuthInitial;
}

class _AuthInitial implements AuthState {
  const _AuthInitial();
}
''')));
    });

    test('Should generate riverpod state using freezed', () async {
      await generator.generate(FeatureGenConfig(
        featureName: 'auth',
        featurePrefix: null,
        outputDirectory: '',
        stateManagement: StateManagement.riverpod,
        dataClassFormat: DataClassFormat.freezed,
        runCodeFormatter: true,
        runCodeGenerator: true,
      ));

      expect(
          io
              .getFile(path.join(
                'auth',
                'presentation',
                'riverpod',
                'auth_state.dart',
              ))
              .readAsString(),
          completion(equals('''
part of 'auth_notifier.dart';

@freezed
sealed class AuthState with _\$AuthState {
  const factory AuthState() = _AuthState;

  factory AuthState.initial() {
    return const AuthState();
  }
}
''')));
    });

    test('Should generate riverpod screen', () async {
      await generator.generate(FeatureGenConfig(
        featureName: 'auth',
        featurePrefix: null,
        outputDirectory: '',
        stateManagement: StateManagement.riverpod,
        dataClassFormat: DataClassFormat.freezed,
        runCodeFormatter: true,
        runCodeGenerator: true,
      ));

      expect(
          io
              .getFile(path.join('auth', 'presentation', 'auth_screen.dart'))
              .readAsString(),
          completion(equals('''
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'riverpod/auth_notifier.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authProvider);

    ref.listen(authProvider, (previous, next) {
      // Optional: side effects
    });

    return _Scaffold(state: state);
  }
}

class _Scaffold extends StatelessWidget {
  const _Scaffold({required this.state});

  final AuthState state;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
''')));
    });
  });
}
