class CreatedTeams {
  String? teamName;
  String? projectName;
  String? projectDescription;
  String? teamCode;

  CreatedTeams({
    this.teamName,
    this.projectName,
    this.projectDescription,
    this.teamCode,
  });

  factory CreatedTeams.fromJson(Map<String, dynamic> json) {
    return CreatedTeams(
      teamName: json['teamName'],
      projectName: json['projectName'],
      projectDescription: json['projectDescription'],
      teamCode: json['teamCode'],
    );
  }
}
