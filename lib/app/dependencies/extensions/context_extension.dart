import 'package:flutter/material.dart';
import 'package:news_test/app/dependencies/model/dependencies_container.dart';
import 'package:news_test/app/dependencies/model/repository_dependencies.dart';
import 'package:news_test/app/dependencies/model/service_dependencies.dart';
import 'package:news_test/app/initialization/widget/dependencies_scope.dart';

/// Extensions for convenient access to app dependencies.
extension ContextExtension on BuildContext {
  DependenciesContainer get dependencies => DependenciesScope.of(this);
  RepositoryDependencies get repositories => dependencies.repositories;
  ServiceDependencies get services => dependencies.services;
}
