import 'package:flutter/cupertino.dart';
import 'package:news_test/app/dependencies/initializer/local_data_source_initializer.dart';
import 'package:news_test/app/dependencies/initializer/remote_data_source_initializer.dart';
import 'package:news_test/app/dependencies/initializer/repository_initializer.dart';
import 'package:news_test/app/dependencies/initializer/service_initializer.dart';
import 'package:news_test/app/dependencies/model/dependencies_container.dart';
import 'package:news_test/app/dependencies/model/local_data_source_dependencies.dart';
import 'package:news_test/app/dependencies/model/remote_data_source_dependencies.dart';
import 'package:news_test/app/dependencies/model/repository_dependencies.dart';
import 'package:news_test/app/dependencies/model/service_dependencies.dart';
import 'package:news_test/app/initialization/model/initialization_result.dart';
import 'package:news_test/core/utils/logger.dart';
import 'package:news_test/shared/router/app_router.dart';

final class InitializationProcessor implements IInitializationProcessor {
  const InitializationProcessor();

  @override
  Future<InitializationResult> initialize() async {
    final stopwatch = Stopwatch()..start();

    logger.info('Start initializing application...');
    logger.info('Initializing dependencies...');

    final dependencies = await _initDependencies();

    logger.info('Dependencies initialized successfully.');
    stopwatch.stop();

    return InitializationResult(
      dependencies: dependencies,
      msSpent: stopwatch.elapsedMilliseconds,
    );
  }

  Future<DependenciesContainer> _initDependencies() async {
    final rootNavigatorKey = GlobalKey<NavigatorState>();
    final shellNavigatorKey = GlobalKey<NavigatorState>();
    final router = AppRouter(
      rootNavigatorKey: rootNavigatorKey,
      shellNavigatorKey: shellNavigatorKey,
    );

    final services = await _initServices();
    final permanentDataSources = await _initPermanentDataSources(services);
    final remoteDataSources = _initRemoteDataSources(services);
    final repositories = _initRepositories(
      permanentDataSources,
      remoteDataSources,
    );

    return DependenciesContainerImpl(
      navigatorKey: rootNavigatorKey,
      router: router,
      services: services,
      localDataSources: permanentDataSources,
      remoteDataSources: remoteDataSources,
      repositories: repositories,
    );
  }

  Future<ServiceDependencies> _initServices() {
    final initializer = ServiceInitializerImpl();

    return initializer.initialize();
  }

  Future<LocalDataSourceDependencies> _initPermanentDataSources(
    ServiceDependencies services,
  ) {
    final initializer = LocalDataSourceInitializerImpl();

    return initializer.initialize(services: services);
  }

  RemoteDataSourceDependencies _initRemoteDataSources(ServiceDependencies services) {
    final initializer = RemoteDataSourceInitializerImpl();

    return initializer.initialize(services: services);
  }

  RepositoryDependencies _initRepositories(
    LocalDataSourceDependencies permanentDataSources,
    RemoteDataSourceDependencies remoteDataSources,
  ) {
    final initializer = RepositoryInitializerImpl();

    return initializer.initialize(
      permanentDataSources: permanentDataSources,
      remoteDataSources: remoteDataSources,
    );
  }
}

abstract interface class IInitializationProcessor {
  Future<InitializationResult> initialize();
}
