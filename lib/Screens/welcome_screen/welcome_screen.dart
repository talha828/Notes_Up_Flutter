import 'package:flutter/material.dart';
import 'package:quick_notes/custome_widget/custome_scaffold.dart';
import 'package:quick_notes/globle_variable.dart';
import 'package:quick_notes/text_string_collection/text_string_collection.dart';

import '../../custome_widget/main_button.dart';
import '../../image_collection/A.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Scaffold(
        body: Column(
          crossAxisAlignment:CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(A.assets_book,scale: 2,),
            Text(TextCollection.text_welcome_to_note_up,style: TextStyle(fontSize:  width * 0.077,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
            Text(TextCollection.text_welcome_to_note_up_subtitle,style: TextStyle(fontWeight: FontWeight.w500,),textAlign: TextAlign.center,),
            MainButton(text: "SignUp",),
            MainButton(text: "LogIn",),
            SizedBox(height: 1,)
          ],
        ),
      ),
    );
  }
}
