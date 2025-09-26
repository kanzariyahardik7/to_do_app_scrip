import 'package:app_scrip/models/task_model.dart';

abstract class TaskRepository {
  Future<List<TaskModel>> fetchTasks();
  Future<void> createTask(TaskModel task);
  Future<void> updateTask(TaskModel task);
  Future<void> deleteTask(int id);
}
