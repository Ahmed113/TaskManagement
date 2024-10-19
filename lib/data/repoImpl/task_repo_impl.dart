import 'package:task_management/data/dataSources/remote/firebase_service.dart';
import 'package:task_management/data/models/task_model.dart';
import 'package:task_management/domain/entities/task_entity.dart';
import 'package:task_management/domain/repo/task_repo.dart';

import '../dataSources/local/local_storage.dart';
import '../networkInfo/network_info.dart';

class TaskRepoImpl extends TaskRepo{
  FirebaseService firebaseService;
  LocalStorage localStorage;
  NetworkInfo networkInfo;
  TaskRepoImpl({required this.firebaseService, required this.localStorage, required this.networkInfo});

  @override
  Future<List<TaskModel>> getTasks() async{
    return await localStorage.getStoredTasks();
  }

  @override
  Future<void> storeTask(TaskEntity task) async {
    localStorage.storeTaskLocally(task);
    if (await networkInfo.isConnected()) {
        await syncTaskToFirestore(task);
      }
  }

  @override
  Future<void> updateTask(TaskEntity task) async{
    await localStorage.updateTask(task);
    if (await networkInfo.isConnected()) {
      await firebaseService.updateTask(TaskModel.fromTaskEntity(task));
    }
  }

  @override
  Future<bool> isConnected() async{
    return await networkInfo.isConnected();
  }

  @override
  Future<void> syncTasks() async{
    if (await networkInfo.isConnected()) {
      List<TaskModel> unsyncedTasks = await getUnsyncedTasks();
        for (TaskModel task in unsyncedTasks) {
          await syncTaskToFirestore(task);
        }
    }
  }

  @override
  Future<void> syncUpdatedTasks() async{
    if (await networkInfo.isConnected()) {
    List<TaskModel> localTasks = await localStorage.getStoredTasks();
    for(TaskModel task in localTasks){
      if (task.isDone == true) {
        task.isSynced = true;
        await localStorage.updateTask(task);
        await firebaseService.updateTask(TaskModel.fromTaskEntity(task));
      }
    }
    }
  }

  @override
  void monitorConnectivity(Function onConnected) {
    networkInfo.monitorConnectivity(onConnected);
  }

  Future<List<TaskModel>> getUnsyncedTasks() async {
    List<TaskModel> localTasks = await localStorage.getStoredTasks();
    if (localTasks.isNotEmpty) {
    return localTasks.where((task) => !task.isSynced).toList();
    }
    return [];
  }

  Future<void> syncTaskToFirestore(TaskEntity task) async{
    await firebaseService.storeTask(TaskModel.fromTaskEntity(task));
    // Mark task as synced in local storage
    task.isSynced = true;
    await localStorage.updateTask(task); // Update Hive
  }
}