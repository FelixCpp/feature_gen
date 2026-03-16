import 'package:dart_feature_gen/src/config/feature_config.dart';
import 'package:dart_feature_gen/src/generators/presentation_generator.dart';
import 'package:file/file.dart';
import 'package:test/test.dart';
import 'package:file/memory.dart';

void main() {
  group('$PresentationGenerator using Bloc', () {
    late FileSystem fileSystem;
    late PresentationGenerator generator;

    setUp(() {
      fileSystem = MemoryFileSystem.test();
      generator = PresentationGenerator(
        config: FeatureGenConfig(
          featureName: 'counter',
          outputDirectory: 'lib/features',
          featurePrefix: null,
          format: true,
          build: true,
          smLibrary: StateManagementLibrary.bloc,
        ),
        fileSystem: fileSystem,
      );
    });

    test('should generate presentation directory', () async {
      await generator.generate();

      expect(
        fileSystem
            .file('lib/features/counter/presentation/counter_screen.dart')
            .readAsString(),
        completion(
          equals(
            '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/counter_bloc.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc()..add(const CounterEvent.onSetup()),
      child: BlocBuilder<CounterBloc, CounterState>(
        builder: (context, state) {
          return _Scaffold(state: state);
        }
      ),
    );
  }
}

class _Scaffold extends StatelessWidget {
  const _Scaffold({required this.state});

  final CounterState state;

  @override
  Widget build(BuildContext state) {
    return const Placeholder();
  }
}
''',
          ),
        ),
      );

      expect(
        fileSystem
            .file('lib/features/counter/presentation/bloc/counter_bloc.dart')
            .readAsString(),
        completion(
          equals('''
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'counter_bloc.freezed.dart';
part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState.initial()) {
    on<_OnSetup>(_onSetup);
  }

  FutureOr<void> _onSetup(_OnSetup event, Emitter<CounterState> emit) {
    // TODO: Implement
  }
}
'''),
        ),
      );

      expect(
        fileSystem
            .file('lib/features/counter/presentation/bloc/counter_event.dart')
            .readAsString(),
        completion(
          equals('''
part of 'counter_bloc.dart';

@freezed
sealed class CounterEvent with _\$CounterEvent {
  const factory CounterEvent.onSetup() = _OnSetup;
}
'''),
        ),
      );

      expect(
        fileSystem
            .file('lib/features/counter/presentation/bloc/counter_state.dart')
            .readAsString(),
        completion(
          equals('''
part of 'counter_bloc.dart';

@freezed
sealed class CounterState with _\$CounterState {
  const factory CounterState() = _CounterState;

  factory CounterState.initial() {
    return const CounterState();
  }
}
'''),
        ),
      );
    });
  });

  group('$PresentationGenerator using Cubit', () {
    late FileSystem fileSystem;
    late PresentationGenerator generator;

    setUp(() {
      fileSystem = MemoryFileSystem.test();
      generator = PresentationGenerator(
        config: FeatureGenConfig(
          featureName: 'counter',
          outputDirectory: 'lib/features',
          featurePrefix: null,
          format: true,
          build: true,
          smLibrary: StateManagementLibrary.cubit,
        ),
        fileSystem: fileSystem,
      );
    });

    test('should generate presentation directory', () async {
      await generator.generate();

      expect(
        fileSystem
            .file('lib/features/counter/presentation/counter_screen.dart')
            .readAsString(),
        completion(
          equals(
            '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/counter_cubit.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: BlocBuilder<CounterCubit, CounterState>(
        builder: (context, state) {
          return _Scaffold(state: state);
        }
      ),
    );
  }
}

class _Scaffold extends StatelessWidget {
  const _Scaffold({required this.state});

  final CounterState state;

  @override
  Widget build(BuildContext state) {
    return const Placeholder();
  }
}
''',
          ),
        ),
      );

      expect(
        fileSystem
            .file('lib/features/counter/presentation/cubit/counter_cubit.dart')
            .readAsString(),
        completion(
          equals('''
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'counter_cubit.freezed.dart';
part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterState.initial());
}
'''),
        ),
      );

      expect(
        fileSystem
            .file('lib/features/counter/presentation/cubit/counter_state.dart')
            .readAsString(),
        completion(
          equals('''
part of 'counter_cubit.dart';

@freezed
sealed class CounterState with _\$CounterState {
  const factory CounterState() = _CounterState;

  factory CounterState.initial() {
    return const CounterState();
  }
}
'''),
        ),
      );
    });
  });
}
