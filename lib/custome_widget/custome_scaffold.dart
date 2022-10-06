
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  CustomScaffold({this.body,this.appBar}); // and maybe other Scaffold properties

   Widget? body;
   AppBar? appBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appBar ,
      body: Container(child: this.body, decoration: BoxDecoration(gradient:
      LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xff8b86f7),
          Color(0xff8de1f0),
        ]
      )
      )),
    );
  }
}