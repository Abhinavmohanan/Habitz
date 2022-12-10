import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import '../models/habit.dart';

class Habitcontroller extends GetxController {
  List habit = [];
  var box = Hive.box('Habits');

  void onInit() {
    habit = box.values.toList().reversed.toList();
  }

  addhabit(String heading, int streak, String? lastStreakUpdate) {
    Habit newHabit = Habit(
      habitName: heading,
      streak: streak,
      lastStreakUpdate: lastStreakUpdate,
    );
    habit.insert(0, newHabit);
    box.add(newHabit);
    update();
  }

  updateStreak(int index, int streak) {
    Habit temp = habit[index];
    Habit newHabit = Habit(
        habitName: temp.habitName,
        streak: streak + 1,
        lastStreakUpdate: DateFormat('yMd').format(DateTime.now()));
    print(newHabit.lastStreakUpdate);
    habit[index] = newHabit;
    box.putAt(box.values.toList().length - index - 1, newHabit);
    update();
  }

  deleteHabit(int index) {
    habit.removeAt(index);
    box.deleteAt(box.values.toList().length - index - 1);
    update();
  }
}
