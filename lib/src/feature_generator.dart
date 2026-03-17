import 'package:dart_feature_gen/src/feature_gen_config.dart';
import 'package:mason_logger/mason_logger.dart';

class FeatureGenerator {
  const FeatureGenerator({required this.logger});

  final Logger logger;

  Future<void> generate(FeatureGenConfig config) async {
    print('Config: $config');
  }
}
