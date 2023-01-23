import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:gadgethome/constants/constants.dart';
import 'package:gadgethome/models/ad.dart';
import 'package:gadgethome/models/chat.dart';
import 'package:gadgethome/models/user.dart';
import 'package:http/http.dart' as http;

Future<Map> login(String username, String password) async {
  final response = await http.post(Uri.parse('$API_URL/auth/login'),
      headers: {
        HttpHeaders.authorizationHeader: 'authorization',
        "Content-Type": "application/json"
      },
      body: jsonEncode({'user_name': username, 'password': password}));

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to login');
  }
}

Future<Map> register(User user) async {
  final response = await http.post(Uri.parse('$API_URL/auth/register'),
      headers: {
        HttpHeaders.authorizationHeader: 'authorization',
        "Content-Type": "application/json"
      },
      body: jsonEncode(user));

  print(response.body);

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to login');
  }
}

Future<List<Ad>> getAds(String token, int page) async {
  var response = await http.get(
    Uri.parse('$API_URL/ads/posts'),
    headers: {
      HttpHeaders.authorizationHeader: "Bearer $token",
    },
  );

  print(response);

  if (response.statusCode == 200) {
    List adsList = jsonDecode(response.body);
    List<Ad> ads = [];

    for (int i = 0; i < adsList.length; ++i) {
      ads.add(Ad.fromJson(adsList[i]));

      response = await http.get(
        Uri.parse("$API_URL/images/${ads[i].id}"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );

      Uint8List image = jsonDecode(response.body);
      ads[i].addImage(image);
    }

    return ads;
  } else {
    throw Exception('Failed to load ads');
  }
}

Future<List<Ad>> getAdsByKeyword(String keyword, String token) async {
  print("getting ads: $keyword");
  var response = await http.get(
    Uri.parse('$API_URL/ads/posts/key/$keyword'),
    headers: {
      HttpHeaders.authorizationHeader: "Bearer $token",
    },
  );

  print(response.body);

  if (response.statusCode == 200) {
    List adsList = jsonDecode(response.body);
    List<Ad> ads = [];

    for (int i = 0; i < adsList.length; ++i) {
      ads.add(Ad.fromJson(adsList[i]));

      response = await http.get(
        Uri.parse("$API_URL/images/${ads[i].id}"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );

      Uint8List image = base64Decode(base64.encode(response.bodyBytes));
      ads[i].addImage(image);
    }
    print(ads.length);

    return ads;
  } else {
    throw Exception('Failed to load ads');
  }
}

Future<Ad> getAd(int id, String token) async {
  var response = await http.get(
    Uri.parse('$API_URL/ads/posts/id/$id'),
    headers: {
      HttpHeaders.authorizationHeader: "Bearer $token",
    },
  );
  Ad ad;

  print(response);

  if (response.statusCode == 200) {
    ad = Ad.fromJson(jsonDecode(response.body));

    response = await http.get(
      Uri.parse('$API_URL/images/images/$id'),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    );

    List<Uint8List> images = jsonDecode(response.body);

    for (Uint8List image in images) {
      ad.addImage(image);
    }

    return ad;
  } else {
    throw Exception('Failed to load ad');
  }
}

Future<Map> addPost(Map ad, String token) async {
  var response = await http.post(Uri.parse("$API_URL/ads/posts"),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
        "Content-Type": "application/json"
      },
      body: jsonEncode(ad));

  print(response.body);

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to post Ad');
  }
}

Future<Map> updateDeviceId(
    User user, String fcmToken, String bearerToken) async {
  Map<String, String> requestBody = user.toJson();
  requestBody.addAll({"token": fcmToken});
  final response = await http.post(Uri.parse('$API_URL/chat/updateDeviceId'),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $bearerToken",
        "Content-Type": "application/json"
      },
      body: jsonEncode(requestBody));

  print(response.body);

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to login');
  }
}

Future<Map> updateMessageRead(String messageId, String bearerToken) async {
  final response = await http
      .get(Uri.parse('$API_URL/chat/messageRead/$messageId'), headers: {
    HttpHeaders.authorizationHeader: "Bearer $bearerToken",
    "Content-Type": "application/json"
  });

  print(response.body);

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to login');
  }
}

Future<Map> sendMessage(Chat chat, String bearerToken) async {
  Map<String, dynamic> requestBody = chat.toJson();
  final response = await http.post(Uri.parse('$API_URL/sendMessage'),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $bearerToken",
        "Content-Type": "application/json"
      },
      body: jsonEncode(requestBody));

  print(response.body);

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to login');
  }
}

Future<Map<String, List<Chat>>> getConversations(String token) async {
  final response = await http.get(
    Uri.parse('$API_URL/chat/getConversations'),
    headers: {
      HttpHeaders.authorizationHeader: "Bearer $token",
      "Content-Type": "application/json"
    },
  );

  print(response.body);

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to login');
  }
}

Future<Uint8List> getUserImage(String username, String token) async {
  final response = await http.get(
    Uri.parse("$API_URL/user/getUser/$username"),
    headers: {
      HttpHeaders.authorizationHeader: "Bearer $token",
    },
  );

  Uint8List image = base64Decode(base64.encode(response.bodyBytes));

  if (response.statusCode == 200) {
    return image;
  } else {
    throw Exception('Failed to login');
  }
}

Future<Map> addUserImage(File image) async {
  String url = '$API_URL/user/addPicture';
  var bytes = image.readAsBytesSync();

  final response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "multipart/form-data"},
      body: {"lang": "fas", "image": bytes},
      encoding: Encoding.getByName("utf-8"));

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to login');
  }
}
