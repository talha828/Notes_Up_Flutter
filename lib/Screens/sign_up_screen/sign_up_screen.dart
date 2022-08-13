import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:quick_notes/Screens/fill_details_screen/fill_details_screen.dart';
import 'package:quick_notes/Screens/welcome_screen/welcome_screen.dart';
import 'package:quick_notes/backend/auth/auth.dart';
import 'package:quick_notes/custome_widget/main_button.dart';
import 'package:quick_notes/globle_variable.dart';
import 'package:quick_notes/model/user_model.dart';
import 'package:quick_notes/text_string_collection/text_string_collection.dart';
import '../../image_collection/A.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: height,
            padding: EdgeInsets.symmetric(horizontal: width * 0.08),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SvgPicture.asset(
                  A.assets_sign_up,
                  width: width * 0.7,
                  height: width * 0.5,
                ),
                Text(
                  TextCollection.text_Sign_up,
                  style: TextStyle(
                      fontSize: width * 0.077, fontWeight: FontWeight.bold),
                ),
                QuickTextField(
                  title: TextCollection.text_field_name,
                  icon: Icons.person,
                  hintText: TextCollection.text_field_name,
                  onChange: (value) {},
                  controller: name,
                ),
                QuickTextField(
                  title: TextCollection.text_field_email,
                  icon: Icons.person,
                  hintText: TextCollection.text_field_email,
                  onChange: (value) {},
                  controller: email,
                ),
                QuickTextField(
                  title: TextCollection.text_field_password,
                  icon: Icons.person,
                  hintText: TextCollection.text_field_password,
                  onChange: (value) {},
                  controller: password,
                  obscureText: false,
                ),
                QuickTextField(
                  title: TextCollection.text_field_confirm_password,
                  icon: Icons.person,
                  hintText: TextCollection.text_field_confirm_password,
                  onChange: (value) {},
                  controller: confirmPassword,
                  obscureText: false,
                ),
                SizedBox(
                  height: width * 0.02,
                ),
                MainButton(
                  text: TextCollection.text_next,
                  onTap: () => Auth().firebaseSignUpWithEmail(name.text,
                      email.text, password.text, confirmPassword.text, (value) {
                    Provider.of<UserModel>(context, listen: false).storeDetails(
                        name.text,
                        email.text,
                        password.text); //TODO:// fill details Screen
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>FillYourDetailsScreen()));
                  }),
                )
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
  QuickTextField(
      {this.title,
      this.onChange,
      this.controller,
      this.icon,
      this.hintText,
      this.obscureText});
  var title;
  var hintText;
  var onChange;
  var controller;
  var icon;
  var obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: width * 0.05,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: width * 0.015,
          ),
          Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xff6c63ff)),
                  borderRadius: BorderRadius.circular(7)),
              child: TextField(
                obscureText: obscureText.toString() == "null" ? false : true,
                onChanged: onChange,
                controller: controller,
                textAlignVertical: TextAlignVertical.center,
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
