import 'package:flutter/material.dart';
import 'package:quick_notes/globle_variable.dart';
class MainButton extends StatelessWidget{
  MainButton({this.onTap,this.text});
  var onTap;
  var text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: width * 0.09),
        decoration: BoxDecoration(
            color: Color(0xff6c63ff),
            borderRadius: BorderRadius.circular(5)
        ),
        padding: EdgeInsets.symmetric(vertical: width * 0.025),
        child:
        Text(text,style: TextStyle(fontSize: width * 0.06,color: Colors.white,fontWeight: FontWeight.w100),textAlign: TextAlign.center,)
        ,),
    );
  }
}