import 'package:flutter/material.dart';
import 'package:news_test/app/initialization/model/initialization_result.dart';
import 'package:news_test/app/initialization/widget/dependencies_scope.dart';
import 'package:news_test/app/widget/app_bloc_provider.dart';
import 'package:news_test/app/widget/material_context.dart';

/// Application entry widget.
class AppWidget extends StatelessWidget {
  const AppWidget({super.key, required this.result});

  final InitializationResult result;

  @override
  Widget build(BuildContext context) {
    final dependencies = result.dependencies;

    return DependenciesScope(
      dependencies: dependencies,
      child: const AppBlocProvider(child: MaterialContext()),
    );
  }
}
