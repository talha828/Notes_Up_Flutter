import 'package:flutter/material.dart';
import 'package:quick_notes/Screens/login_screen/login_screen.dart';
import 'package:quick_notes/globle_variable.dart';
import 'package:quick_notes/text_string_collection/text_string_collection.dart';
import '../../custome_widget/main_button.dart';
import '../../image_collection/A.dart';
import '../sign_up_screen/sign_up_screen.dart';
import 'package:page_transition/page_transition.dart';

class WelcomeScreen extends StatefulWidget {

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(A.assets_book,scale: 2,),
              Text(TextCollection.text_welcome_to_note_up,style: TextStyle(fontSize:  width * 0.077,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              Text(TextCollection.text_welcome_to_note_up_subtitle,style: TextStyle(fontWeight: FontWeight.w500,),textAlign: TextAlign.center,),
              MainButton(text: "SignUp",onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen())),),
              MainButton(text: "LogIn",onTap: ()=> Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginScreen())),),
              SizedBox(height: 1,)
            ],
          ),
        ),
      ),
    );
  }
}
