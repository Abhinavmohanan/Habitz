import 'package:flutter/material.dart';

Widget slideIt(BuildContext context, int index, animation, Widget child) {
  return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset(0, 0),
      ).animate(animation),
      child: child);
}
