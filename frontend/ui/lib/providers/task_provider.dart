// Manage the state of tasks using the ChangeNotifier pattern

import 'package:flutter/foundation.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get tasks {
    return [..._tasks];
  }

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void toggleTaskStatus(int index) {
    _tasks[index].toggleDone();
    notifyListeners();
  }

  // TODO: Implement methods to update and delete tasks

  // TODO: You can also add methods for fetching and managing tasks
}
