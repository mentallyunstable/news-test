import 'package:flutter/cupertino.dart';
import 'package:news_test/app/dependencies/model/dependencies_container.dart';

class DependenciesScope extends InheritedWidget {
  const DependenciesScope({
    super.key,
    required this.dependencies,
    required super.child,
  });

  final DependenciesContainer dependencies;

  static DependenciesContainer? maybeOf(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<DependenciesScope>()
      ?.dependencies;

  static DependenciesContainer of(BuildContext context) {
    final dependencies = maybeOf(context);

    if (dependencies == null) {
      throw ArgumentError(
        'Out of scope, not found inherited widget DependenciesScope '
            'of the exact type',
        'out_of_scope',
      );
    }

    return dependencies;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
