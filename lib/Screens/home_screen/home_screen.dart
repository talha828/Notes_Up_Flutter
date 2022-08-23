import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:quick_notes/Screens/chat_screen/chat_screen.dart';
import 'package:quick_notes/Screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:quick_notes/Screens/upload_screen/upload_screen.dart';
import 'package:quick_notes/constant/constant.dart';
import 'package:quick_notes/globle_variable.dart';
import 'package:quick_notes/image_collection/A.dart';
import 'package:quick_notes/model/user_details.dart';

import '../notes_search.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var data=Provider.of<UserDetails>(context);
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HomeScreenCard(
                onTap: (){
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.INFO,
                    animType: AnimType.BOTTOMSLIDE,
                    title: 'Coming Soon',
                    desc: "this feature will add on next version",
                    btnOkColor: themeColor1,
                    btnOkOnPress: () {},
                  )..show();
                },
                title: "Find School",
                image: A.assets_sign_up,
              ),
              HomeScreenCard(
                onTap: ()=> Navigator.push(context,MaterialPageRoute(builder: (context)=>UploadScreen())),
                title: "Upload Notes",
                image: A.assets_search_notes,
              ),
            ],
          ),
          // SizedBox(
          //   height: width * 0.07
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HomeScreenCard(
                title: "your Trades",
                image: A.assets_empty_chat,
                onTap: (){
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.INFO,
                    animType: AnimType.BOTTOMSLIDE,
                    title: 'Coming Soon',
                    desc: "this feature will add on next version",
                    btnOkColor: themeColor1,
                    btnOkOnPress: () {},
                  )..show();
                },
              ),
              HomeScreenCard(
                title: "Edit Profile",
                image: A.assets_profile,
                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen(data: data,))),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class HomeScreenCard extends StatelessWidget {
  String image;
  String title;
  var onTap;
  HomeScreenCard({this.image, this.onTap, this.title});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: width * 0.02,horizontal: width * 0.02),
        padding: EdgeInsets.symmetric(
            vertical: width * 0.06, horizontal: width * 0.025),
        decoration: BoxDecoration(
            color: themeColor1.withOpacity(0.1),
            borderRadius: BorderRadius.circular(width * 0.02)),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              image,
              width: width * 0.35,
              height: width * 0.2,
            ),
            SizedBox(
              height: width * 0.04,
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: width * 0.045, fontWeight: FontWeight.w100),
            ),
            SizedBox(
              height: width * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}
