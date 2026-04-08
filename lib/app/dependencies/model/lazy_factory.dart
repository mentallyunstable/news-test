typedef LazyFactory<T> = T Function();

/// Lazily creates a dependency once and returns the cached instance after that.
final class LazyDependency<T> {
  LazyDependency(LazyFactory<T> factory) : _factory = factory;

  final LazyFactory<T> _factory;

  T? _instance;
  bool _isInitialized = false;

  T get() {
    if (_isInitialized) {
      return _instance as T;
    }

    final instance = _factory();
    _instance = instance;
    _isInitialized = true;

    return instance;
  }
}
