// Manage the state of tasks using the ChangeNotifier pattern

import 'package:flutter/foundation.dart';
import 'package:ui/main.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  TaskProvider(this.storage) {
    _loadTasks();
  }

  final TaskStorage storage;
  final List<Task> _tasks = [];

  List<Task> get tasks => [..._tasks];

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
    _saveTasks();
  }

  void toggleTaskStatus(int index) {
    _tasks[index].toggleDone();
    notifyListeners();
    _saveTasks();
  }

  Future<void> _loadTasks() async {
    final tasks = await storage.readTasks();
    _tasks.addAll(tasks);
    notifyListeners();
  }

  Future<void> _saveTasks() async {
    await storage.writeTasks(_tasks);
  }

  // TODO: Implement methods to update and delete tasks
}
