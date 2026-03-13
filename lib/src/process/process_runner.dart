abstract interface class ProcessRunner {
  Future<void> runBuildRunner(String featurePath);
  Future<void> runDartFormat(String featurePath);
}
