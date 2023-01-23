class User {
  String userName;

  String? firstName;

  String? lastName;

  String? number;

  String email;

  String? password;

  User(this.userName, this.firstName, this.lastName, this.number, this.email,
      this.password);

  factory User.fromJson(Map map) {
    return User(map["user_name"], map["first_name"], map["last_name"],
        map["number"], map["email"], "");
  }

  Map<String, String> toJson() {
    return {
      'userName': userName,
      'firstName': firstName!,
      'lastName': lastName!,
      'number': number!,
      'email': email,
      'password': password!
    };
  }
}
