import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quick_notes/Screens/main_screen/main_screen.dart';
import 'package:quick_notes/Screens/sign_up_screen/sign_up_screen.dart';
import 'package:quick_notes/backend/auth/auth.dart';
import 'package:quick_notes/constant/constant.dart';
import 'package:quick_notes/custome_widget/main_button.dart';
import 'package:quick_notes/globle_variable.dart';
import 'package:quick_notes/image_collection/A.dart';
import 'package:quick_notes/text_string_collection/text_string_collection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController password=TextEditingController();
  TextEditingController email=TextEditingController();
  bool value = true;
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    return SafeArea(child: Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: width * 0.08),
              height: height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: width * 0.02,
                  ),
                  SvgPicture.asset(A.assets_login,width: width *0.4,height:width *0.5 ,),
                  Text(
                    TextCollection.text_login,
                    style: TextStyle(
                        fontSize: width * 0.077, fontWeight: FontWeight.bold),
                  ),
                  QuickTextField(
                    title: TextCollection.text_field_email,
                    icon: Icons.email,
                    hintText: TextCollection.text_field_email,
                    onChange: (value) {},
                    controller: email,
                  ),
                  QuickTextField(
                    title: TextCollection.text_field_password,
                    icon: Icons.password,
                    hintText: TextCollection.text_field_name,
                    onChange: (value) {},
                    controller: password,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(child: Row(
                        children: [
                          Checkbox(
                            activeColor: themeColor1,
                            value: this.value,
                            onChanged: (bool value) {
                              setState(() {
                                this.value = value;
                              });
                            },
                          ),
                          Text(TextCollection.text_Remember_Me,style: TextStyle(fontWeight: FontWeight.w500,color: themeColor1),textAlign: TextAlign.center,),
                        ],
                      )),
                      InkWell(
                          onTap: (){
                            FirebaseAuth _auth=FirebaseAuth.instance;
                            _auth.sendPasswordResetEmail(email: email.text).then((value) {
                              Fluttertoast.showToast(
                                  msg: "Check your Email",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            }).catchError((e)=>{
                            Fluttertoast.showToast(
                            msg: "Somethings went wrong",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0
                            )
                            });
                          },
                          child: Text(TextCollection.text_Forget_Password,style: TextStyle(fontWeight: FontWeight.w500,color: themeColor1),textAlign: TextAlign.center,)),
                    ],
                  ),
                  SizedBox(
                    height: width * 0.02,
                  ),

                  MainButton(
                    text: TextCollection.text_next,
                    onTap: ()=>Auth.loginUser(email.text,password.text,(value){
                      setState(() {
                        isLoading=value;
                      });
                    },(value)async{SharedPreferences pref= await SharedPreferences.getInstance();
                    pref.setString("email", email.text);
                    pref.setString("password", password.text);
                      Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft,duration: Duration(milliseconds: 1000), child: MainScreen()));
                    },),),
                  SizedBox(
                    height: width * 0.02,
                  ),
                  SizedBox(
                    height: width * 0.02,
                  ),
                ],
              ),
            ),
          ),
          isLoading?Positioned.fill(child: LoadingIndicator()):Container()
        ],
      )
    ));
  }
}
