import 'package:args/args.dart';

abstract final class FeatureConfigCliAdapter {
  Map loadFromCli(ArgResults cli) {
    return {};
  }
}
