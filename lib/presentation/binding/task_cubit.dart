import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_management/data/models/task_model.dart';
import 'package:task_management/domain/entities/task_entity.dart';
import 'package:task_management/presentation/binding/task_state.dart';

import '../../data/dataSources/remote/calender_service.dart';
import '../../domain/usecase/task_usecase.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit({required this.taskUsecase}) : super(TaskInit());
  TaskUsecase taskUsecase;
  List<TaskEntity> doneTasks = List.empty(growable: true);
  List<TaskEntity> notDoneTasks = List.empty(growable: true);

  Future<void> getTasks() async {
    emit(TaskLoading());
    try {
      List<TaskEntity> tasks = (await taskUsecase.getTasks()).toList();
      emit(TaskLoaded(tasks: tasks));
      notDoneTasks = tasks.where((t) => t.isDone == false).toList();
      doneTasks = tasks.where((t) => t.isDone == true).toList();
    } on Exception catch (exp) {
      emit(TaskLoadingFailed(exp: exp.toString()));
    }
  }

  Future<void> storeTask(TaskEntity task) async {
    try {
      await taskUsecase.storeTask(TaskModel.fromTaskEntity(task));
      await addToCalender(task);   // Add the task to calender once stored
    } on Exception catch (exp) {
      emit(TaskLoadingFailed(exp: exp.toString()));
    }
  }

  Future<void> toggleTask(TaskEntity task) async {
    if (state is TaskLoaded) {
      final currentState = state as TaskLoaded;
      final tasks = currentState.tasks;
      // Find and toggle the task's completion status locally
      int taskIndex = tasks.indexWhere((t) => t.taskId == task.taskId);
      if (taskIndex != -1 && tasks[taskIndex].isDone != true) {
        tasks[taskIndex].isDone = true;
        emit(TaskLoaded(tasks: List.from(tasks))); // Emit updated list to maintain UI state
        try {
          TaskEntity taskEntity = tasks[taskIndex];
          // Update task in Firestore
          await taskUsecase.updateTask(taskEntity);
          emit(TaskUpdated(task: tasks[taskIndex])); // Emit TaskUpdated for the SnackBar
          emit(TaskLoaded(tasks: List.from(tasks))); // Emit updated list to maintain UI state
          notDoneTasks = tasks.where((t) => t.isDone == false).toList();
          doneTasks = tasks.where((t) => t.isDone == true).toList();
        } on Exception catch (exp) {
          emit(TaskLoadingFailed(exp: exp.toString())); // Handle error
        }
      }
    }
  }

  // Add tasks to calender
  Future<void> addToCalender(TaskEntity task) async{
    if (await CalendarService().requestCalendarPermission()) {
      DateTime dateTime = DateFormat('MMM dd, yyyy').parse(task.dueDate);
      await CalendarService().addTaskToCalendar(task.taskTitle, ' ', dateTime);
    }
  }
}
