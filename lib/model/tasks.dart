import 'package:cloud_firestore/cloud_firestore.dart';

class Tasks {
  String? taskTitle;
  String? taskDescription;
  String? assignedTo;
  Timestamp? dueDate;
  bool? isCompleted;

  Tasks({
    this.taskTitle,
    this.taskDescription,
    this.assignedTo,
    this.dueDate,
    this.isCompleted,
  });

  factory Tasks.fromJson(Map<String, dynamic> json) {
    return Tasks(
      taskTitle: json['taskTitle'],
      taskDescription: json['taskDescription'],
      assignedTo: json['assignedTo'],
      dueDate: json['dueDate'],
      isCompleted: json['isCompleted'],
    );
  }
}
