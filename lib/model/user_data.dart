import 'package:myapp/model/created_teams.dart';
import 'package:myapp/model/joined_teams.dart';

class UserData {
  String? name;
  String? userId;
  List<CreatedTeams>? createdTeams;
  List<JoinedTeams>? joinedTeams;

  UserData({this.name, this.userId, this.createdTeams, this.joinedTeams});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      name: json['name'],
      userId: json['userId'],
      createdTeams: (json['createdTeams'] as List<dynamic>?)
          ?.map((team) => CreatedTeams.fromJson(json))
          .toList(),
      joinedTeams: (json['joinedTeams'] as List<dynamic>?)
          ?.map((team) => JoinedTeams.fromJson(json))
          .toList(),
    );
  }
}


