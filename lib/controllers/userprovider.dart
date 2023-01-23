import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:gadgethome/apirequests/apirequests.dart';
import 'package:gadgethome/constants/constants.dart';
import 'package:gadgethome/models/user.dart';

class UserProvider extends ChangeNotifier {
  late User user;

  late Uint8List userProfilePicture;

  Map response = {};

  bool loggedIn = false;

  UserProvider();

  void loginUser(String username, String password) {
    login(username, password).then((value) {
      response.addAll(value);

      if (response["error"] == false && response["message"] == "Logged In") {
        user = User.fromJson(response["user"]);
        BEARER_TOKEN = response["token"];
        loggedIn = true;
      } else {
        loggedIn = false;
      }
    });
    notifyListeners();
  }

  Future<bool> registerUser(User user) {
    this.user = user;
    Map response = {};
    return register(user).then((value) {
      response.addAll(value);

      if (response["error"] == "false" &&
          response["message"] == "Account created successfully") {
        BEARER_TOKEN = response["token"];
        loggedIn = true;
        return true;
      }
      loggedIn = false;
      return false;
    });
  }

  Future<Uint8List> getProfilePicture(String username) {
    return getUserImage(username, BEARER_TOKEN).then((value) {
      if (username == user.userName) {
        userProfilePicture = value;
      }
      return value;
    }).onError((error, stackTrace) async {
      final ByteData bytes = await rootBundle.load(AVATAR_PLACEHOLDER);
      var value = bytes.buffer.asUint8List();
      if (username == user.userName) {
        userProfilePicture = value;
      }
      return value;
    });
  }
}
