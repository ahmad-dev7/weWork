import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/model/members.dart';

class Tasks {
  String? taskTitle;
  String? taskDescription;
  Members? assignedTo;
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
    var dueDate = DateTime.parse(json['dueDate']);
    return Tasks(
      taskTitle: json['title'],
      taskDescription: json['description'],
      assignedTo: assignedToMember(json['assignedTo']),
      dueDate: Timestamp.fromDate(dueDate),
      isCompleted: json['isCompleted'],
    );
  }

  static assignedToMember(var json) {
    return Members(
      name: json.first['name'],
      userId: json.first['userId'],
    );
  }
}
