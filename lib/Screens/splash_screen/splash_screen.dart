
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quick_notes/Screens/get_start_screen/share_your_collection_screen/share_your_collection_screen.dart';
import 'package:quick_notes/custome_widget/custome_scaffold.dart';
import 'package:quick_notes/image_collection/A.dart';

import '../../globle_variable.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(Duration(seconds: 2),()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ShareYourCollection())));
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
