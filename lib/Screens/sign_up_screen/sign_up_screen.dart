import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick_notes/custome_widget/main_button.dart';
import 'package:quick_notes/globle_variable.dart';
import 'package:quick_notes/text_string_collection/text_string_collection.dart';
import '../../image_collection/A.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            //TODO: remove height
            height: height,
            padding: EdgeInsets.symmetric(horizontal: width * 0.08),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SvgPicture.asset(A.assets_sign_up,width: width * 0.7 ,height: width *0.5,),
                Text(TextCollection.text_Sign_up,style: TextStyle(fontSize:  width * 0.077,fontWeight: FontWeight.bold),),
                QuickTextField(title: TextCollection.text_field_name,icon: Icons.person,hintText: TextCollection.text_field_name,onChange: (value){},controller:_controller,),
                QuickTextField(title: TextCollection.text_field_email,icon: Icons.person,hintText: TextCollection.text_field_email,onChange: (value){},controller:_controller,),
                QuickTextField(title: TextCollection.text_field_password,icon: Icons.person,hintText:  TextCollection.text_field_password,onChange: (value){},controller:_controller,),
                QuickTextField(title: TextCollection.text_field_confirm_password,icon: Icons.person,hintText: TextCollection.text_field_confirm_password,onChange: (value){},controller:_controller,),
                SizedBox(height: width * 0.02,),
                MainButton(text: TextCollection.text_Sign_up,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//TODO:// separate widget
class QuickTextField extends StatelessWidget {
  QuickTextField({this.title,this.onChange,this.controller,this.icon,this.hintText});
  var title;
  var hintText;
  var onChange;
  var controller;
  var icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: TextStyle(fontSize:  width * 0.05,fontWeight: FontWeight.w500,),textAlign: TextAlign.center,),
          SizedBox(
            height: width * 0.015,
          ),
          Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xff6c63ff)),
                  borderRadius: BorderRadius.circular(7)
              ),
              child: TextField(
                onChanged: onChange,
                  controller: controller,
                  textAlignVertical:TextAlignVertical.center,
                decoration: InputDecoration(
                  prefixIcon: Icon(icon),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  enabledBorder: InputBorder.none,
                  hintText: hintText,
                ),
              )),
        ],
      ),
    );
  }
}
