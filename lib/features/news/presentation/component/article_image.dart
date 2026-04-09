import 'package:flutter/material.dart';
import 'package:news_test/shared/utils/logger.dart';

typedef ArticleImageBuilder =
    Widget Function(
      BuildContext context,
      ImageProvider imageProvider,
    );

final class ArticleImage extends StatelessWidget {
  final String? imageUrl;
  final ArticleImageBuilder? imageBuilder;

  const ArticleImage({
    super.key,
    required this.imageUrl,
    this.imageBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final url = imageUrl?.trim();

    if (url == null || url.isEmpty) {
      return const _ArticleImageFallback(icon: Icons.image_not_supported_outlined);
    }

    final imageProvider = NetworkImage(url);

    return Image(
      image: imageProvider,
      fit: BoxFit.cover,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (!wasSynchronouslyLoaded && frame == null) {
          return const _ArticleImageLoading();
        }

        return imageBuilder?.call(context, imageProvider) ?? child;
      },
      errorBuilder: (_, error, stackTrace) {
        logger.error(
          'Article image load failed',
          exception: '$url\n$error',
          stackTrace: stackTrace,
        );

        return const _ArticleImageFallback(icon: Icons.broken_image_outlined);
      },
    );
  }
}

final class _ArticleImageLoading extends StatelessWidget {
  const _ArticleImageLoading();

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.surfaceContainerHighest,
            colorScheme.surface,
          ],
        ),
      ),
      child: const Center(
        child: SizedBox.square(
          dimension: 22,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

final class _ArticleImageFallback extends StatelessWidget {
  final IconData icon;

  const _ArticleImageFallback({required this.icon});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.surfaceContainerHighest,
            colorScheme.surface,
          ],
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 28,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
