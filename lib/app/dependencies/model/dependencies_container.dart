import 'package:flutter/material.dart' show GlobalKey, NavigatorState;
import 'package:news_test/app/dependencies/model/local_data_source_dependencies.dart';
import 'package:news_test/app/dependencies/model/remote_data_source_dependencies.dart';
import 'package:news_test/app/dependencies/model/repository_dependencies.dart';
import 'package:news_test/app/dependencies/model/service_dependencies.dart';
import 'package:news_test/shared/router/app_router.dart';

/// Defines app dependency container.
abstract base class DependenciesContainer {
  const DependenciesContainer({
    required this.navigatorKey,
    required this.router,
    required this.localDataSources,
    required this.remoteDataSources,
    required this.repositories,
    required this.services,
  });

  final GlobalKey<NavigatorState> navigatorKey;
  final AppRouter router;
  final LocalDataSourceDependencies localDataSources;
  final RemoteDataSourceDependencies remoteDataSources;
  final RepositoryDependencies repositories;
  final ServiceDependencies services;
}

/// Main implementation of [DependenciesContainer].
final class DependenciesContainerImpl extends DependenciesContainer {
  const DependenciesContainerImpl({
    required super.navigatorKey,
    required super.router,
    required super.localDataSources,
    required super.remoteDataSources,
    required super.repositories,
    required super.services,
  });
}
