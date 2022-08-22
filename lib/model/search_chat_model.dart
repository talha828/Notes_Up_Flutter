import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:quick_notes/model/user_details.dart';

class SearchChatModel extends ChangeNotifier{
  List<UsersDetails>detail=[];
  void storeUsers(var details){
    detail.add(details);
    notifyListeners();
  }
  void clearUser(){
    detail.clear();
    notifyListeners();
  }
}

class UsersDetails{
  String name;
  String email;
  String password;
  String country;
  String city;
  String institute;
  String grade;
  String uid;
  String timestamp;
  UsersDetails();
    UsersDetails.fromJson(Map<String,dynamic>json){
    this.name=json['name'];
    this.email=json['email'];
    this.password=json['password'];
    this.country=json['country'];
    this.city=json['city'];
    this.institute=json['institute'];
    this.grade=json['grade'];
    this.uid=json['uid'].toString()=="null"?json['receiver']:json['uid'];
    this.timestamp=json['timestamp'];
  }

}