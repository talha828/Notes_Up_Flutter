class UserChatInfo{
  String sender;
  String name;
  String message;
  String uid;
  String timestamp;
  UserChatInfo();

  UserChatInfo.fromJson(Map<String,dynamic> json){
    sender=json["sender"];
    name=json["name"];
    message=json["message"];
    uid=json["uid"];
    timestamp=json["timestamp"];
  }

}