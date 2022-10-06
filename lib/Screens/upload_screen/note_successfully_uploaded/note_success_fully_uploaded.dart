import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quick_notes/Screens/main_screen/main_screen.dart';
import 'package:quick_notes/constant/constant.dart';
import 'package:quick_notes/custome_widget/main_button.dart';
import 'package:quick_notes/globle_variable.dart';
import 'package:quick_notes/image_collection/A.dart';
import 'package:quick_notes/text_string_collection/text_string_collection.dart';

class NoteSuccessfullyUploaded extends StatefulWidget {

  @override
  State<NoteSuccessfullyUploaded> createState() =>
      _NoteSuccessfullyUploadedState();
}

class _NoteSuccessfullyUploadedState extends State<NoteSuccessfullyUploaded> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.07),
            color: themeColor1.withOpacity(1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(
                  A.assets_success,
                  width: width * 0.8,
                  height: width * 0.4,
                ),

             Column(
               children: [
                 Text(
                   TextCollection.text_note_successfully_uploaded,
                   style: TextStyle(
                       color: Colors.white,
                       fontSize: width * 0.077, fontWeight: FontWeight.bold),textAlign: TextAlign.center,
                 ),
                 SizedBox(
                   height: height * 0.07,
                 ),
                 Text(TextCollection.text_note_successfully_uploaded_subtitle_1,style: TextStyle(color:Colors.white,fontWeight: FontWeight.w500,),textAlign: TextAlign.center,),
                 Text(TextCollection.text_note_successfully_uploaded_subtitle_2,style: TextStyle(color:Colors.white,fontWeight: FontWeight.w500,),textAlign: TextAlign.center,),
               ],
             ),
                MainButton(
                  text: TextCollection.text_next,
                  onTap: ()=>        Navigator.push(context, PageTransition(type: PageTransitionType.leftToRight,duration: Duration(milliseconds: 1500), child: MainScreen()))
  ),
              ],
            ),
          ),
    ));
  }
}
