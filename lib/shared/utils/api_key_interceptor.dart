import 'package:dio/dio.dart';

/// An interceptor that adds an API key to the request query parameters.
final class ApiKeyInterceptor extends Interceptor {
  const ApiKeyInterceptor({required this.apiKey});

  final String apiKey;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final queryParameters = Map<String, dynamic>.from(options.queryParameters);

    if (apiKey.isNotEmpty && !queryParameters.containsKey('apiKey')) {
      queryParameters['apiKey'] = apiKey;
    }

    options.queryParameters = queryParameters;
    handler.next(options);
  }
}
