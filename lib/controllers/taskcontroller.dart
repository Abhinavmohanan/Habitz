import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:habitz/widgets/addtask.dart';
import '../models/task.dart';
import 'package:hive/hive.dart';

class Taskcontroller extends GetxController {
  List task = [];
  var box = Hive.box('Tasks');
  final GlobalKey<AnimatedListState> listkey = GlobalKey<AnimatedListState>();

  void onInit() {
    task = box.values.toList().reversed.toList();
  }

  addtask(String heading, DateTime? date) {
    Task newTask = Task(
      taskName: heading,
      finalDate: date,
      checked: false,
    );
    box.add(newTask);
    task.insert(0, newTask);
    update();
  }

  updateCheck(int index, bool check) {
    task[index].checked = check;
    update();
  }

  deletetask(int index) {
    task.removeAt(index);
    box.deleteAt(box.values.toList().length - index - 1);
    update();
  }
}
