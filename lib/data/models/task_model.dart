import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:task_management/domain/entities/task_entity.dart';
import 'package:uuid/uuid.dart';

part 'task_model.g.dart';
@HiveType(typeId: 0)
class TaskModel extends TaskEntity{
  @HiveField(0)
  String? taskId; // Optional if auto-generated by Firestore

  @HiveField(1)
  final String taskTitle;

  @HiveField(2)
  final String dueDate;

  @HiveField(3)
  bool isDone;

  @HiveField(4)
  bool isSynced;

  TaskModel({
    this.taskId,
    required this.taskTitle,
    required this.dueDate,
    this.isDone = false,
    this.isSynced = false
  }): super(
    taskId: taskId,
    taskTitle: taskTitle,
    dueDate: dueDate,
    isDone: isDone,
    isSynced: isSynced
  );

  factory TaskModel.fromTaskEntity(TaskEntity entity) {
    return TaskModel(
      taskId: entity.taskId ?? Uuid().v4(), // Generate if null
      taskTitle: entity.taskTitle,
      dueDate: entity.dueDate,
      isDone: entity.isDone,
      isSynced: entity.isSynced,
    );
  }

  TaskModel copyWith(
      {String? taskId,
      String? taskTitle,
      String? dueDate,
      bool? isDone,
      bool? isSynced}){
    return TaskModel(
        taskId: taskId ?? this.taskId,
        taskTitle: taskTitle ?? this.taskTitle,
        dueDate: dueDate ?? this.dueDate,
        isDone: isDone ?? this.isDone,
        isSynced: isSynced ?? this.isSynced
    );
  }

  factory TaskModel.fromFirestore(DocumentSnapshot doc) {
    return TaskModel(taskId: doc.id, taskTitle: doc['taskTitle'], dueDate: doc['dueDate'], isDone: doc["isDone"], isSynced: doc['isSynced']);
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(taskTitle: json['taskTitle'], dueDate: json['dueDate'], isDone: json['isDone'], isSynced: json['isSynced']);
  }

  Map<String, dynamic> toJson() {
    return {
      "taskId" : taskId,
      "taskTitle" : taskTitle,
      "dueDate" : dueDate,
      "isDone" : isDone,
    };
  }
}