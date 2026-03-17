enum FeatureConfigFields {
  featureNameKey('feature-name'),
  featurePrefixKey('feature-prefix'),
  outputDirectoryKey('output-directory'),
  stateManagementKey('state-management');

  const FeatureConfigFields(this.key);

  final String key;
}
