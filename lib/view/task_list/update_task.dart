import 'package:app_scrip/app_dependency/get_it_depencency.dart';
import 'package:app_scrip/models/task_model.dart';
import 'package:app_scrip/universal_widgets/custom_button.dart';
import 'package:app_scrip/utils/colors.dart';
import 'package:app_scrip/utils/utils.dart';
import 'package:app_scrip/view_models/task_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UpdateTask extends StatefulWidget {
  final TaskModel task;
  final int index;
  const UpdateTask({super.key, required this.task, required this.index});

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late DateTime _dueDate;
  late String _priority;
  late String _status;
  late String _assignedUser;

  final List<String> _priorities = ["High", "Medium", "Low"];
  final List<String> _statuses = ["To-Do", "In Progress", "Done"];
  final List<String> _users = [
    "Rahul Sharma",
    "Priya Patel",
    "Hardik Kanzariya",
  ];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController = TextEditingController(
      text: widget.task.description,
    );
    _dueDate = DateTime.parse(widget.task.dueDate ?? "");
    _priority = widget.task.priority ?? "";
    _status = widget.task.status ?? "";
    _assignedUser = widget.task.assignedUser ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final taskVM = getIt<TaskViewModel>();

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(title: const Text("Edit Task"), backgroundColor: white),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Title
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Title"),
                validator: (value) => (value == null || value.isEmpty)
                    ? "Please enter title"
                    : null,
              ),
              const SizedBox(height: 16),

              // Description
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: "Description"),
                maxLines: 3,
                validator: (value) => (value == null || value.isEmpty)
                    ? "Please enter description"
                    : null,
              ),
              const SizedBox(height: 16),

              // Due Date
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  "Due Date: ${_dueDate.toLocal().toString().split(' ')[0]}",
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _dueDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setState(() {
                      _dueDate = picked;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),

              // Priority
              DropdownButtonFormField<String>(
                value: _priority,
                decoration: const InputDecoration(labelText: "Priority"),
                items: _priorities
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) => setState(() => _priority = val!),
              ),
              const SizedBox(height: 16),

              // Status
              DropdownButtonFormField<String>(
                value: _status,
                decoration: const InputDecoration(labelText: "Status"),
                items: _statuses
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) => setState(() => _status = val!),
              ),
              const SizedBox(height: 16),

              // Assigned User
              DropdownButtonFormField<String>(
                value: _assignedUser,
                decoration: const InputDecoration(labelText: "Assigned User"),
                items: _users
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) => setState(() => _assignedUser = val!),
              ),
              const SizedBox(height: 32),

              // Save Button
              CustomButton(
                text: "Update Task",
                height: 50,
                backgroundColor: blue,
                textColor: white,
                textSize: 18,
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    final updatedTask = TaskModel(
                      id: widget.task.id,
                      title: _titleController.text,
                      description: _descriptionController.text,
                      dueDate: _dueDate.toIso8601String(),
                      priority: _priority,
                      status: _status,
                      assignedUser: _assignedUser,
                    );

                    await taskVM.updateTask(updatedTask, widget.index);

                    Utils.toastMessage("Task updated successfully!", success);
                    context.pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
