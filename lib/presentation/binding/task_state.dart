import '../../domain/entities/task_entity.dart';

abstract class TaskState{}
class TaskInit extends TaskState{}
class TaskLoading extends TaskState{}
class TaskUpdated extends TaskState{
  TaskEntity task;
  TaskUpdated({required this.task});
}
class TaskLoaded extends TaskState{
  List<TaskEntity> tasks;
  TaskLoaded({required this.tasks});
}
class TaskLoadingFailed extends TaskState{
  String exp;
  TaskLoadingFailed({required this.exp});
}