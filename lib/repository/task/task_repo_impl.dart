import 'package:app_scrip/models/task_model.dart';
import 'package:app_scrip/repository/task/task_repo.dart';
import 'package:app_scrip/services/local_database_sqflite/task_database.dart';
import 'package:app_scrip/services/network/api_end_points.dart';
import 'package:app_scrip/services/network/network_api_service.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class TaskRepositoryImpl implements TaskRepository {
  final NetworkApiService networkApiService;
  final TaskDatabase localDb;

  TaskRepositoryImpl({required this.networkApiService, required this.localDb});

  // Fetch all tasks (try API, fallback to local)
  @override
  Future<List<TaskModel>> fetchTasks() async {
    try {
      final Response response = await networkApiService.getResponse(
        ApiEndPoints.getTask,
        queryParameters: {},
      );

      if (response.statusCode == 200 && response.data != null) {
        debugPrint("✅ Tasks fetched from API");
        // You can parse and sync with local DB if needed
      } else {
        debugPrint("⚠️ API returned ${response.statusCode}, using local DB");
      }
    } catch (e) {
      debugPrint("⚠️ API fetch failed: $e, using local DB");
    }

    // Always return local tasks (offline-first)
    return await localDb.getAllTasks();
  }

  // Create a new task
  @override
  Future<void> createTask(TaskModel task) async {
    final localId = await localDb.insertTask(task);
    debugPrint("Task created locally with ID: $localId");

    try {
      final Response response = await networkApiService.postResponse(
        ApiEndPoints.createTask,
        data: {},
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        debugPrint("✅ Task synced with API");
      } else {
        debugPrint("⚠️ Failed to sync task, status: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("⚠️ Sync failed — will retry later: $e");
    }
  }

  // Update a task
  @override
  Future<void> updateTask(TaskModel task) async {
    await localDb.updateTask(task);
    debugPrint("Task updated locally");

    try {
      final Response response = await networkApiService.putResponse(
        "${ApiEndPoints.updateTask}/${task.id}",
        data: {},
      );

      if (response.statusCode == 200) {
        debugPrint("✅ Task synced with API");
      } else {
        debugPrint("⚠️ API returned ${response.statusCode} on update");
      }
    } catch (e) {
      debugPrint("⚠️ Failed to sync update: $e");
    }
  }

  // Delete a task
  @override
  Future<void> deleteTask(int id) async {
    await localDb.deleteTask(id);
    debugPrint("Task deleted locally");

    try {
      final Response response = await networkApiService.deleteResponse(
        "${ApiEndPoints.deleteTask}/$id",
        data: {},
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        debugPrint("✅ Task deleted from server");
      } else {
        debugPrint("⚠️ API delete failed: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("⚠️ Failed to delete from server: $e");
    }
  }
}
