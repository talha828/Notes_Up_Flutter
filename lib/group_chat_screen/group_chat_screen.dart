import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick_notes/Screens/search_chat/search_chat.dart';
import 'package:quick_notes/constant/constant.dart';
import 'package:quick_notes/image_collection/A.dart';
import 'package:quick_notes/text_string_collection/text_string_collection.dart';

import '../globle_variable.dart';

class GroupChatScreen extends StatefulWidget {
  const GroupChatScreen({Key key}) : super(key: key);

  @override
  State<GroupChatScreen> createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SvgPicture.asset(A.assets_empty_chat,width: width * 0.5,height: width *0.4,),
          SizedBox(
            height:width * 0.06 ,
          ),
          Text("Group Chat",style: TextStyle(fontSize: width * 0.06,fontWeight: FontWeight.w100),textAlign: TextAlign.center,),
          SizedBox(
            height:width * 0.04 ,
          ),
           Text("this feature will introduces soon",style: TextStyle(fontWeight: FontWeight.w500,),textAlign: TextAlign.center,),
          // Text(TextCollection.text_no_message_subtitle_2,style: TextStyle(fontWeight: FontWeight.w500,),textAlign: TextAlign.center,),
          // SizedBox(
          //   height:width * 0.06 ,
          // ),
          // Container(
          //   alignment: Alignment.center,
          //   child: InkWell(
          //     onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatSearch())),
          //     child: Container(
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(width * 0.02),
          //         color: themeColor1,
          //
          //       ),
          //       width: width * 0.4,
          //       padding: EdgeInsets.symmetric(vertical: width * 0.02,horizontal: width * 0.02),
          //       child: Row(
          //         children: [
          //           Icon(Icons.search,color: Colors.white,),
          //           SizedBox(
          //             width:width * 0.02 ,
          //           ),
          //           Text("Search Now",style: TextStyle(color: Colors.white),)
          //         ],
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
