import 'package:flutter/material.dart';
import 'package:habitz/models/task.dart';
import 'package:habitz/screens/homepage.dart';
import 'package:hive_flutter/adapters.dart';
import 'models/habit.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(HabitAdapter());
  Hive.registerAdapter(TaskAdapter());

  await Hive.openBox('Tasks');
  await Hive.openBox('Habits');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habitz',
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}
