import 'package:isar/isar.dart';

part 'Habit.g.dart';

@collection
class Habit {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment
  @Index(type: IndexType.value)
  String? name;

  String? color;

  List<DateTime>? dates;

  DateTime? createdDate;
}
