import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:quick_notes/Screens/main_screen/main_screen.dart';
import 'package:quick_notes/constant/constant.dart';
import 'package:quick_notes/globle_variable.dart';
import 'package:quick_notes/model/chat_model.dart';
import 'package:quick_notes/model/chat_room_model.dart';
import 'package:quick_notes/model/search_chat_model.dart';
import 'package:quick_notes/model/user_details.dart';

class ChatRoom extends StatefulWidget {
  UsersDetails friend;
  bool check;
  ChatRoom({this.friend,this.check});
  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  ScrollController scrollController=ScrollController();
  TextEditingController controller = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  getMessageData(bool value) {
    Provider.of<ChatList>(context,listen: false).clearList();
    if(value){
     List<MessageModel> list = [];
     DatabaseReference ref3 = FirebaseDatabase.instance
         .reference()
         .child('chatinfo')
         .child(_auth.currentUser.uid);
     Stream<Event> streams = ref3.onValue;
     streams.forEach((value) {
       value.snapshot.value.forEach((key, value) {
         list.clear();
         if (key.toString() == widget.friend.uid.toString()) {
           value.forEach((key, value) {
             list.add(
                 MessageModel.fromJson(new Map<String, dynamic>.from(value)));
             print(DateTime.fromMillisecondsSinceEpoch(
                 double.parse(list[0].timestamp).toInt() * 1000)
                 .toString()
                 .substring(11, 17));
             Provider.of<ChatList>(context,listen: false).addList(list);
             scrollController.animateTo(
                 scrollController.position.maxScrollExtent,
                 duration: Duration(milliseconds: 500),
                 curve: Curves.fastOutSlowIn);
           });
         }
       });
     });
   }
  }

  @override
  void initState() {
    super.initState();
    getMessageData(widget.check);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<UserDetails>(context);
    var list = Provider.of<ChatList>(context).list;
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            widget.friend.name,
            style: TextStyle(color: themeColor1),
          ),
          leading: InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen())),
              child: Icon(
                Icons.arrow_back_ios,
                color: themeColor1,
              )),
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: width * 0.02),
                    child: ListView.separated(
                      controller:scrollController,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.02),
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    _auth.currentUser.uid != list[index].sender
                                        ? MainAxisAlignment.start
                                        : MainAxisAlignment.end,
                                children: [
                                  _auth.currentUser.uid != list[index].sender
                                      ? Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              border: Border.all(
                                                  color: themeColor1)),
                                          child: CircleAvatar(
                                            backgroundColor:
                                                _auth.currentUser.uid !=
                                                        list[index].sender
                                                    ? themeColor1
                                                    : Colors.transparent,
                                            radius: 15,
                                            child: Text(
                                              widget.friend.name
                                                  .substring(0, 1),
                                              style: TextStyle(
                                                  color:
                                                      _auth.currentUser.uid !=
                                                              list[index].sender
                                                          ? Colors.white
                                                          : themeColor1),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  _auth.currentUser.uid != list[index].sender
                                      ? SizedBox(
                                          width: width * 0.02,
                                        )
                                      : Container(),
                                  Container(
                                    width: width * 0.6,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: _auth.currentUser.uid !=
                                                list[index].sender
                                            ? Colors.white
                                            : themeColor1,
                                        border: Border.all(color:themeColor1),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: width * 0.02,
                                          horizontal: width * 0.04),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              child: Flexible(
                                                  child: Text(
                                            list[index].message,
                                            style: TextStyle(
                                                color: _auth.currentUser.uid !=
                                                        list[index].sender
                                                    ? themeColor1
                                                    : Colors.white),
                                          ))),
                                          Text(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                    double.parse(list[index]
                                                            .timestamp)
                                                        .toInt())
                                                .toString()
                                                .substring(11, 16),
                                            style: TextStyle(
                                                color: _auth.currentUser.uid !=
                                                        list[index].sender
                                                    ? themeColor1
                                                    : Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  _auth.currentUser.uid == list[index].sender
                                      ? SizedBox(
                                          width: width * 0.02,
                                        )
                                      : Container(),
                                  _auth.currentUser.uid == list[index].sender
                                      ? Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              border: Border.all(
                                                  color: themeColor1)),
                                          child: CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            radius: 15,
                                            child: Text(
                                              data.name.substring(0, 1),
                                              style:
                                                  TextStyle(color: themeColor1),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: width * 0.03,
                          );
                        },
                        itemCount: list.length)),
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
                padding: EdgeInsets.symmetric(
                    vertical: width * 0.04, horizontal: width * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: width * 0.7,
                      decoration: BoxDecoration(
                          border: Border.all(color: themeColor1),
                          borderRadius: BorderRadius.circular(width * 0.1)),
                      child: TextField(
                        controller: controller,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: "Type Here...",
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: width * 0.04)),
                      ),
                    ),
                    InkWell(
                      onTap: () async{
                        var timestamp= DateTime.now().millisecondsSinceEpoch.toString();
                        FirebaseAuth _auth = FirebaseAuth.instance;
                        await  FirebaseDatabase.instance
                            .reference()
                            .child("chatinfo")
                            .child(_auth.currentUser.uid)
                            .child(widget.friend.uid)
                            .child(timestamp)
                            .set({
                          "timestamp":
                          timestamp,
                          "message": controller.text,
                          "sender": _auth.currentUser.uid,
                        });
                        await  FirebaseDatabase.instance
                            .reference()
                            .child("chatinfo")
                            .child(widget.friend.uid)
                            .child(_auth.currentUser.uid)
                            .child(timestamp)
                            .set({
                          "timestamp":
                          timestamp,
                          "message": controller.text,
                          "sender": _auth.currentUser.uid,
                        });
                        var rr1=await FirebaseDatabase.instance
                            .reference()
                            .child("chatuserinfo")
                            .child(widget.friend.uid)
                            .child(_auth.currentUser.uid)
                            .set({
                          "name": data.name,
                          "timestamp":
                          timestamp.toString(),
                          "message": controller.text,
                          "receiver":widget.friend.uid,
                          "sender": _auth.currentUser.uid,
                        }).then((value) async{
                          await FirebaseDatabase.instance
                              .reference()
                              .child("chatuserinfo")
                              .child(_auth.currentUser.uid)
                              .child(widget.friend.uid)
                              .set({
                            "name": widget.friend.name,
                            "timestamp":
                            timestamp.toString() ,
                            "message": controller.text,
                            "sender": _auth.currentUser.uid,
                            "receiver":widget.friend.uid,
                          }).then((value) {
                            getMessageData(true);
                            controller.clear();});
                        });

                      },
                      child: CircleAvatar(
                        backgroundColor: themeColor1,
                        radius: width * 0.09,
                        child: RotationTransition(
                            turns: AlwaysStoppedAnimation(340 / 365),
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                            )),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
