import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:gadgethome/apirequests/apirequests.dart';
import 'package:gadgethome/constants/constants.dart';
import 'package:gadgethome/controllers/userprovider.dart';
import 'package:gadgethome/models/chat.dart';

class MessageProvider extends ChangeNotifier {
  UserProvider? userProvider;

  String? fcmToken;

  Map<String, List<Chat>> conversations = {};

  Map<String, Uint8List> profilePictures = {};

  MessageProvider(this.userProvider) {
    FirebaseMessaging.instance.onTokenRefresh.listen((value) {
      if (fcmToken != value && userProvider!.loggedIn) {
        updateDeviceId(userProvider!.user, value, BEARER_TOKEN);
      } else {
        fcmToken = value;
      }
    }).onError((err) {
      FirebaseMessaging.instance.deleteToken();
      getToken();
    });
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((value) {
      fcmToken = value;
      updateDeviceId(userProvider!.user, fcmToken!, BEARER_TOKEN);
    });
  }

  Future<List<List<Chat>>> getUserConversations() async {
    return getConversations(BEARER_TOKEN).then((value) {
      List<List<Chat>> conversations = [];
      this.conversations = value;
      value.forEach((key, value) {
        conversations.add(value);

        userProvider?.getProfilePicture(key).then((value) {
          profilePictures[key] = value;
        });
      });
      return conversations;
    });
  }
}
