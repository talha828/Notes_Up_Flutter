import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quick_notes/Screens/sign_up_screen/sign_up_screen.dart';
import 'package:quick_notes/constant/constant.dart';
import 'package:quick_notes/custome_widget/main_button.dart';
import 'package:quick_notes/globle_variable.dart';
import 'package:quick_notes/image_collection/A.dart';
import 'package:quick_notes/text_string_collection/text_string_collection.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController name=TextEditingController();
  TextEditingController email=TextEditingController();
  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    return SafeArea(child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.08),
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SvgPicture.asset(A.assets_login,width: width *0.4,height:width *0.5 ,),
              Text(
                TextCollection.text_login,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Remember Me",style: TextStyle(fontWeight: FontWeight.w500,color: themeColor1),textAlign: TextAlign.center,),
                  Text("Forget Password?",style: TextStyle(fontWeight: FontWeight.w500,color: themeColor1),textAlign: TextAlign.center,),
                ],
              ),
              SizedBox(
                height: 10,
              ),

              MainButton(
                  text: TextCollection.text_next,
                  onTap: () {}),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
