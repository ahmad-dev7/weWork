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
      members: getMembers(json),
      tasks: getTasks(json),
    );
  }

  static getMembers(var json) {
    List<Members> members = [];
    print('Getting members----------------');
    if (json['members'].length > 0) {
      for (var member in json['members']) {
        members.add(Members.fromJson(member));
      }
    }
    print('Got the members----------------');
    return members;
  }

  static getTasks(var json) {
    List<Tasks> tasks = [];
    print('Getting tasks----------------');
    if (json['tasks'].length > 0) {
      print(json['tasks']);
      for (var task in json['tasks']) {
        tasks.add(Tasks.fromJson(task));
      }
    }
    print('Got the tasks----------------');
    return tasks;
  }
}
