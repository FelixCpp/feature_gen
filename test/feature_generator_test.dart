import 'package:dart_feature_gen/src/config/feature_config.dart';
import 'package:dart_feature_gen/src/generators/feature_generator.dart';
import 'package:dart_feature_gen/src/process/process_runner.dart';
import 'package:file/file.dart';
import 'package:file/memory.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:test/test.dart';

class _FakeProcessRunner implements ProcessRunner {
  var buildRunnerCalled = false;
  var dartFormatCalled = false;

  @override
  Future<void> runBuildRunner(String featurePath) async {
    buildRunnerCalled = true;
  }

  @override
  Future<void> runDartFormat(String featurePath) async {
    dartFormatCalled = true;
  }
}

void main() {
  group(FeatureGenerator, () {
    late FileSystem fileSystem;
    late _FakeProcessRunner processRunner;
    late FeatureGenerator generator;

    setUp(() {
      fileSystem = MemoryFileSystem.test();
      processRunner = _FakeProcessRunner();
      generator = FeatureGenerator(
        logger: Logger(),
        fileSystem: fileSystem,
        processRunner: processRunner,
      );
    });

    test('should call dart format and build_runner after generating', () async {
      await generator.generate(
        config: FeatureGenConfig(
          featureName: 'auth',
          outputDirectory: 'features',
          featurePrefix: null,
          format: true,
          build: true,
          smLibrary: StateManagementLibrary.bloc,
        ),
      );

      expect(processRunner.dartFormatCalled, isTrue);
      expect(processRunner.buildRunnerCalled, isTrue);
    });

    test(
      'should not call dart format or build_runner after generating',
      () async {
        await generator.generate(
          config: FeatureGenConfig(
            featureName: 'auth',
            outputDirectory: 'features',
            featurePrefix: null,
            format: false,
            build: false,
            smLibrary: StateManagementLibrary.bloc,
          ),
        );

        expect(processRunner.dartFormatCalled, isFalse);
        expect(processRunner.buildRunnerCalled, isFalse);
      },
    );

    test('should call only build_runner after generating ', () async {
      await generator.generate(
        config: FeatureGenConfig(
          featureName: 'auth',
          outputDirectory: 'features',
          featurePrefix: null,
          format: false,
          build: true,
          smLibrary: StateManagementLibrary.bloc,
        ),
      );

      expect(processRunner.dartFormatCalled, isFalse);
      expect(processRunner.buildRunnerCalled, isTrue);
    });

    test('should call only dart format after generating ', () async {
      await generator.generate(
        config: FeatureGenConfig(
          featureName: 'auth',
          outputDirectory: 'features',
          featurePrefix: null,
          format: true,
          build: false,
          smLibrary: StateManagementLibrary.bloc,
        ),
      );

      expect(processRunner.dartFormatCalled, isTrue);
      expect(processRunner.buildRunnerCalled, isFalse);
    });
  });
}
