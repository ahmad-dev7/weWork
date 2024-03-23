import 'package:myapp/model/tasks.dart';

class JoinedTeams {
  String? teamName;
  String? projectName;
  String? projectDescription;
  String? teamCode;
  String? ownerName;
  List<Tasks>? tasks;

  JoinedTeams({
    this.teamName,
    this.projectName,
    this.projectDescription,
    this.teamCode,
    this.ownerName,
    this.tasks,
  });

  factory JoinedTeams.fromJson(Map<String, dynamic> json) {
    return JoinedTeams(
        teamName: json['teamName'],
        projectName: json['projectName'],
        projectDescription: json['projectDescription'],
        teamCode: json['teamCode'],
        ownerName: json['ownerName'],
        tasks: (json['tasks'] as List<dynamic>?)
            ?.map((task) => Tasks.fromJson(json))
            .toList());
  }
}
