import 'package:animate_icons/animate_icons.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import '../controllers/habitcontroller.dart';
import 'package:get/get.dart';

class AddHabit extends StatefulWidget {
  @override
  State<AddHabit> createState() => _AddHabitState();
}

class _AddHabitState extends State<AddHabit> with TickerProviderStateMixin {
  TextEditingController habitName = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  Duration _duration = const Duration(hours: 0, minutes: 0);
  bool goalexpanded = false;
  AnimateIconController arrow = AnimateIconController();
  final Habitcontroller habitcontroller = Get.put(Habitcontroller());

  showtimepicker(context) {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      DurationPicker(
                        duration: _duration,
                        onChange: (val) {
                          setState(() {
                            _duration = val;
                          });
                        },
                        snapToMins: 5.0,
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blueGrey)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("OK"))
                    ],
                  ),
                ));
          });
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
                    child: Text("Add New Habit",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                  TextFormField(
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Enter a Habit name";
                      } else {
                        return null;
                      }
                    },
                    controller: habitName,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.emoji_emotions),
                        hintStyle: TextStyle(color: Colors.white),
                        hintText: "Habit"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ExpansionTile(
                    title: const Text("Goals",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    children: [
                      Container(
                        child: Card(
                          child: TextButton(
                            onPressed: () {
                              showtimepicker(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50)),
                              height: 30,
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(left: 20, right: 20),
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text("Add duration",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.white)),
                                  Icon(Icons.add)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                    onExpansionChanged: (value) {
                      setState(() {
                        goalexpanded = true;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              habitcontroller.addhabit(habitName.text, 0, null);
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
