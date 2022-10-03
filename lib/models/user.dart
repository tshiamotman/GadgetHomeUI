class User {
  String userName;

  String firstName;

  String lastName;

  String? number;

  String email;

  String password;

  User(this.userName, this.firstName, this.lastName, this.number, this.email,
      this.password);

  factory User.fromJson(Map map) {
    return User(map["userName"], map["firstName"], map["lastName"],
        map["number"], map["email"], map["password"]);
  }

  Map<String, String> toJson() {
    return {
      'userName': userName,
      'firstName': firstName,
      'lastName': lastName,
      'number': number!,
      'email': email,
      'password': password
    };
  }
}
