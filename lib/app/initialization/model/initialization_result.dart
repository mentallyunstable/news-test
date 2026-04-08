import 'package:news_test/app/dependencies/model/dependencies_container.dart';

final class InitializationResult {
  InitializationResult({required this.dependencies, required this.msSpent});

  final DependenciesContainer dependencies;
  final int msSpent;

  @override
  String toString() =>
      '$InitializationResult('
      'dependencies: $dependencies, '
      'msSpent: $msSpent'
      ')';
}
