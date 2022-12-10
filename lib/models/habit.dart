import 'package:hive/hive.dart';
part 'habit.g.dart';

@HiveType(typeId: 1)
class Habit {
  @HiveField(0)
  String? habitName;

  @HiveField(1)
  int? streak = 0;

  @HiveField(2)
  String? lastStreakUpdate;

  @HiveField(3)
  int? highStreak = 0;

  @HiveField(4)
  Duration? duration;

  Habit(
      {this.habitName,
      this.streak,
      this.highStreak,
      this.duration,
      this.lastStreakUpdate});
}
