class UserData {
  String? name;
  String? userId;

  UserData({this.name, this.userId});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      name: json['name'],
      userId: json['userId'],
    );
  }
}
