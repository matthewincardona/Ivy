// This screen displays the list of tasks.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../widgets/task_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: Consumer<TaskProvider>(
        builder: (ctx, taskProvider, child) {
          return ListView.builder(
            itemCount: taskProvider.tasks.length,
            itemBuilder: (ctx, index) {
              final task = taskProvider.tasks[index];
              return TaskTile(
                title: task.title,
                isDone: task.isDone,
                onChanged: (value) {
                  taskProvider.toggleTaskStatus(index);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/add-task');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
