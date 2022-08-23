
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quick_notes/Screens/chat_room/chat_room_screen.dart';
import 'package:quick_notes/Screens/search_chat/search_chat.dart';
import 'package:quick_notes/constant/constant.dart';
import 'package:quick_notes/globle_variable.dart';
import 'package:quick_notes/image_collection/A.dart';
import 'package:quick_notes/model/chat_model.dart';
import 'package:quick_notes/model/search_chat_model.dart';
import 'package:quick_notes/model/user_chat_info.dart';
import 'package:quick_notes/model/user_details.dart';
import 'package:quick_notes/text_string_collection/text_string_collection.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  List<UserChatInfo>chat=[];
  List<UsersDetails>list=[];
 getUsers(){
   DatabaseReference ref3 = FirebaseDatabase.instance
       .reference()
       .child('chatuserinfo')
       .child(_auth.currentUser.uid);
   Stream<Event> streams = ref3.onValue;
   streams.forEach((value) {
     list.clear();
     chat.clear();
     print(value.snapshot.value.toString());
     value.snapshot.value.forEach((key,value){

       print(value.toString());
       list.add(UsersDetails.fromJson(Map<String,dynamic>.from(value)));
       chat.add(UserChatInfo.fromJson(Map<String,dynamic>.from(value)));
       list.sort((a,b){return a.timestamp.compareTo(b.timestamp);});
       chat.sort((a,b){return a.timestamp.compareTo(b.timestamp);});

       setState(() {});
     });
   });
 }
  @override
  void initState() {
    super.initState();
    getUsers();
  }
  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    var data=Provider.of<SearchChatModel>(context).detail;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: themeColor1),
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            "Chat Board",
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                color: themeColor1,
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(width * 00.02),
            child: IconButton(
              icon:Icon( Icons.search,
                  color: Colors.white),
              onPressed: (){},
            ),
          )
        ],
      ),
      body: chat.length<1?
      Column(
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
          SizedBox(
            height:width * 0.06 ,
          ),
          Container(
            alignment: Alignment.center,
            child: InkWell(
              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatSearch())),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width * 0.02),
                  color: themeColor1,

                ),
                width: width * 0.4,
                padding: EdgeInsets.symmetric(vertical: width * 0.02,horizontal: width * 0.02),
                child: Row(
                  children: [
                    Icon(Icons.search,color: Colors.white,),
                    SizedBox(
                      width:width * 0.02 ,
                    ),
                    Text("Search Now",style: TextStyle(color: Colors.white),)
                  ],
                ),
              ),
            ),
          )
        ],
      ):
          Column(
            children: [
              SizedBox(height: width * 0.02,),
              InkWell(
                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatSearch())),
                child: Container(
                  width: width * 0.9,
                  decoration: BoxDecoration(
                      border: Border.all(color: themeColor1),
                      borderRadius: BorderRadius.circular(width * 0.01)
                  ),
                  child:TextField(
                    enabled: false,
                    onChanged: (value){},
                    decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        hintText: "Search Friend Name",
                        contentPadding: EdgeInsets.symmetric(horizontal: width * 0.04)
                    ),
                  ),
                ),
              ),
              Container(
                child: 
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: chat.length,
                  itemBuilder: (context,index){
                    return ListTile(
                      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatRoom(friend: list[index],check: true,))),
                      contentPadding: EdgeInsets.symmetric(vertical: width * 0.05,horizontal: width * 0.05),
                      leading: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: themeColor1),
                          borderRadius: BorderRadius.circular(50)
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Text(chat[index].name.substring(0,1).toUpperCase(),style: TextStyle(
                            fontSize: width * 0.06,
                            fontWeight: FontWeight.bold,
                            color: themeColor1
                          ),),
                        ),
                      ),
                      title: Text(chat[index].name.toUpperCase()),
                      subtitle: Text(chat[index].message.length>20?chat[index].message.substring(0,20)+"...":chat[index].message),
                      trailing: Text( DateTime.fromMillisecondsSinceEpoch(
                          double.parse(chat[index]
                              .timestamp)
                              .toInt())
                          .toString()
                          .substring(11, 16),style: TextStyle(
                        color: Colors.grey
                      ),),
                    );},),
              )
            ],
          )
    );
  }
}


