import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../controllers/taskcontroller.dart';
import 'package:get/get.dart';

class AddTask extends StatefulWidget {
  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> with TickerProviderStateMixin {
  TextEditingController taskName = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  AnimateIconController arrow = AnimateIconController();
  final Taskcontroller taskcontroller = Get.put(Taskcontroller());

  bool goalexpanded = false;
  DateTime? pickeDate = DateTime.now();
  final lastdate = DateFormat('y').format(DateTime.now());

  datepicker() async {
    pickeDate = await showDatePicker(
        context: context,
        initialDate: pickeDate ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(int.parse(lastdate) + 2));
    setState(() {
      pickeDate = pickeDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 30, bottom: 10, right: 10, left: 10),
            child: Form(
              key: formkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text("Add New task",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                  TextFormField(
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Enter a task name";
                      } else {
                        return null;
                      }
                    },
                    controller: taskName,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.flag),
                        hintStyle: TextStyle(color: Colors.white),
                        hintText: "Enter the Task Name"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(15)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50))),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent)),
                        onPressed: () {
                          datepicker();
                        },
                        child: FittedBox(
                          child: Text(
                              "To do by : ${pickeDate != null ? DateFormat('yMMMMd').format(pickeDate!) : DateFormat('yMMMMd').format(DateTime.now())}"),
                        )),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              taskcontroller.listkey.currentState
                                  ?.insertItem(0);
                              taskcontroller.addtask(taskName.text, pickeDate);
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text("Confirm")))
                ],
              ),
            ),
          )),
    );
  }
}
