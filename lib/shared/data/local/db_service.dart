import 'package:news_test/shared/data/local/db_migration.dart';
import 'package:sqflite/sqflite.dart';

abstract base class DbService {
  const DbService();

  Future<Database> database();
}

final class SqfliteDbService extends DbService {
  static const _databaseName = 'news_test.db';

  SqfliteDbService({
    required List<DbMigration> migrations,
  }) : _migrations = List.unmodifiable(
         [...migrations]..sort((left, right) => left.version.compareTo(right.version)),
       );

  final List<DbMigration> _migrations;

  Future<Database>? _databaseFuture;

  int get _databaseVersion => _migrations.isEmpty ? 1 : _migrations.last.version;

  @override
  Future<Database> database() => _databaseFuture ??= _openDatabase();

  Future<Database> _openDatabase() async {
    final databasesPath = await getDatabasesPath();
    final databasePath = '$databasesPath/$_databaseName';

    return openDatabase(
      databasePath,
      version: _databaseVersion,
      onCreate: (database, version) => _applyMigrations(database, fromVersion: 0, toVersion: version),
      onUpgrade: (database, oldVersion, newVersion) =>
          _applyMigrations(database, fromVersion: oldVersion, toVersion: newVersion),
    );
  }

  Future<void> _applyMigrations(
    final Database database, {
    required final int fromVersion,
    required final int toVersion,
  }) async {
    for (final migration in _migrations) {
      if (migration.version > fromVersion && migration.version <= toVersion) {
        await migration.migrate(database);
      }
    }
  }
}
