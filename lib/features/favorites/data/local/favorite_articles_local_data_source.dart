import 'package:news_test/features/favorites/data/local/favorite_articles_db_migration.dart';
import 'package:news_test/features/news/domain/entity/news_article_item_entity.dart';
import 'package:news_test/features/news/domain/entity/news_source_entity.dart';
import 'package:news_test/shared/data/local/db_service.dart';
import 'package:sqflite/sqflite.dart';

abstract base class FavoriteArticlesLocalDataSource {
  const FavoriteArticlesLocalDataSource();

  Future<void> saveArticle(NewsArticleItemEntity article);

  Future<List<NewsArticleItemEntity>> getArticles();

  Future<void> removeArticle(String articleId);
}

final class FavoriteArticlesLocalDataSourceImpl extends FavoriteArticlesLocalDataSource {
  FavoriteArticlesLocalDataSourceImpl({
    required DbService dbService,
  }) : _dbService = dbService;

  final DbService _dbService;

  @override
  Future<List<NewsArticleItemEntity>> getArticles() async {
    final database = await _dbService.database();
    final records = await database.query(
      FavoriteArticlesDbMigration.favoritesTable,
      orderBy: '${FavoriteArticlesDbMigration.savedAtColumn} DESC',
    );

    return records.map(_articleFromDbMap).toList();
  }

  @override
  Future<void> removeArticle(final String articleId) async {
    final database = await _dbService.database();

    await database.delete(
      FavoriteArticlesDbMigration.favoritesTable,
      where: '${FavoriteArticlesDbMigration.articleIdColumn} = ?',
      whereArgs: [articleId],
    );
  }

  @override
  Future<void> saveArticle(final NewsArticleItemEntity article) async {
    final database = await _dbService.database();

    await database.insert(
      FavoriteArticlesDbMigration.favoritesTable,
      _favoriteArticleMap(article),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Map<String, Object?> _favoriteArticleMap(final NewsArticleItemEntity article) {
    return {
      FavoriteArticlesDbMigration.articleIdColumn: article.id,
      FavoriteArticlesDbMigration.sourceIdColumn: article.source.id,
      FavoriteArticlesDbMigration.sourceNameColumn: article.source.name,
      FavoriteArticlesDbMigration.authorColumn: article.author,
      FavoriteArticlesDbMigration.titleColumn: article.title,
      FavoriteArticlesDbMigration.descriptionColumn: article.description,
      FavoriteArticlesDbMigration.urlColumn: article.url,
      FavoriteArticlesDbMigration.urlToImageColumn: article.urlToImage,
      FavoriteArticlesDbMigration.publishedAtColumn: article.publishedAt.toIso8601String(),
      FavoriteArticlesDbMigration.contentColumn: article.content,
      FavoriteArticlesDbMigration.savedAtColumn: DateTime.now().millisecondsSinceEpoch,
    };
  }

  NewsArticleItemEntity _articleFromDbMap(final Map<String, Object?> row) {
    return NewsArticleItemEntity(
      source: NewsSourceEntity(
        id: row[FavoriteArticlesDbMigration.sourceIdColumn] as String?,
        name: row[FavoriteArticlesDbMigration.sourceNameColumn] as String?,
      ),
      author: row[FavoriteArticlesDbMigration.authorColumn] as String?,
      title: row[FavoriteArticlesDbMigration.titleColumn] as String? ?? '',
      description: row[FavoriteArticlesDbMigration.descriptionColumn] as String?,
      url: row[FavoriteArticlesDbMigration.urlColumn] as String? ?? '',
      urlToImage: row[FavoriteArticlesDbMigration.urlToImageColumn] as String?,
      publishedAt: _parsePublishedAt(row[FavoriteArticlesDbMigration.publishedAtColumn] as String?),
      content: row[FavoriteArticlesDbMigration.contentColumn] as String?,
    );
  }

  DateTime _parsePublishedAt(final String? value) {
    if (value == null || value.isEmpty) {
      return DateTime.fromMillisecondsSinceEpoch(0);
    }

    return DateTime.tryParse(value) ?? DateTime.fromMillisecondsSinceEpoch(0);
  }
}
