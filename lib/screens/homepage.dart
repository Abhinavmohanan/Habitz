import 'package:flutter/material.dart';

import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:habitz/animations/slideout.dart';
import 'package:habitz/controllers/habitcontroller.dart';
import 'package:habitz/controllers/taskcontroller.dart';
import 'package:habitz/models/habit.dart';
import 'package:habitz/widgets/addhabit.dart';
import 'package:habitz/widgets/addtask.dart';
import 'package:habitz/widgets/habitcard.dart';
import 'package:habitz/widgets/taskcard.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final Habitcontroller habitcontroller = Get.put(Habitcontroller());
  final Taskcontroller taskcontroller = Get.put(Taskcontroller());

  List<List<Color>> colors = [
    GradientColors.aqua,
    GradientColors.mirage,
    GradientColors.seaBlue,
    GradientColors.indigo,
    GradientColors.lightBlack,
    GradientColors.noontoDusk,
  ];

  void _addHabitModalSheet(BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      context: ctx,
      builder: (_) {
        return SizedBox(
          child: AddHabit(),
        );
      },
    );
  }

  void _addTaskModalSheet(BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      context: ctx,
      builder: (_) {
        return SizedBox(
          child: AddTask(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: SafeArea(
            child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      margin: const EdgeInsets.all(20),
                      child: const Text(
                        "Habitz",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      )),
                  Container(
                    width: 50,
                    height: 40,
                    margin: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        gradient:
                            LinearGradient(colors: GradientColors.nightSky)),
                    child: TextButton(
                      onPressed: () {
                        _addHabitModalSheet(context);
                      },
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  child: habitcontroller.habit.isEmpty
                      ? const Center(
                          child: Text(
                          "Enter New Habits",
                          style: TextStyle(fontSize: 20),
                        ))
                      : GetBuilder<Habitcontroller>(builder: (controller) {
                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: habitcontroller.habit.length,
                              itemBuilder: (ctx, index) {
                                return HabitCard(
                                  heading:
                                      habitcontroller.habit[index].habitName,
                                  streak: habitcontroller.habit[index].streak,
                                  color: colors[index % colors.length],
                                  index: index,
                                  lastStreakUpdate: habitcontroller
                                      .habit[index].lastStreakUpdate,
                                );
                              });
                        })),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.all(15),
                child: const Text(
                  "Pending Tasks",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height / 1.7,
                  width: MediaQuery.of(context).size.width,
                  child: taskcontroller.task.isEmpty
                      ? const Center(
                          child: Text(
                          "No pending Tasks",
                          style: TextStyle(fontSize: 20),
                        ))
                      : GetBuilder<Taskcontroller>(builder: (controller) {
                          return AnimatedList(
                              key: taskcontroller.listkey,
                              initialItemCount: taskcontroller.task.length,
                              itemBuilder: (ctx, index, animation) {
                                return slideIt(
                                  context,
                                  index,
                                  animation,
                                  TaskCard(
                                      taskcontroller.task[index].taskName,
                                      taskcontroller.task[index].finalDate,
                                      index,
                                      taskcontroller.task[index].checked),
                                );
                              });
                        })),
            ],
          ),
        )),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: GradientColors.nightSky[0],
          onPressed: () {
            _addTaskModalSheet(context);
          },
          label: const Text(
            "Add Task",
            style: TextStyle(color: Colors.white),
          ),
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ));
  }
}
