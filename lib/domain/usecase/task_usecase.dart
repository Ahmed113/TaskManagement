
import 'package:task_management/domain/entities/task_entity.dart';

import '../../data/models/task_model.dart';
import '../repo/task_repo.dart';

class TaskUsecase{
  TaskRepo taskRepo;
  TaskUsecase({required this.taskRepo});

  Future<List<TaskEntity>> getTasks() async{
    return await taskRepo.getTasks();
  }

  Future<void> storeTask(TaskEntity task) async {
    await taskRepo.storeTask(task);
  }

  Future<void> updateTask(TaskEntity task) async{
    await taskRepo.updateTask(task);
  }

  Future<bool> isConnected() async{
    return await taskRepo.isConnected();
  }

  Future<void> syncTasks() async{
    await taskRepo.syncTasks();
  }

  Future<void> syncUpdatedTasks() async{
    await taskRepo.syncUpdatedTasks();
  }

  void monitorConnectivity(Function onConnected) {
    taskRepo.monitorConnectivity(onConnected);
  }
}