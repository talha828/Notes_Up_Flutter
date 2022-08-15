
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quick_notes/Screens/welcome_screen/welcome_screen.dart';
import 'package:quick_notes/custome_widget/custome_scaffold.dart';
import 'package:quick_notes/custome_widget/main_button.dart';
import 'package:quick_notes/globle_variable.dart';
import 'package:quick_notes/image_collection/A.dart';
import 'package:quick_notes/text_string_collection/text_string_collection.dart';

class ChatWithFriend extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Scaffold(
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SvgPicture.asset(A.assets_share, width: width * 0.7 ,height: width *0.5,),
                  Text(TextCollection.text_Chat_with_Friend,style: TextStyle(fontSize:  width * 0.08,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
                  Text(TextCollection.text_Chat_with_Friend_subtitle,style: TextStyle(fontWeight: FontWeight.w500,),textAlign: TextAlign.center,),
                  MainButton(text: TextCollection.text_next,onTap: ()=>    Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft,duration: Duration(milliseconds: 1000), child: WelcomeScreen())),
                  )])),
      ),
    );
  }
}