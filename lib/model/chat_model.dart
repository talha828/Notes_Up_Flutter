import 'package:flutter/cupertino.dart';
import 'package:quick_notes/model/chat_room_model.dart';

class ChatList extends ChangeNotifier{
  List<MessageModel>list=[];

  void addList(List<MessageModel>value){
    list.clear();
    value.sort((a, b) {
      return a.timestamp!.compareTo(b.timestamp!);
    });
    list.addAll(value);
    notifyListeners();
  }
  void clearList(){
    list.clear();
  }
}