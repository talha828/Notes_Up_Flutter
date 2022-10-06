import 'package:flutter/cupertino.dart';

class UserModel extends ChangeNotifier{
  String? name;
  String? email;
  String? password;

  void storeDetails(String name,String email,String password){
    this.name=name;
    this.email=email;
    this.password=password;
    notifyListeners();
  }

}