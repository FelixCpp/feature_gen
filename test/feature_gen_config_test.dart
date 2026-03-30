import 'package:dart_feature_gen/src/feature_gen_config.dart';
import 'package:dart_feature_gen/src/runners/runner_requirements.dart';
import 'package:test/test.dart';

void main() {
  group('getRequiredPackages', () {
    test('should contain freezed with build_runner', () {
      final config = FeatureGenConfig(
        featureName: 'name',
        featurePrefix: 'prefix',
        outputDirectory: 'libs/features',
        stateManagement: StateManagement.bloc,
        dataClassFormat: DataClassFormat.freezed,
        runCodeFormatter: true,
        runCodeGenerator: true,
      );

      final packages = config.getRequiredPackages();

      expect(
        packages,
        unorderedEquals({
          ExternalDependency.flutterBloc,
          ExternalDependency.freezed,
          ExternalDependency.freezedAnnotation,
          ExternalDependency.buildRunner
        }),
      );
    });
    test('should contain freezed without build_runner', () {
      final config = FeatureGenConfig(
        featureName: 'name',
        featurePrefix: 'prefix',
        outputDirectory: 'libs/features',
        stateManagement: StateManagement.bloc,
        dataClassFormat: DataClassFormat.freezed,
        runCodeFormatter: true,
        runCodeGenerator: false,
      );

      final packages = config.getRequiredPackages();

      expect(
        packages,
        unorderedEquals({
          ExternalDependency.flutterBloc,
          ExternalDependency.freezed,
          ExternalDependency.freezedAnnotation,
        }),
      );
    });
    test(
      'should not contain build_runner when no generation package is used',
      () {
        final config = FeatureGenConfig(
          featureName: 'name',
          featurePrefix: 'prefix',
          outputDirectory: 'libs/features',
          stateManagement: StateManagement.bloc,
          dataClassFormat: DataClassFormat.native,
          runCodeFormatter: true,
          runCodeGenerator: true,
        );

        final packages = config.getRequiredPackages();
        expect(
          packages,
          unorderedEquals({
            ExternalDependency.flutterBloc,
          }),
        );
      },
    );
    test(
      'should contain flutter_bloc dependency when using StateManagement.bloc',
      () {
        final config = FeatureGenConfig(
          featureName: 'name',
          featurePrefix: 'prefix',
          outputDirectory: 'libs/features',
          stateManagement: StateManagement.bloc,
          dataClassFormat: DataClassFormat.native,
          runCodeFormatter: true,
          runCodeGenerator: true,
        );

        final packages = config.getRequiredPackages();
        expect(packages, equals([ExternalDependency.flutterBloc]));
      },
    );
    test(
      'should contain flutter_bloc dependency when using StateManagement.cubit',
      () {
        final config = FeatureGenConfig(
          featureName: 'name',
          featurePrefix: 'prefix',
          outputDirectory: 'libs/features',
          stateManagement: StateManagement.cubit,
          dataClassFormat: DataClassFormat.native,
          runCodeFormatter: true,
          runCodeGenerator: true,
        );

        final packages = config.getRequiredPackages();
        expect(packages, equals([ExternalDependency.flutterBloc]));
      },
    );

    test(
      'should contain riverpod dependencies when using StateManagement.riverpod excluding build_runner',
      () {
        final config = FeatureGenConfig(
          featureName: 'name',
          featurePrefix: 'prefix',
          outputDirectory: 'libs/features',
          stateManagement: StateManagement.riverpod,
          dataClassFormat: DataClassFormat.native,
          runCodeFormatter: true,
          runCodeGenerator: false,
        );

        final packages = config.getRequiredPackages();
        expect(
          packages,
          unorderedEquals([
            ExternalDependency.riverpodAnnotation,
            ExternalDependency.flutterRiverpod,
            ExternalDependency.riverpodGenerator,
          ]),
        );
      },
    );

    test(
      'should contain riverpod dependencies when using StateManagement.riverpod including build_runner',
      () {
        final config = FeatureGenConfig(
          featureName: 'name',
          featurePrefix: 'prefix',
          outputDirectory: 'libs/features',
          stateManagement: StateManagement.riverpod,
          dataClassFormat: DataClassFormat.native,
          runCodeFormatter: true,
          runCodeGenerator: true,
        );

        final packages = config.getRequiredPackages();
        expect(
          packages,
          unorderedEquals([
            ExternalDependency.riverpodAnnotation,
            ExternalDependency.flutterRiverpod,
            ExternalDependency.riverpodGenerator,
            ExternalDependency.buildRunner,
          ]),
        );
      },
    );
  });
}
