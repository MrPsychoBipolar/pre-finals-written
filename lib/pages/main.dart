import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pre_finals_written/pages/todo_list_display.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.green,
    ),
    title: ("Pre Finals - Written"),
    home: const ToDoListDisplay(),
  ));
}
