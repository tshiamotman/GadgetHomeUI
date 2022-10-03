import 'package:flutter/cupertino.dart';
import 'package:gadgethome/apirequests/apirequests.dart';
import 'package:gadgethome/constants/constants.dart';
import 'package:gadgethome/models/ad.dart';
import 'package:gadgethome/models/user.dart';

class UserProvider extends ChangeNotifier {
  late User user;

  late String token;

  Map<String, List<Ad>> ads = {};
  Map response = {};

  bool loggedIn = false;

  UserProvider();

  void loginUser(String username, String password) {
    login(username, password).then((value) {
      response.addAll(value);

      if (response["error"] == false && response["message"] == "Logged In") {
        user = User.fromJson(response["user"]);
        token = response["token"];
        print("Logged in");
        loggedIn = true;
      } else {
        print("Login failed");
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
        token = response["token"];
        loggedIn = true;
        return true;
      }
      loggedIn = false;
      return false;
    });
  }

  List<Ad> getAllAds() {
    List<Ad> ads = [];
    getAds(token).then((value) {
      for (var ad in value) {
        ads.add(ad);
      }
    });
    return ads;
  }

  Future<List<Ad>> getAdsByKey(String keyword) async {
    List<Ad> adsList = [];
    getAdsByKeyword(keyword, token).then((value) {
      print("starting to fetch: $keyword");
      for (var ad in value) {
        adsList.add(ad);
      }
      ads.addAll({keyword: adsList});
      notifyListeners();
    });
    return adsList;
  }

  Ad? getAdId(int id) {
    Ad? ad;
    getAd(id, token).then((value) {
      ad = value;
    });

    return ad;
  }

  Future<bool> postAd(Map ad) {
    Map response = {};
    int id;
    return addPost(ad, token).then((value) {
      response.addAll(value);
      if (response["id"] != null) {
        id = response["id"];
        return true;
      }
      return false;
    });
  }
}
