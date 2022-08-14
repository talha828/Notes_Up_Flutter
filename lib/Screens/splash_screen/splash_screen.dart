import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quick_notes/Screens/get_start_screen/share_your_collection_screen/share_your_collection_screen.dart';
import 'package:quick_notes/Screens/main_screen/main_screen.dart';
import 'package:quick_notes/custome_widget/custome_scaffold.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../globle_variable.dart';
import '../../image_collection/A.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   getLogin()async{
     SharedPreferences pref= await SharedPreferences.getInstance();
    String email= pref.getString("email");
    String password= pref.getString("password");
    if(email != null && password !=null){
      FirebaseAuth _auth= FirebaseAuth.instance;
      _auth.signInWithEmailAndPassword(email: email, password: password).then((value) =>       Navigator.push(context, PageTransition(type: PageTransitionType.leftToRight,duration: Duration(milliseconds: 1500), child: MainScreen()))
      ).catchError((e){
        Fluttertoast.showToast(
            msg: "Somethings went wrong, check your internet connection",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );
      });
    }
    else{
      Timer(Duration(seconds: 2),(){
      Navigator.push(context, PageTransition(type: PageTransitionType.leftToRight,duration: Duration(milliseconds: 1500), child: ShareYourCollection()));
      });
    }
   }
  @override
  void initState() {
     getLogin();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    return SafeArea(
        child:Scaffold(
          body: Container(
            child: Scaffold(
              body:Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Spacer(),
                  Image.asset(A.assets_logo,scale: 2,),
                  Spacer(),
                ],
              ),
            ),
          ),
        )

    );
  }
}
