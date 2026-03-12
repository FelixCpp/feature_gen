class PresentationTemplates {
  static String _toPascalCase(String input) {
    return input.split('_').map((word) {
      return word[0].toUpperCase() + word.substring(1);
    }).join();
  }

  static String screen(String featureName) {
    final className = _toPascalCase(featureName);

    return '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/${featureName}_bloc.dart';

class ${className}Screen extends StatelessWidget {
  const ${className}Screen({super.key});

  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ${className}Bloc()..add(const ${className}Event.onSetup()),
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

  Widget build(BuildContext state) {
    return const Placeholder();
  }
}
''';
  }

  static String bloc(String featureName) {
    final className = _toPascalCase(featureName);

    return '''
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed/freezed.dart';

part '${featureName}_bloc.freezed.dart';
part '${featureName}_event.dart';
part '${featureName}_state.dart';

class ${className}Bloc extends Bloc<${className}Event, ${className}State> {
  ${className}Bloc() : super(${className}State.initial()) {
    on<_OnSetup>(_onSetup);
  }

  FutureOr<void> _onSetup(_OnSetup event, Emitter<${className}State> emit) {
    // TODO: Implement
  }
}
''';
  }

  static String event(String featureName) {
    final className = _toPascalCase(featureName);

    return '''
part of '${featureName}_bloc.dart';

@freezed
sealed class ${className}Event with _\$${className}Event {
  const factory ${className}Event.onSetup() = _OnSetup;
}
''';
  }

  static String state(String featureName) {
    final className = _toPascalCase(featureName);

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
}
