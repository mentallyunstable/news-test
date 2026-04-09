import 'package:intl/intl.dart';
import 'package:news_test/features/news/data/model/news_article_item_model.dart';
import 'package:news_test/features/news/domain/entity/news_source_entity.dart';

final class NewsArticleItemEntity {
  final NewsSourceEntity source;
  final String? author;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final DateTime publishedAt;
  final String? content;

  const NewsArticleItemEntity({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory NewsArticleItemEntity.fromModel(final NewsArticleItemModel model) {
    return NewsArticleItemEntity(
      source: NewsSourceEntity.fromModel(model.source),
      author: model.author,
      title: model.title,
      description: model.description,
      url: model.url,
      urlToImage: model.urlToImage,
      publishedAt: model.publishedAt,
      content: model.content,
    );
  }

  String get id => _NewsArticleIdentity.create(url: url);

  String get titleText => title.trim();

  String get descriptionText => description?.trim() ?? 'No description';

  String get formattedDate => DateFormat.yMd(
    Intl.getCurrentLocale(),
  ).format(publishedAt.toLocal());

  String get contentText => content ?? 'Article content is empty';
}

/// Calculates article entity id
final class _NewsArticleIdentity {
  static const int _fnvOffsetBasis = 0xcbf29ce484222325;
  static const int _fnvPrime = 0x100000001b3;
  static const int _fnvMask = 0xffffffffffffffff;

  static String create({
    required final String url,
  }) {
    final normalizedUrl = _normalizeUrl(url);
    return _hashToHex(normalizedUrl);
  }

  static String _normalizeUrl(final String? value) {
    final raw = value?.trim() ?? '';
    if (raw.isEmpty) {
      return '';
    }

    final uri = Uri.tryParse(raw);
    if (uri == null) {
      return raw.toLowerCase();
    }

    final normalizedPath = uri.path.endsWith('/') && uri.path.length > 1
        ? uri.path.substring(0, uri.path.length - 1)
        : uri.path;

    return Uri(
      path: normalizedPath,
      host: uri.host.toLowerCase(),
      scheme: uri.scheme.toLowerCase(),
      port: uri.hasPort ? uri.port : null,
      query: uri.hasQuery ? uri.query : null,
    ).toString();
  }

  static String _hashToHex(final String value) {
    var hash = _fnvOffsetBasis;

    for (final codeUnit in value.codeUnits) {
      hash ^= codeUnit;
      hash = (hash * _fnvPrime) & _fnvMask;
    }

    return hash.toRadixString(16).padLeft(16, '0');
  }
}
