import 'package:myapp/model/members.dart';
import 'package:myapp/model/tasks.dart';

class Teams {
  String? teamName;
  String? projectName;
  String? projectDescription;
  String? teamCode;
  String? ownerName;
  String? ownerId;
  List<Members>? members;
  List<Tasks>? tasks;

  Teams({
    this.teamName,
    this.projectName,
    this.projectDescription,
    this.teamCode,
    this.ownerName,
    this.ownerId,
    this.members,
    this.tasks,
  });

  factory Teams.fromJson(Map<String, dynamic> json) {
    return Teams(
      teamName: json['teamName'],
      projectName: json['projectName'],
      projectDescription: json['projectDescription'],
      teamCode: json['teamCode'],
      ownerName: json['ownerName'],
      ownerId: json['ownerId'],
      members: (json['members'] as List<dynamic>?)
          ?.map((member) => Members.fromJson(json))
          .toList(),
      tasks: (json['tasks'] as List<dynamic>?)
          ?.map((task) => Tasks.fromJson(json))
          .toList(),
    );
  }
}
