import 'package:flutter/material.dart';

/// Fallback app shown when initialization fails.
class InitializationFailedApp extends StatefulWidget {
  const InitializationFailedApp({
    super.key,
    required this.exception,
    required this.stackTrace,
    this.retryInitialization,
  });

  final Object exception;
  final StackTrace stackTrace;
  final Future<void> Function()? retryInitialization;

  @override
  State<InitializationFailedApp> createState() =>
      _InitializationFailedAppState();
}

class _InitializationFailedAppState extends State<InitializationFailedApp> {
  final _inProgress = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _inProgress.dispose();
    super.dispose();
  }

  Future<void> _retryInitialization() async {
    if (_inProgress.value || widget.retryInitialization == null) {
      return;
    }

    _inProgress.value = true;
    await widget.retryInitialization!();
    _inProgress.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Initialization failed',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    if (widget.retryInitialization != null)
                      ValueListenableBuilder<bool>(
                        valueListenable: _inProgress,
                        builder: (context, inProgress, _) {
                          return IconButton(
                            onPressed: inProgress ? null : _retryInitialization,
                            icon: inProgress
                                ? const SizedBox.square(
                                    dimension: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Icon(Icons.refresh),
                          );
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  '${widget.exception}',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '${widget.stackTrace}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
