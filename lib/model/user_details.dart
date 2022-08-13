import 'package:flutter/cupertino.dart';

class UserDetails extends ChangeNotifier{
  String name;
  String email;
  String password;
  String country;
  String city;
  String institute;
  String grade;

  void saveData(String name,String email,String password,String country,String city,String institute,String grade){
    this.name=name;
    this.email=email;
    this.password=password;
    this.country=country;
    this.city=city;
    this.institute=institute;
    this.grade=grade;
  }

}