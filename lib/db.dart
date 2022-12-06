import 'package:isar/isar.dart';

import 'models/Habit.dart';

class DBManager {
  // Singleton pattern
  static final DBManager _dbManager = new DBManager._internal();
  DBManager._internal();
  static DBManager get instance => _dbManager;
  // Member
  static Isar? _database;
  Future<Isar> get database async => _database ??= await _initDB();

  Future<Isar> _initDB() async {
    // .. Copy initial database (data.db) from assets file to database path
    // .. Let's assume we have copy our initial database, and put it to database path
    return await Isar.open([HabitSchema]);
  }
}
