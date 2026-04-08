import 'package:flutter/cupertino.dart';
import 'package:news_test/app/constant/app_config.dart';
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
import 'package:news_test/shared/router/app_router.dart';
import 'package:news_test/shared/utils/logger.dart';

/// Main application initialization processor.
final class InitializationProcessor implements IInitializationProcessor {
  final AppConfig config;

  const InitializationProcessor({required this.config});

  @override
  Future<InitializationResult> initialize() async {
    final stopwatch = Stopwatch()..start();

    logger.info('Start initializing application...');
    logger.info('Initializing dependencies...');

    final dependencies = await _initDependencies(config);

    logger.info('Dependencies initialized successfully.');
    stopwatch.stop();

    return InitializationResult(
      dependencies: dependencies,
      msSpent: stopwatch.elapsedMilliseconds,
    );
  }

  /// Initializes application dependencies.
  Future<DependenciesContainer> _initDependencies(final AppConfig config) async {
    final rootNavigatorKey = GlobalKey<NavigatorState>();
    final shellNavigatorKey = GlobalKey<NavigatorState>();
    final router = AppRouter(
      rootNavigatorKey: rootNavigatorKey,
      shellNavigatorKey: shellNavigatorKey,
    );

    final services = await _initServices(config);
    final permanentDataSources = await _initPermanentDataSources(services);
    final remoteDataSources = _initRemoteDataSources(services);
    final repositories = _initRepositories(
      permanentDataSources: permanentDataSources,
      remoteDataSources: remoteDataSources,
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

  /// Initializes services.
  Future<ServiceDependencies> _initServices(final AppConfig config) {
    final initializer = ServiceInitializerImpl();

    return initializer.initialize(config);
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

  RepositoryDependencies _initRepositories({
    required final LocalDataSourceDependencies permanentDataSources,
    required final RemoteDataSourceDependencies remoteDataSources,
  }) {
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
