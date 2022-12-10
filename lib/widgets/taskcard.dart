import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:get/get.dart';
import 'package:habitz/animations/slideout.dart';
import 'package:habitz/controllers/taskcontroller.dart';
import 'package:habitz/models/task.dart';
import 'package:intl/intl.dart';

class TaskCard extends StatelessWidget {
  final String taskName;
  bool checkvalue;
  final DateTime finalDate;
  int index;

  TaskCard(this.taskName, this.finalDate, this.index, this.checkvalue,
      {super.key});
  Taskcontroller taskcontroller = Get.put(Taskcontroller());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              gradient: LinearGradient(
                  colors: GradientColors.lightBlack,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  transform: GradientRotation(50))),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                child: Transform.scale(
                  scale: 2,
                  child: Checkbox(
                      value: checkvalue,
                      onChanged: (check) {
                        taskcontroller.updateCheck(index, check!);
                        Future.delayed(Duration(milliseconds: 350), () {
                          taskcontroller.listkey.currentState?.removeItem(
                              index,
                              (_, animation) =>
                                  slideIt(context, index, animation, this));
                          taskcontroller.deletetask(index);
                        });
                      },
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      checkColor: Colors.white,
                      activeColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Text(
                        taskName,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Due: ${DateFormat('yMMMMd').format(finalDate)}",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
