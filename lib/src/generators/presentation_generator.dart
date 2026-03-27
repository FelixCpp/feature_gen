import 'package:dart_feature_gen/src/feature_gen_config.dart';
import 'package:dart_feature_gen/src/io/feature_gen_io.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart';
import 'package:recase/recase.dart';

class PresentationGenerator {
  const PresentationGenerator({required this.logger, required this.io});

  final Logger logger;
  final FeatureGenIO io;

  Future<void> generate(FeatureGenConfig config) async {
    final uiDirectory = join(config.featurePath, 'presentation');
    await io.createDirectory(uiDirectory);

    switch (config.stateManagement) {
      case StateManagement.bloc:
        await _generateBlocFiles(
          uiDirectory,
          config.featureName,
          config.dataClassFormat,
        );
      case StateManagement.cubit:
        await _generateCubitFiles(
          uiDirectory,
          config.featureName,
          config.dataClassFormat,
        );
      case StateManagement.riverpod:
        await _generateRiverpodFiles(
          uiDirectory,
          config.featureName,
          config.dataClassFormat,
        );
    }
  }

  Future<void> _generateBlocFiles(
    String directory,
    String featureName,
    DataClassFormat dataClassFormat,
  ) async {
    await io.createFile(
      join(directory, 'bloc', '${featureName}_bloc.dart'),
      _BlocTemplates.bloc(featureName, dataClassFormat),
    );
    await io.createFile(
      join(directory, 'bloc', '${featureName}_state.dart'),
      _BlocTemplates.state(featureName, dataClassFormat),
    );
    await io.createFile(
      join(directory, 'bloc', '${featureName}_event.dart'),
      _BlocTemplates.event(featureName, dataClassFormat),
    );
    await io.createFile(
      join(directory, '${featureName}_screen.dart'),
      _BlocTemplates.screen(featureName),
    );
  }

  Future<void> _generateCubitFiles(
    String directory,
    String featureName,
    DataClassFormat dataClassFormat,
  ) async {
    await io.createFile(
      join(directory, 'cubit', '${featureName}_cubit.dart'),
      _CubitTemplates.cubit(featureName, dataClassFormat),
    );
    await io.createFile(
      join(directory, 'cubit', '${featureName}_state.dart'),
      _CubitTemplates.state(featureName, dataClassFormat),
    );
    await io.createFile(
      join(directory, '${featureName}_screen.dart'),
      _CubitTemplates.screen(featureName),
    );
  }

  Future<void> _generateRiverpodFiles(
    String directory,
    String featureName,
    DataClassFormat dataClassFormat,
  ) async {
    await io.createFile(
      join(directory, 'riverpod', '${featureName}_notifier.dart'),
      _RiverpodTemplates.notifier(featureName, dataClassFormat),
    );
    await io.createFile(
      join(directory, 'riverpod', '${featureName}_state.dart'),
      _RiverpodTemplates.state(featureName, dataClassFormat),
    );
    await io.createFile(
      join(directory, '${featureName}_screen.dart'),
      _RiverpodTemplates.screen(featureName),
    );
  }
}

abstract final class _BlocTemplates {
  static String _stateFreezed(String featureName) {
    final className = featureName.pascalCase;

    return '''
part of '${featureName}_bloc.dart';

@freezed
sealed class ${className}State with _\$${className}State {
  const factory ${className}State() = _${className}State;

  factory ${className}State.initial() {
    return const ${className}State();
  }
}
''';
  }

  static String _stateNative(String featureName) {
    final className = featureName.pascalCase;

    return '''
part of '${featureName}_bloc.dart';

sealed class ${className}State {
  const factory ${className}State.initial() = _Initial;
}

class _Initial implements ${className}State {
  const _Initial();
}
''';
  }

  static String state(String featureName, DataClassFormat format) {
    return switch (format) {
      DataClassFormat.freezed => _stateFreezed(featureName),
      DataClassFormat.native => _stateNative(featureName),
    };
  }

  static String _eventFreezed(String featureName) {
    final className = featureName.pascalCase;

    return '''
part of '${featureName}_bloc.dart';

@freezed
sealed class ${className}Event with _\$${className}Event {
  const factory ${className}Event.onSetup() = _OnSetup;
}
''';
  }

  static String _eventNative(String featureName) {
    final className = featureName.pascalCase;

    return '''
part of '${featureName}_bloc.dart';

sealed class ${className}Event {
  const factory ${className}Event.onSetup() = _OnSetup;
}

class _OnSetup implements ${className}Event {
  const _OnSetup();
}
''';
  }

  static String event(String featureName, DataClassFormat format) {
    return switch (format) {
      DataClassFormat.freezed => _eventFreezed(featureName),
      DataClassFormat.native => _eventNative(featureName),
    };
  }

  static String _blocFreezed(String featureName) {
    final className = featureName.pascalCase;

    return '''
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '${featureName}_bloc.freezed.dart';
part '${featureName}_event.dart';
part '${featureName}_state.dart';

class ${className}Bloc extends Bloc<${className}Event, ${className}State> {
  ${className}Bloc() : super(${className}State.initial()) {
    on<_OnSetup>(_onSetup);
  }

  FutureOr<void> _onSetup(_OnSetup event, Emitter<${className}State> emit) {
    // TODO: Implement setup logic
  }
}
''';
  }

  static String _blocNative(String featureName) {
    final className = featureName.pascalCase;

    return '''
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

part '${featureName}_event.dart';
part '${featureName}_state.dart';

class ${className}Bloc extends Bloc<${className}Event, ${className}State> {
  ${className}Bloc() : super(${className}State.initial()) {
    on<_OnSetup>(_onSetup);
  }

  FutureOr<void> _onSetup(_OnSetup event, Emitter<${className}State> emit) {
    // TODO: Implement setup logic
  }
}
''';
  }

