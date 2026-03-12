class DomainTemplates {
  static String _toPascalCase(String input) {
    return input.split('_').map((word) {
      return word[0].toUpperCase() + word.substring(1);
    }).join();
  }

  static String repository(String featureName) {
    final className = _toPascalCase(featureName);

    return '''
abstract interface class ${className}Repository {
  // TODO: Define repository contract
}
''';
  }
}
