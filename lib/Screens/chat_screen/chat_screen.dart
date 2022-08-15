
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick_notes/globle_variable.dart';
import 'package:quick_notes/image_collection/A.dart';
import 'package:quick_notes/text_string_collection/text_string_collection.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SvgPicture.asset(A.assets_empty_chat,width: width * 0.5,height: width *0.4,),
          SizedBox(
            height:width * 0.06 ,
          ),
          Text(TextCollection.text_no_message,style: TextStyle(fontSize: width * 0.06,fontWeight: FontWeight.w100),textAlign: TextAlign.center,),
          SizedBox(
            height:width * 0.04 ,
          ),
          Text(TextCollection.text_no_message_subtitle_1,style: TextStyle(fontWeight: FontWeight.w500,),textAlign: TextAlign.center,),
          Text(TextCollection.text_no_message_subtitle_2,style: TextStyle(fontWeight: FontWeight.w500,),textAlign: TextAlign.center,),


        ],
      ),
    );
  }
}


