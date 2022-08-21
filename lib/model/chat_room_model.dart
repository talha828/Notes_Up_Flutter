import 'package:flutter/material.dart';

class ChatRoomModel extends ChangeNotifier{
  List<MessageModel>message=[];

  void collectMessage(List<MessageModel>value){
    message.clear();
    message.addAll(value);
  }
}

class MessageModel{
  String sender;
  String message;
  String timestamp;
  MessageModel();

  MessageModel.fromJson(Map<String,dynamic>json){
    sender=json["sender"];
    message=json['message'];
    timestamp=json['timestamp'];
  }
}