class JoinedTeams {
  String? teamName;
  String? projectName;
  String? projectDescription;
  String? teamCode;
  String? ownerName;

  JoinedTeams({
    this.teamName,
    this.projectName,
    this.projectDescription,
    this.teamCode,
    this.ownerName,
  });

  factory JoinedTeams.fromJson(Map<String, dynamic> json) {
    return JoinedTeams(
      teamName: json['teamName'],
      projectName: json['projectName'],
      projectDescription: json['projectDescription'],
      teamCode: json['teamCode'],
      ownerName: json['ownerName'],
    );
  }
}
