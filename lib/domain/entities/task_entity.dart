
import 'package:uuid/uuid.dart';

class TaskEntity{
  String? taskId;
  String taskTitle;
  String dueDate;
  bool isDone;
  bool isSynced;
  TaskEntity({
    String? taskId,
    required this.taskTitle,
    required this.dueDate,
    this.isDone = false,
    this.isSynced = false
  }) : taskId = taskId ?? const Uuid().v4();
}