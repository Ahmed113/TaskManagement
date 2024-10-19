import 'package:task_management/domain/entities/task_entity.dart';

abstract class TaskRepo {
  Future<void> storeTask(TaskEntity task);
  Future<List<TaskEntity>> getTasks();
  Future<void> updateTask(TaskEntity task);
  Future<void> syncTasks();
  Future<void> syncUpdatedTasks();
  Future<bool> isConnected();
  void monitorConnectivity(Function onConnected);
}