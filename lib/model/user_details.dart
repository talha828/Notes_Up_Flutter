import 'package:flutter/cupertino.dart';

class UserDetails extends ChangeNotifier{
  String name;
  String email;
  String password;
  String country;
  String city;
  String institute;
  String grade;

  void saveData(Map<String,dynamic>json){
    this.name=json['name'];
    this.email=json['email'];
    this.password=json['password'];
    this.country=json['country'];
    this.city=json['city'];
    this.institute=json['institute'];
    this.grade=json['grade'];
    notifyListeners();
  }

}