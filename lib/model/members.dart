class Members {
  String? name;
  String? userId;

  Members({this.name, this.userId});

  factory Members.fromJson(Map<String, dynamic> json) {
    return Members(
      name: json['name'],
      userId: json['userId'],
    );
  }
}
