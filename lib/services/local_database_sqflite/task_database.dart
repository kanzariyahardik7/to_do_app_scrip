import 'package:app_scrip/models/task_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart';

class TaskDatabase {
  // Singleton instance
  static final TaskDatabase instance = TaskDatabase._init();
  static Database? _database;

  TaskDatabase._init();

  // Database getter
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('tasks.db');
    return _database!;
  }

  // Initialize database
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

  // Create table
  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        dueDate TEXT NOT NULL,
        priority TEXT NOT NULL,
        status TEXT NOT NULL,
        assignedUser TEXT NOT NULL
      )
    ''');

    // Add indexes for faster queries
    await db.execute('CREATE INDEX idx_status ON tasks(status)');
    await db.execute('CREATE INDEX idx_assignedUser ON tasks(assignedUser)');
  }

  // Handle migrations
  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Example: if version changes in future
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE tasks ADD COLUMN newColumn TEXT');
    }
  }

  /// ----------------------- CRUD OPERATIONS -----------------------

  // Insert task
  Future<int> insertTask(TaskModel task) async {
    try {
      final db = await database;
      final id = await db.insert('tasks', task.toMap());
      debugPrint("✅ Task inserted locally with ID: $id");
      return id;
    } catch (e) {
      debugPrint("⚠️ Insert failed: $e");
      return -1;
    }
  }

  // Get all tasks
  Future<List<TaskModel>> getAllTasks() async {
    try {
      final db = await database;
      final result = await db.query('tasks', orderBy: 'id DESC');
      return result.map((e) => TaskModel.fromMap(e)).toList();
    } catch (e) {
      debugPrint("⚠️ Fetch failed: $e");
      return [];
    }
  }

  // Update task
  Future<int> updateTask(TaskModel task) async {
    try {
      final db = await database;
      final rows = await db.update(
        'tasks',
        task.toMap(),
        where: 'id = ?',
        whereArgs: [task.id],
      );
      debugPrint("✅ Task updated: ${task.id}");
      return rows;
    } catch (e) {
      debugPrint("⚠️ Update failed: $e");
      return -1;
    }
  }

  // Delete task
  Future<int> deleteTask(int id) async {
    try {
      final db = await database;
      final rows = await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
      debugPrint("✅ Task deleted: $id");
      return rows;
    } catch (e) {
      debugPrint("⚠️ Delete failed: $e");
      return -1;
    }
  }

  // Close DB
  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}
