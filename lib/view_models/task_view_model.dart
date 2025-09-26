import 'package:app_scrip/repository/task/task_repo.dart';
import 'package:app_scrip/utils/colors.dart';
import 'package:app_scrip/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:app_scrip/models/task_model.dart';

class TaskViewModel extends ChangeNotifier {
  final TaskRepository taskRepository;
  TaskViewModel({required this.taskRepository});
  //----------------------------------------------------------------------------

  List<TaskModel> _tasks = [];
  List<TaskModel> get tasks => _tasks;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Fetch all tasks from local DB
  Future<void> fetchTasks() async {
    setLoading(true);

    try {
      _tasks = await taskRepository.fetchTasks();
      setLoading(false);
    } catch (e) {
      debugPrint("⚠️ Failed to fetch tasks: $e");
      _tasks = [];
      setLoading(false);
    }
  }

  /// Add new task
  Future<void> createTask(TaskModel task) async {
    try {
      await taskRepository.createTask(task);

      _tasks.insert(0, task); // insert at top
      notifyListeners();
    } catch (e) {
      debugPrint("⚠️ Failed to add task: $e");
    }
  }

  /// Update existing task
  Future<void> updateTask(TaskModel task, int index) async {
    try {
      await taskRepository.updateTask(task);
      _tasks[index] = task; // directly update
      notifyListeners();
    } catch (e) {
      debugPrint("⚠️ Failed to update task: $e");
    }
  }

  /// Delete a task
  Future<void> deleteTask(int id, int index) async {
    try {
      await taskRepository.deleteTask(id);
      _tasks.removeAt(index);
      Utils.toastMessage("Task updated successfully!", success);
      notifyListeners();
    } catch (e) {
      debugPrint("⚠️ Failed to delete task: $e");
    }
  }
}
