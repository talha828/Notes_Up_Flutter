class UserChatInfo{
  String? sender;
  String? name;
  String? message;
  String? uid;
  String? timestamp;


  fromJson(Map<String,dynamic> json){
    sender=json["sender"];
    name=json["name"];
    message=json["message"];
    uid=json["uid"];
    timestamp=json["timestamp"];
  }

}