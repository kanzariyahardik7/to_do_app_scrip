class TaskModel {
  int? id;
  String? title;
  String? description;
  String? dueDate;
  String? priority;
  String? status;
  String? assignedUser;

  TaskModel({
    this.id,
    this.title,
    this.description,
    this.dueDate,
    this.priority,
    this.status,
    this.assignedUser,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate,
      'priority': priority,
      'status': status,
      'assignedUser': assignedUser,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      dueDate: map['dueDate'],
      priority: map['priority'],
      status: map['status'],
      assignedUser: map['assignedUser'],
    );
  }
}
