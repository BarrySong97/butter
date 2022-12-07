import 'package:isar/isar.dart';
import 'package:lipomo/db.dart';
import 'package:lipomo/models/Habit.dart';

List<int> daysInMonth = <int>[31, -1, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
List<CheckedItem> getDatesOfThisYear() {
  final now = DateTime.now();
  int year = now.year;
  final bool isLeapYear =
      (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
  final int fabruary = isLeapYear ? 29 : 28;
  daysInMonth[1] = fabruary;
  final int daysOfYear =
      daysInMonth.reduce((value, element) => value + element);
  final List<CheckedItem> dateList = [];
  // final List<List<CheckedItem>> listMap =
  //     daysInMonth.map((e, index) => getDateOfThisMonth(year, e)).toList();
  final List<List<CheckedItem>> listMap = daysInMonth.asMap().entries.map((e) {
    int idx = e.key;
    int val = e.value;
    return getDateOfThisMonth(year, idx, val);
  }).toList();
  return listMap.expand((element) => element).toList();
}

List<CheckedItem> getDateOfThisMonth(int year, int month, days) {
  final List<CheckedItem> dateList = [];
  for (int i = 0; i < days; i++) {
    final DateTime date = DateTime(year, month + 1, i + 1);
    final checkedItem = CheckedItem()
      ..date = date
      ..checked = false;
    dateList.add(checkedItem);
  }
  return dateList;
}

class HabitService {
  static final HabitService _dbManager = new HabitService._internal();
  HabitService._internal();
  static HabitService get instance => _dbManager;
  // Member
  // static IsarCollection<Habit>? _repo;
  // static IsarCollection<Habit>? _db;
  static Future<Isar> get db async => await DBManager.instance.database;
  static Future<IsarCollection<Habit>> get repo async => await _initDB();

  static Future<IsarCollection<Habit>> _initDB() async {
    // .. Copy initial database (data.db) from assets file to database path
    // .. Let's assume we have copy our initial database, and put it to database path
    final db = await DBManager.instance.database;
    return db.collection<Habit>();
  }

  static Future<void> addHabit(Habit item) async {
    final _db = await db;
    final _repo = await repo;

    item.dates = getDatesOfThisYear();
    await _db.writeTxn(() async {
      await _repo.put(item);
    });
  }

  static Future<List<Habit>> getAll() async {
    final _repo = await repo;

    final list = _repo.where().findAll();
    return list;
  }

  static Future<void> deleteHabit(Habit item) async {
    final _repo = await repo;
    final list = _repo.delete(item.id);
  }

  static Future<void> update(Habit item) async {
    final _db = await db;
    final _repo = await repo;
    await _db.writeTxn(() async {
      await _repo.put(item);
    });
  }
}
