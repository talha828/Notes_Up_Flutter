import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:quick_notes/constant/constant.dart';
import 'package:quick_notes/globle_variable.dart';
import 'package:quick_notes/model/chat_room_model.dart';
import 'package:quick_notes/model/search_chat_model.dart';

class ChatRoom extends StatefulWidget {
  UsersDetails friend;
  ChatRoom({this.friend});
  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  TextEditingController controller =TextEditingController();
  List<MessageModel>list=[];
  getMessageData(){
    FirebaseAuth _auth=FirebaseAuth.instance;
    DatabaseReference ref3 =
    FirebaseDatabase.instance.reference().child('chatinfo').child(_auth.currentUser.uid);
    Stream<Event> streams = ref3.onValue;
    streams.forEach((value) {
      list.clear();
      value.snapshot.value.forEach((key,value){
       if(key.toString()==widget.friend.uid.toString()){
         value.forEach((key,value){
          list.add(MessageModel.fromJson(new Map<String,dynamic>.from(value)));
         });
       }
      });

    });
  }
  @override
  void initState() {
    getMessageData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(widget.friend.name,style: TextStyle(
            color: themeColor1
          ),),
        leading: InkWell(
            onTap: ()=>Navigator.pop(context),
            child: Icon(Icons.arrow_back_ios,color: themeColor1,)),
        ),
        body:Container(
         // padding: EdgeInsets.symmetric(vertical: width * 0.02),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  child:ListView.builder(
                        itemBuilder:(context,index){
                          return Container(
                            child:Container(),
                          )
                        }
                  ) ,
                ),
              ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              height: width * 0.2,
              padding: EdgeInsets.symmetric(vertical: width * 0.04,horizontal: width * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: width * 0.7,
                    decoration: BoxDecoration(
                        border: Border.all(color: themeColor1),
                        borderRadius: BorderRadius.circular(width * 0.1)
                    ),
                    child:TextField(
                      controller: controller,
                      onChanged: (value){},
                      decoration: InputDecoration(
                        border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: "Type Here...",
                          contentPadding: EdgeInsets.symmetric(horizontal: width * 0.04)
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      FirebaseAuth _auth = FirebaseAuth.instance;
                      FirebaseDatabase.instance
                          .reference()
                          .child("chatinfo").child(_auth.currentUser.uid).child(widget.friend.uid)
                          .child(DateTime.now().millisecondsSinceEpoch.toString()).
                          set({
                          "timestamp":DateTime.now().millisecondsSinceEpoch.toString(),
                          "message":controller.text,
                          "sender":_auth.currentUser.uid,
                      });
                      FirebaseDatabase.instance
                          .reference()
                          .child("chatinfo").child(widget.friend.uid).child(_auth.currentUser.uid)
                          .child(DateTime.now().millisecondsSinceEpoch.toString()).
                      set({
                        "timestamp":DateTime.now().millisecondsSinceEpoch.toString(),
                        "message":controller.text,
                        "sender":_auth.currentUser.uid,
                      });
                      FirebaseDatabase.instance
                          .reference()
                          .child("chatuserinfo").child(widget.friend.uid).child(_auth.currentUser.uid)
                          .
                      set({
                        "name":widget.friend.name,
                        "timestamp":DateTime.now().millisecondsSinceEpoch.toString(),
                        "message":controller.text,
                        "sender":_auth.currentUser.uid,
                      });
                      FirebaseDatabase.instance
                          .reference()
                          .child("chatuserinfo").child(_auth.currentUser.uid).child(widget.friend.uid)
                          .
                      set({
                        "name":widget.friend.name,
                        "timestamp":DateTime.now().millisecondsSinceEpoch.toString(),
                        "message":controller.text,
                        "sender":_auth.currentUser.uid,
                      });
                      controller.clear();
                    },
                    child: CircleAvatar(
                      backgroundColor: themeColor1,
                      radius: width * 0.09,
                      child: RotationTransition(
                          turns: AlwaysStoppedAnimation(340/365),
                          child: Icon(Icons.send,color: Colors.white,)),
                    ),
                  )
                ],
              ),
            )
            ],
          ),
        ) ,
      ),
    );
  }
}
