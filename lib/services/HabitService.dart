import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:lipomo/db.dart';
import 'package:lipomo/models/Habit.dart';

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

  static Future<void> remove(int id) async {
    final _db = await db;
    final _repo = await repo;
    await _db.writeTxn(() async {
      await _repo.delete(id);
    });
  }

  static Future<void> check(Habit item, bool checked, DateTime date) async {
    final _db = await db;
    final _repo = await repo;
    if (checked) {
      item.dates?.removeWhere((element) => DateUtils.isSameDay(element, date));
    } else {
      item.dates?.add(date);
    }
    await _db.writeTxn(() async {
      await _repo.put(item);
    });
  }
}
