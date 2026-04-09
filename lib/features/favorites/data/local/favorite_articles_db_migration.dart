import 'package:news_test/shared/data/local/db_migration.dart';
import 'package:sqflite/sqflite.dart';

final class FavoriteArticlesDbMigration extends DbMigration {
  const FavoriteArticlesDbMigration();

  static const favoritesTable = 'favorite_articles';

  static const articleIdColumn = 'article_id';
  static const sourceIdColumn = 'source_id';
  static const sourceNameColumn = 'source_name';
  static const authorColumn = 'author';
  static const titleColumn = 'title';
  static const descriptionColumn = 'description';
  static const urlColumn = 'url';
  static const urlToImageColumn = 'url_to_image';
  static const publishedAtColumn = 'published_at';
  static const contentColumn = 'content';
  static const savedAtColumn = 'saved_at';

  @override
  int get version => 1;

  @override
  Future<void> migrate(final Database database) async {
    await database.execute('''
      CREATE TABLE $favoritesTable(
        $articleIdColumn TEXT PRIMARY KEY,
        $sourceIdColumn TEXT,
        $sourceNameColumn TEXT,
        $authorColumn TEXT,
        $titleColumn TEXT NOT NULL,
        $descriptionColumn TEXT,
        $urlColumn TEXT NOT NULL,
        $urlToImageColumn TEXT,
        $publishedAtColumn TEXT NOT NULL,
        $contentColumn TEXT,
        $savedAtColumn INTEGER NOT NULL
      )
    ''');
  }
}
