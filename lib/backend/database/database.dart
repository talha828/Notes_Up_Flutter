import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Database {
  storeUserSignUpData(String name,String email,String password,String country,String city,String institute,String grade,var then) {
    if(country != null){
      if(city != null){
        if(institute != null){
          if(grade != null){
            FirebaseAuth _auth = FirebaseAuth.instance;
            FirebaseDatabase.instance
                .reference()
                .child("userinfo").child("userdetails")
                .set({
              _auth.currentUser.uid:{
                "name":name,
                "email":email,
                "password":password,
                "country":country,
                "city":city,
                "institute":institute,
                "grade":grade,
                "uid":_auth.currentUser.uid,
              }
            }).then(then).catchError((e){
              Fluttertoast.showToast(
                  msg: "Somethings went wrong",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            });
          }else{
            Fluttertoast.showToast(
                msg: "Please Enter your grade",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
          }else{
          Fluttertoast.showToast(
              msg: "Please Enter your institute name",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
        }else{
        Fluttertoast.showToast(
            msg: "Please Enter city name",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );
        }
      }else{
      Fluttertoast.showToast(
          msg: "Please Enter Country name",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );
      }
    }
}
