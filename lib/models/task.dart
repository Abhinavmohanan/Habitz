import 'package:hive/hive.dart';
part 'task.g.dart';

@HiveType(typeId: 2)
class Task {
  @HiveField(0)
  String? taskName;

  @HiveField(1)
  int? id;

  @HiveField(2)
  DateTime? finalDate;

  @HiveField(3)
  bool? checked;

  Task({this.taskName, this.finalDate, required this.checked});
}
