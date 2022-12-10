import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:get/get.dart';
import 'package:habitz/controllers/habitcontroller.dart';
import 'package:intl/intl.dart';

class HabitCard extends StatelessWidget {
  final String? heading;
  int streak;
  final List<Color> color;
  int index;
  String? lastStreakUpdate;

  HabitCard(
      {this.heading,
      required this.streak,
      required this.color,
      required this.index,
      this.lastStreakUpdate});

  Habitcontroller habitcontroller = Get.put(Habitcontroller());

  _showHabitDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              content: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Habit Name : $heading",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Execution frequency : $streak",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                              onPressed: () {
                                print(lastStreakUpdate);
                                if (lastStreakUpdate !=
                                    DateFormat('yMd').format(DateTime.now())) {
                                  habitcontroller.updateStreak(index, streak);
                                  Navigator.of(context).pop();
                                } else {
                                  Navigator.of(context).pop();
                                  _showStreakAlert(context);
                                }
                              },
                              child: Text(
                                "Done",
                                style: TextStyle(
                                    color: GradientColors.awesomePine[0]),
                              )),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                habitcontroller.deleteHabit(index);
                              },
                              child: Text(
                                "Delete Habit",
                                style:
                                    TextStyle(color: GradientColors.redLove[1]),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ));
        });
  }

  _showStreakAlert(BuildContext context) {
    return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
              contentPadding: const EdgeInsets.all(30),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              content: SingleChildScrollView(
                  child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Alert!",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Habit marked done for today",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("OK")),
                ],
              )));
        });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Habitcontroller>(builder: (ctx) {
      return Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 5,
          shadowColor: color[0],
          child: TextButton(
            style: ButtonStyle(
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
                padding: const MaterialStatePropertyAll(EdgeInsets.all(0))),
            onPressed: () {
              _showHabitDialog(context);
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  gradient: LinearGradient(colors: color)),
              alignment: Alignment.center,
              width: 170,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        heading ?? "Heading not found",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Streak: $streak days",
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.white,
                            fontStyle: FontStyle.italic),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