  static String bloc(String featureName, DataClassFormat format) {
    return switch (format) {
      DataClassFormat.freezed => _blocFreezed(featureName),
      DataClassFormat.native => _blocNative(featureName),
    };
  }

  static String screen(String featureName) {
    final className = featureName.pascalCase;

    return '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/${featureName}_bloc.dart';

class ${className}Screen extends StatelessWidget {
  const ${className}Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ${className}Bloc()..add(const ${className}Event.onSetup());
      },
      child: BlocBuilder<${className}Bloc, ${className}State>(
        builder: (context, state) {
          return _Scaffold(state: state);
        }
      ),
    );
  }
}

class _Scaffold extends StatelessWidget {
  const _Scaffold({required this.state});

  final ${className}State state;

  @override
  Widget build(BuildContext context) {
      return const Placeholder();
  }
}
''';
  }
}

abstract final class _CubitTemplates {
  static String _stateFreezed(String featureName) {
    final className = featureName.pascalCase;

    return '''
part of '${featureName}_cubit.dart';

@freezed
sealed class ${className}State with _\$${className}State {
  const factory ${className}State() = _${className}State;

  factory ${className}State.initial() {
    return const ${className}State();
  }
}
''';
  }

  static String _stateNative(String featureName) {
    final className = featureName.pascalCase;

    return '''
part of '${featureName}_cubit.dart';

sealed class ${className}State {
  const ${className}State();

  factory ${className}State.initial() = _${className}Initial;
}

class _${className}Initial implements ${className}State {
  const _${className}Initial();
}
''';
  }

  static String state(String featureName, DataClassFormat format) {
    return switch (format) {
      DataClassFormat.freezed => _stateFreezed(featureName),
      DataClassFormat.native => _stateNative(featureName),
    };
  }

  static String cubitFreezed(String featureName) {
    final className = featureName.pascalCase;

    return '''
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '${featureName}_cubit.freezed.dart';
part '${featureName}_state.dart';

class ${className}Cubit extends Cubit<${className}State> {
  ${className}Cubit() : super(${className}State.initial());
}
''';
  }

  static String _cubitNative(String featureName) {
    final className = featureName.pascalCase;

    return '''
import 'package:flutter_bloc/flutter_bloc.dart';

part '${featureName}_state.dart';

class ${className}Cubit extends Cubit<${className}State> {
  ${className}Cubit() : super(${className}State.initial());
}
''';
  }

  static String cubit(String featureName, DataClassFormat format) {
    return switch (format) {
      DataClassFormat.freezed => cubitFreezed(featureName),
      DataClassFormat.native => _cubitNative(featureName),
    };
  }

  static String screen(String featureName) {
    final className = featureName.pascalCase;

    return '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/${featureName}_cubit.dart';

class ${className}Screen extends StatelessWidget {
  const ${className}Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ${className}Cubit();
      },
      child: BlocBuilder<${className}Cubit, ${className}State>(
        builder: (context, state) {
          return _Scaffold(state: state);
        }
      ),
    );
  }
}

class _Scaffold extends StatelessWidget {
  const _Scaffold({required this.state});

  final ${className}State state;

  @override
  Widget build(BuildContext context) {
      return const Placeholder();
  }
}
''';
  }
}

abstract final class _RiverpodTemplates {
  static String _stateFreezed(String featureName) {
    final className = featureName.pascalCase;

    return '''
part of '${featureName}_notifier.dart';

@freezed
sealed class ${className}State with _\$${className}State {
  const factory ${className}State() = _${className}State;

  factory ${className}State.initial() {
    return const ${className}State();
  }
}
''';
  }

  static String _stateNative(String featureName) {
    final className = featureName.pascalCase;
    return '''
part of '${featureName}_notifier.dart';

sealed class ${className}State {
  const ${className}State();

  factory ${className}State.initial() = _${className}Initial;
}

class _${className}Initial implements ${className}State {
  const _${className}Initial();
}
''';
  }

  static String state(String featureName, DataClassFormat format) {
    return switch (format) {
      DataClassFormat.freezed => _stateFreezed(featureName),
      DataClassFormat.native => _stateNative(featureName),
    };
  }

  static String _notifierFreezed(String featureName) {
    final className = featureName.pascalCase;

    return '''
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '${featureName}_notifier.freezed.dart';
part '${featureName}_notifier.g.dart';
part '${featureName}_state.dart';

@riverpod
class ${className}Notifier extends _\$${className}Notifier {
  @override
  ${className}State build() {
    return ${className}State.initial();
  }
}
''';
  }

  static String _notifierNative(String featureName) {
    final className = featureName.pascalCase;

    return '''
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '${featureName}_notifier.g.dart';
part '${featureName}_state.dart';

@riverpod
class ${className}Notifier extends _\$${className}Notifier {
  @override
  ${className}State build() {
    return ${className}State.initial();
  }
}
''';
  }

  static String notifier(String featureName, DataClassFormat format) {
    return switch (format) {
      DataClassFormat.freezed => _notifierFreezed(featureName),
      DataClassFormat.native => _notifierNative(featureName),
    };
  }

  static String screen(String featureName) {
    final className = featureName.pascalCase;

    return '''
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'riverpod/${featureName}_notifier.dart';

class ${className}Screen extends ConsumerWidget {
  const ${className}Screen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(${featureName}Provider);

    ref.listen(${featureName}Provider, (previous, next) {
      // Optional: side effects
    });

    return _Scaffold(state: state);
  }
}

class _Scaffold extends StatelessWidget {
  const _Scaffold({required this.state});

  final ${className}State state;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
''';
  }
}
