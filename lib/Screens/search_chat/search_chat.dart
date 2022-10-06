import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quick_notes/Screens/chat_room/chat_room_screen.dart';
import 'package:quick_notes/Screens/sign_up_screen/sign_up_screen.dart';
import 'package:quick_notes/constant/constant.dart';
import 'package:quick_notes/globle_variable.dart';
import 'package:quick_notes/image_collection/A.dart';
import 'package:quick_notes/model/search_chat_model.dart';
import 'package:quick_notes/model/search_notes.dart';
import 'package:quick_notes/text_string_collection/text_string_collection.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatSearch extends StatefulWidget {
  @override
  State<ChatSearch> createState() => _ChatSearchState();
}

class _ChatSearchState extends State<ChatSearch> {
  TextEditingController search=TextEditingController();

  getUserData()async{
    FirebaseAuth _auth=FirebaseAuth.instance;
    Provider.of<SearchChatModel>(context,listen: false).clearUser();
    List<UsersDetails>list=[];
    DatabaseReference ref3 =
    FirebaseDatabase.instance.reference().child('userinfo');
    Stream<Event> streams = ref3.onValue;
    streams.forEach((value) {
      print(value.snapshot.key);
      print(value.snapshot.value.toString());
      value.snapshot.value.forEach((key,value){
        print(key);
        print(value.toString());
        Provider.of<SearchChatModel>(context,listen: false).storeUsers(UsersDetails().fromJson(new Map<String,dynamic>.from(value["details"])));
      });
    });
  }
  @override
  void initState() {
    getUserData();
    super.initState();
  }
  List<UsersDetails>file=[];
  @override
  Widget build(BuildContext context) {
    width =MediaQuery.of(context).size.width;
    var data=Provider.of<SearchChatModel>(context).detail;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: themeColor1),
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: ()=>Navigator.pop(context),
            child: Icon(Icons.arrow_back_ios_rounded,color: themeColor1,)),
        title: Center(
          child: Text(
            "Search Friend",
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
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: width * 0.07,vertical: width * 0.07),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: themeColor1),
                  borderRadius: BorderRadius.circular(width * 0.01)
              ),
              child:TextField(
                onChanged: (value){
                  file.clear();
                  for(int i=0;i<data.length;i++){
                    if(data[i].name!.contains(value)){
                      file.add(data[i]);
                    }
                  }
                  setState(() {});
                },
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                    hintText: "Search Friend Name",
                    contentPadding: EdgeInsets.symmetric(horizontal: width * 0.04)
                ),
              ),
            ),
            SizedBox(
              height: width * 0.06,
            ),
            file.length<1?Expanded(
              child: Container(
                  margin: EdgeInsets.symmetric(vertical: width *0.05),
                  width:width * 0.5,
                  child: Center(child: SvgPicture.asset(A.assets_upload,width: width * 0.3,height: width *0.2,))),
            ):Expanded(
              child: ListView.separated(

                  separatorBuilder: (context,index){
                    return SizedBox(height:width * 0.05, );
                  },
                  itemCount: file.length,
                  itemBuilder: (context,index){
                    return Container(
                      decoration: BoxDecoration(
                        color: themeColor1.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(width * 00.02),
                      ),
                      //margin: EdgeInsets.symmetric(horizontal: width * 0.05,vertical: width * 0.04),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: themeColor1),
                          borderRadius: BorderRadius.circular(width * 00.02),
                        ),
                        padding: EdgeInsets.symmetric(vertical: width * 0.04,horizontal: width * 0.04),
                        // margin: EdgeInsets.symmetric(horizontal: width * 0.02),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(file[index].name!.toUpperCase(),
                              style: TextStyle(
                                  color: themeColor1,
                                  fontSize: width * 0.05
                              ),
                            ),
                            SizedBox(
                              height: width * 0.02,
                            ),
                            Text(file[index].email!.toUpperCase(),
                              style: TextStyle(
                                  color: themeColor1,
                                  fontSize: width * 0.040
                              ),
                            ),
                            SizedBox(
                              height: width * 0.02,
                            ),
                            Column(
                              children: [

                                Row(
                                  children: [
                                    Text("Grade: ",
                                      style: TextStyle(
                                          color: themeColor1,
                                          fontSize: width * 0.040,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(file[index].grade!.toUpperCase(),
                                      style: TextStyle(
                                          color: themeColor1,
                                          fontSize: width * 0.040
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: width * 0.02,
                                ),
                                Row(
                                  children: [
                                    Text("Institute: ",
                                      style: TextStyle(
                                          color: themeColor1,
                                          fontSize: width * 0.040,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    FittedBox(
                                      child: Text(file[index].institute!.toUpperCase(),
                                        style: TextStyle(
                                            color: themeColor1,
                                            fontSize: width * 0.040
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: width * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: themeColor1,
                                      radius: width * 0.033,
                                      child: Center(
                                        child: Text(file[index].name!.substring(0,1).toUpperCase(),style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 11
                                        ),),
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.02,
                                    ),
                                    Text(file[index].name!.toUpperCase(),
                                      style: TextStyle(
                                          color: themeColor1,
                                          fontSize: width * 0.040
                                      ),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: ()=>
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatRoom(friend: file[index],check: false,))),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: themeColor1,
                                        borderRadius: BorderRadius.circular(width * 0.01)
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: width *0.015,horizontal: width *0.035),
                                    child: Row(children: [
                                      Text("Chat Now",style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10
                                      ),),
                                      SizedBox(
                                        width: width * 0.02,
                                      ),
                                      Icon(Icons.message,color: Colors.white,size: width *0.04,)
                                    ],),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
