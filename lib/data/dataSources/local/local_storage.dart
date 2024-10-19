import 'package:hive/hive.dart';
import 'package:task_management/domain/entities/task_entity.dart';

import '../../models/task_model.dart';

class LocalStorage {
  var taskBox = Hive.box<TaskModel>('tasks_model_box');

  Future<void> storeTaskLocally(TaskEntity task) async {
    TaskModel taskModel = TaskModel(taskTitle: task.taskTitle, dueDate: task.dueDate, isDone: task.isDone, taskId: task.taskId);
    await taskBox.add(taskModel);
  }

  Future<List<TaskModel>> getStoredTasks() async {
    return taskBox.values.toList();
  }

  Future<void> removeTask(TaskModel task) async {
    int taskIndex =
        taskBox.values.toList().indexWhere((t) => t.taskId == task.taskId);
    if (taskIndex != -1) {
      await taskBox.deleteAt(taskIndex);
    }
  }

  Future<void> updateTask(TaskEntity task) async {
    int taskIndex =
        taskBox.values.toList().indexWhere((t) => t.taskId == task.taskId);
    if (taskIndex != -1) {
      await taskBox.putAt(taskIndex, TaskModel.fromTaskEntity(task));
    }
  }
}
