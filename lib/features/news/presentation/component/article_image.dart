import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

final class ArticleImage extends StatelessWidget {
  final String? imageUrl;
  final ImageWidgetBuilder? imageBuilder;

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

    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      imageBuilder: imageBuilder,
      placeholder: (_, _) => const _ArticleImageLoading(),
      errorWidget: (_, _, _) => const _ArticleImageFallback(icon: Icons.broken_image_outlined),
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
