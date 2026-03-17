import 'package:dart_feature_gen/src/feature_gen_config.dart';
import 'package:dart_feature_gen/src/generators/data_generator.dart';
import 'package:dart_feature_gen/src/generators/domain_generator.dart';
import 'package:dart_feature_gen/src/generators/presentation_generator.dart';
import 'package:dart_feature_gen/src/io/feature_gen_io.dart';
import 'package:mason_logger/mason_logger.dart';

class FeatureGenerator {
  FeatureGenerator({
    required this.logger,
    required FeatureGenIO io,
  })  : dataGenerator = DataGenerator(logger: logger, io: io),
        domainGenerator = DomainGenerator(logger: logger, io: io),
        presentationGenerator = PresentationGenerator(logger: logger, io: io);

  final Logger logger;
  final DataGenerator dataGenerator;
  final DomainGenerator domainGenerator;
  final PresentationGenerator presentationGenerator;

  Future<void> generate(FeatureGenConfig config) async {
    await dataGenerator.generate(config);
    await domainGenerator.generate(config);
    await presentationGenerator.generate(config);
  }
}
