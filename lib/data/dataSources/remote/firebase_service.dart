import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_management/data/models/task_model.dart';
import 'package:task_management/domain/entities/task_entity.dart';

class FirebaseService{

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> storeTask(TaskModel task) async {
    try {
      // Add the task to Firestore and get the document reference
      DocumentReference docRef = await _fireStore.collection('tasks').add(task.toJson());
      print('Task added successfully with ID: ${docRef.id}');
    } catch (e) {
      print('Error adding task: $e');
    }
  }

  Future<List<TaskModel>> getTasks() async {
    try {
      // Fetch all tasks
      QuerySnapshot querySnapshot = await _fireStore.collection('tasks').get();

      // Map the documents to TaskModel objects
      List<TaskModel> tasks = querySnapshot.docs.map((doc) {
        return TaskModel.fromFirestore(doc);
      }).toList();
      return tasks;
   } catch (e) {
      print('Error getting tasks: $e');
      return [];
    }
  }

  Future<void> updateTask(TaskModel task) async {
    try {
      // Query the tasks collection for a document with the specified taskId
      QuerySnapshot querySnapshot = await _fireStore
          .collection('tasks')
          .where('taskId', isEqualTo: task.taskId)
          .get();

      // Check if any documents were found
      if (querySnapshot.docs.isNotEmpty) {
        String docId = querySnapshot.docs.first.id;
        // Update the document with the new task data
        await _fireStore.collection('tasks').doc(docId).update(task.toJson());
        print('Task updated successfully with taskId: ${task.taskId}');
      } else {
        print('No task found with taskId: ${task.taskId}');
      }
    } catch (e) {
      print('Error updating task: $e');
    }
  }

}
