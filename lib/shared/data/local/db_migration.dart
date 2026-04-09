import 'package:sqflite/sqflite.dart';

abstract base class DbMigration {
  const DbMigration();

  int get version;

  Future<void> migrate(Database database);
}
