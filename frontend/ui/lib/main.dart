import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ui/models/task.dart';

import 'screens/home_screen.dart';
import 'screens/add_task_screen.dart';
import 'providers/task_provider.dart';

late final ValueNotifier<TaskProvider> notifier;

void main() {
  runApp(
    MaterialApp(
      title: 'Reading and Writing Files',
      home: MyTodoApp(storage: TaskStorage()),
    ),
  );
}

class TaskStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/tasks.json');
  }

  Future<List<Task>> readTasks() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      final List<dynamic> jsonData = json.decode(contents);
      return jsonData.map((e) => Task.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<File> writeTasks(List<Task> tasks) async {
    final file = await _localFile;
    final String jsonString =
        json.encode(tasks.map((e) => e.toJson()).toList());
    return file.writeAsString(jsonString);
  }
}

class MyTodoApp extends StatelessWidget {
  const MyTodoApp({super.key, required this.storage});

  final TaskStorage storage;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(storage),
      child: MaterialApp(
        title: 'Todo App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (ctx) => const HomeScreen(),
          '/add-task': (ctx) => AddTaskScreen(),
        },
      ),
    );
  }
}
