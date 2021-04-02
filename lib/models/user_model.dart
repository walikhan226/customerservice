class UserModel {
  String email;
  String username;
  String number;

  UserModel({
    this.email,
    this.username,
    this.number,
  });

  Map toMap(UserModel user) {
    var data = Map<String, dynamic>();
    data['email'] = user.email;
    data['username'] = user.username;
    data['number'] = user.number;
    return data;
  }

  // Named constructor
  UserModel.fromMap(Map<String, dynamic> mapData) {
    this.email = mapData['email'];
    this.username = mapData['username'];
    this.number = mapData['number'];
  }
}
