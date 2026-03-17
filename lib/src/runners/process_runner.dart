import 'package:dart_feature_gen/src/feature_gen_config.dart';

abstract interface class ProcessRunner {
  Future<void> runBuildRunner(FeatureGenConfig config);
  Future<void> runDartFormat(FeatureGenConfig config);
}
