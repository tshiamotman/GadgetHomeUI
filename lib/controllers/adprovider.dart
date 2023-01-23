import 'package:flutter/widgets.dart';
import 'package:gadgethome/apirequests/apirequests.dart';
import 'package:gadgethome/constants/constants.dart';
import 'package:gadgethome/models/ad.dart';

class AdProvider extends ChangeNotifier {
  Map<String, List<Ad>> ads = {};

  AdProvider();

  List<Ad> getAllAds(int page) {
    List<Ad> ads = [];
    getAds(BEARER_TOKEN, page).then((value) {
      for (var ad in value) {
        ads.add(ad);
      }
    });
    return ads;
  }

  Future<List<Ad>> getAdsByKey(String keyword) async {
    List<Ad> adsList = [];
    getAdsByKeyword(keyword, BEARER_TOKEN).then((value) {
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
    getAd(id, BEARER_TOKEN).then((value) {
      ad = value;
    });

    return ad;
  }

  Future<bool> postAd(Map ad) {
    Map response = {};
    int id;
    return addPost(ad, BEARER_TOKEN).then((value) {
      response.addAll(value);
      if (response["id"] != null) {
        id = response["id"];
        return true;
      }
      return false;
    });
  }
}
