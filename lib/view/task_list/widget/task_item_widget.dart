import 'package:app_scrip/utils/colors.dart';
import 'package:app_scrip/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:app_scrip/models/task_model.dart';

typedef TaskActionCallback = void Function(TaskModel task);

class TaskItemWidget extends StatelessWidget {
  final TaskModel task;
  final TaskActionCallback? onTap;
  final TaskActionCallback? onDelete;

  const TaskItemWidget({
    super.key,
    required this.task,
    this.onTap,
    this.onDelete,
  });

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return red;
      case "Medium":
        return orange;
      case "Low":
        return green;
      default:
        return grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final priorityColor = _getPriorityColor(task.priority ?? "Low");

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [white, white.withOpacity(0.95)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Title Row with Delete Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  task.title ?? "Untitled Task",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (onTap != null)
                IconButton(
                  icon: const Icon(Icons.edit, color: green),
                  onPressed: () => onTap?.call(task),
                  tooltip: "Update Task",
                ),
              if (onDelete != null)
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: red),
                  onPressed: () => onDelete!(task),
                  tooltip: "Delete Task",
                ),
            ],
          ),
          const SizedBox(height: 6),

          // 📝 Description (optional)
          if ((task.description ?? "").isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                task.description ?? "",
                style: const TextStyle(color: grey, fontSize: 14, height: 1.4),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),

          // 🧾 Info Row
          Row(
            children: [
              _buildChip(
                icon: Icons.flag_rounded,
                label: task.priority ?? "Low",
                color: priorityColor.withOpacity(0.15),
                textColor: priorityColor,
              ),
              const SizedBox(width: 10),
              _buildChip(
                icon: Icons.check_circle_outline,
                label: task.status ?? "To-Do",
                color: blue.withOpacity(0.15),
                textColor: blue,
              ),
            ],
          ),
          const SizedBox(height: 12),

          // 📅 Date & 👤 User Row
          Row(
            children: [
              const Icon(Icons.calendar_today_outlined, size: 16, color: grey),
              const SizedBox(width: 6),
              Text(
                Utils.formatDate(task.dueDate ?? ""),
                style: const TextStyle(fontSize: 13, color: grey),
              ),
              // const SizedBox(width: 20),
              Spacer(),
              const Icon(Icons.person_outline, size: 16, color: grey),
              const SizedBox(width: 6),
              Text(
                task.assignedUser ?? "Unassigned",
                style: const TextStyle(fontSize: 13, color: grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChip({
    required IconData icon,
    required String label,
    required Color color,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: textColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
