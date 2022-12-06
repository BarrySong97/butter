import 'package:isar/isar.dart';

part 'Habit.g.dart';

@embedded
class CheckedItem {
  DateTime? date;
  bool? checked;
}

@collection
class Habit {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment
  @Index(type: IndexType.value)
  String? name;

  String? color;

  List<CheckedItem>? dates;
}
