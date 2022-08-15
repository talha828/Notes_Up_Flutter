import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quick_notes/custome_widget/custome_scaffold.dart';
import 'package:quick_notes/globle_variable.dart';
import 'package:quick_notes/image_collection/A.dart';
import 'package:quick_notes/text_string_collection/text_string_collection.dart';

class ConnectWithOthers extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SvgPicture.asset(A.assets_connection, width: width * 0.7 ,height: width *0.5,),
            Text(TextCollection.text_connect_with_others,style: TextStyle(fontSize:  width * 0.08,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
            Text(TextCollection.text_share_your_notes_subtitle,style: TextStyle(fontWeight: FontWeight.w500,),textAlign: TextAlign.center,),
            SizedBox(height: 10,),
            //TODO :Main button
            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: width * 0.09),
            //   decoration: BoxDecoration(
            //   color: Color(0x9f6c63ff),
            //     borderRadius: BorderRadius.circular(5)
            //   ),
            //   padding: EdgeInsets.symmetric(vertical: width * 0.025),
            //   child:
            //   Text(TextCollection.text_next,style: TextStyle(fontSize: width * 0.06,color: Colors.white),textAlign: TextAlign.center,)
            //   ,)

          ],
        ),
      ),
    );
  }
}