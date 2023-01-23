import 'dart:ffi';

import 'package:gadgethome/models/ad.dart';
import 'package:gadgethome/models/user.dart';

class Chat {
  Long? id;

  String message;

  String? messageId;

  String senderUsername;

  User? sender;

  String recipientUsername;

  User? recipient;

  DateTime? createdDate;

  DateTime? messageDelivered;

  DateTime? messageRead;

  Ad? post;

  Chat(this.message, this.senderUsername, this.recipientUsername, this.post);

  factory Chat.fromJson(Map<String, dynamic> json) {
    Chat chat = Chat(json["message"], json["senderUsername"],
        json["recipientUsername"], Ad.fromJson(json["post"]));

    chat.id = json["id"]!;
    chat.messageId = json["messageId"]!;
    chat.sender = User.fromJson(json["sender"]!);
    chat.recipient = User.fromJson(json["recipient"]!);
    chat.messageDelivered = json["messageDelivered"]!;
    chat.messageRead = json["messageRead"]!;

    return chat;
  }

  Map<String, dynamic> toJson() => {
        "id": id!,
        "message": message,
        "messageId": messageId!,
        "senderUsername": senderUsername,
        "sender": sender!,
        "recipientUsername": recipientUsername,
        "recipient": recipient!,
        "createdDate": createdDate,
        "messageDelivered": messageDelivered!,
        "messageRead": messageRead!,
        "post": post!
      };
}
