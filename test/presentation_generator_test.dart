import 'package:dart_feature_gen/src/feature_gen_config.dart';
import 'package:dart_feature_gen/src/generators/presentation_generator.dart';
import 'package:dart_feature_gen/src/io/feature_gen_io.dart';
import 'package:file/file.dart';
import 'package:file/memory.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

void main() {
  group(PresentationGenerator, () {
    late FileSystem fileSystem;
    late PresentationGenerator generator;

    setUp(() {
      fileSystem = MemoryFileSystem.test();

      final logger = Logger(level: Level.quiet);
      final io = FeatureGenIO(fileSystem: fileSystem, logger: logger);
      generator = PresentationGenerator(logger: logger, io: io);
    });

    test(
      'should generate directories and files with contents using bloc',
      () async {
        final config = FeatureGenConfig(
          featureName: 'auth',
          featurePrefix: null,
          outputDirectory: '',
          stateManagement: StateManagement.bloc,
          runCodeFormatter: true,
          runCodeGenerator: true,
        );

        await generator.generate(config);

        expect(
          fileSystem
              .file(path.join(
                'auth',
                'presentation',
                'bloc',
                'auth_event.dart',
              ))
              .readAsString(),
          completion(
            equals('''
part of 'auth_bloc.dart';

@freezed
sealed class AuthEvent with _\$AuthEvent {
  const factory AuthEvent.onSetup() = _OnSetup;
}
'''),
          ),
        );

        expect(
            fileSystem
                .file(path.join(
                  'auth',
                  'presentation',
                  'bloc',
                  'auth_state.dart',
                ))
                .readAsString(),
            completion(
              equals('''
part of 'auth_bloc.dart';

@freezed
sealed class AuthState with _\$AuthState {
  const factory AuthState() = _AuthState;

  factory AuthState.initial() {
    return const AuthState();
  }
}
'''),
            ));

        expect(
          fileSystem
              .file(path.join('auth', 'presentation', 'bloc', 'auth_bloc.dart'))
              .readAsString(),
          completion(
            equals('''
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
'''),
          ),
        );

        expect(
          fileSystem
              .file(path.join('auth', 'presentation', 'auth_screen.dart'))
              .readAsString(),
          completion(
            equals('''
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
'''),
          ),
        );
      },
    );

    test(
      'should generate directories and files with contents using cubit',
      () async {
        final config = FeatureGenConfig(
          featureName: 'auth',
          featurePrefix: null,
          outputDirectory: '',
          stateManagement: StateManagement.cubit,
          runCodeFormatter: true,
          runCodeGenerator: true,
        );

        await generator.generate(config);

        expect(
            fileSystem
                .file(path.join(
                  'auth',
                  'presentation',
                  'cubit',
                  'auth_state.dart',
                ))
                .readAsString(),
            completion(
              equals('''
part of 'auth_cubit.dart';

@freezed
sealed class AuthState with _\$AuthState {
  const factory AuthState() = _AuthState;

  factory AuthState.initial() {
    return const AuthState();
  }
}
'''),
            ));

        expect(
          fileSystem
              .file(
                  path.join('auth', 'presentation', 'cubit', 'auth_cubit.dart'))
              .readAsString(),
          completion(
            equals('''
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState.initial());
}
'''),
          ),
        );

        expect(
          fileSystem
              .file(path.join('auth', 'presentation', 'auth_screen.dart'))
              .readAsString(),
          completion(
            equals('''
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
'''),
          ),
        );
      },
    );

    test(
      'should generate directories and files with contents using riverpod',
      () async {
        final config = FeatureGenConfig(
          featureName: 'auth',
          featurePrefix: null,
          outputDirectory: '',
          stateManagement: StateManagement.riverpod,
          runCodeFormatter: true,
          runCodeGenerator: true,
        );

        await generator.generate(config);

        expect(
            fileSystem
                .file(path.join(
                  'auth',
                  'presentation',
                  'riverpod',
                  'auth_state.dart',
                ))
                .readAsString(),
            completion(
              equals('''
part of 'auth_notifier.dart';

@freezed
sealed class AuthState with _\$AuthState {
  const factory AuthState() = _AuthState;

  factory AuthState.initial() {
    return const AuthState();
  }
}
'''),
            ));

        expect(
          fileSystem
              .file(path.join(
                  'auth', 'presentation', 'riverpod', 'auth_notifier.dart'))
              .readAsString(),
          completion(
            equals('''
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
'''),
          ),
        );

        expect(
          fileSystem
              .file(path.join('auth', 'presentation', 'auth_screen.dart'))
              .readAsString(),
          completion(
            equals('''
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
'''),
          ),
        );
      },
    );
  });
}
