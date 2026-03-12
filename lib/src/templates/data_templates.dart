class DataTemplates {
  static String _toPascalCase(String input) {
    return input.split('_').map((word) {
      return word[0].toUpperCase() + word.substring(1);
    }).join();
  }

  static String repositoryImpl(String featureName) {
    final className = _toPascalCase(featureName);

    return '''
import '../../domain/${featureName}_repository.dart';

class ${className}RepositoryImpl implements ${className}Repository {
  const ${className}RepositoryImpl();
}
''';
  }

  static String remoteDatasource(String featureName) {
    final className = _toPascalCase(featureName);
    return '''
abstract class ${className}RemoteDatasource {
  // TODO: Define datasource contract
}

class ${className}RemoteDatasourceImpl implements ${className}RemoteDatasource {
  // TODO: Implement datasource
}
''';
  }

  static String dao(String featureName) {
    final className = _toPascalCase(featureName);
    return '''
class ${className}Dao {
  // TODO: Implement DAO
}
''';
  }

  static String diModule(String featureName) {
    final className = _toPascalCase(featureName);
    return '''
// Dependency Injection for $className feature (data layer)
''';
  }
}
