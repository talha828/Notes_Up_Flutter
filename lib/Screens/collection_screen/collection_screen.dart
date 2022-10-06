
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:quick_notes/constant/constant.dart';
import 'package:quick_notes/globle_variable.dart';
import 'package:quick_notes/image_collection/A.dart';
import 'package:quick_notes/model/file_details_model.dart';
import 'package:quick_notes/model/user_details.dart';
import 'package:quick_notes/text_string_collection/text_string_collection.dart';
import 'package:url_launcher/url_launcher.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({Key? key}) : super(key: key);

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {

  //List<FileDetails>files=[];
  getData(){
    FirebaseAuth _auth=FirebaseAuth.instance;
    DatabaseReference ref3 =
    FirebaseDatabase.instance.reference().child('notes_details').child(_auth.currentUser!.uid);
    Stream<Event> streams = ref3.onValue;
    streams.forEach((value) {
      print("key"+value.snapshot.key!);
      print("value"+value.snapshot.value.toString());
      Provider.of<StoreFile>(context,listen: false).getData(new Map<String, dynamic>.from(value.snapshot.value));
      setState(() {});

      //     .forEach((key,value) {
      //
      //   var data=value["details"];
      //
      //    //files.add(FileDetails().getData(new Map<String, dynamic>.from(value['details'])));
      //
      //   Provider.of<FileDetails>(context,listen: false).getData(new Map<String, dynamic>.from(value['details']));
      // });
    });
    //print(files.length);
  }
  List fileName=[];

  @override
  void initState() {
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    var data=Provider.of<StoreFile>(context);
    var myData=Provider.of<UserDetails>(context);
    return Scaffold(
      body: data.list.length<1?Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SvgPicture.asset(A.assets_save_collection,width: width * 0.5,height: width *0.4,),
          SizedBox(
            height:width * 0.06 ,
          ),
          Text(TextCollection.text_no_collection,style: TextStyle(fontSize: width * 0.06,fontWeight: FontWeight.w100),textAlign: TextAlign.center,),
          SizedBox(
            height:width * 0.04 ,
          ),
          Text(TextCollection.text_no_collection_subtitle_1,style: TextStyle(fontWeight: FontWeight.w500,),textAlign: TextAlign.center,),
          Text(TextCollection.text_no_collection_subtitle_2,style: TextStyle(fontWeight: FontWeight.w500,),textAlign: TextAlign.center,),


        ],
      ):
      ListView.separated(
        separatorBuilder: (context,index){
          return SizedBox(height:0, );
        },
          itemCount: data.list.length,
          itemBuilder: (context,index){
        return Container(
          decoration: BoxDecoration(
            color: themeColor1.withOpacity(0.05),
            borderRadius: BorderRadius.circular(width * 00.02),
          ),
          margin: EdgeInsets.symmetric(horizontal: width * 0.05,vertical: width * 0.04),
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
                Text(data.list[index].name!.toUpperCase(),
                  style: TextStyle(
                    color: themeColor1,
                    fontSize: width * 0.05
                  ),
                ),
                SizedBox(
                  height: width * 0.02,
                ),
                Text(data.list[index].author!.toUpperCase(),
                  style: TextStyle(
                      color: themeColor1,
                      fontSize: width * 0.040
                  ),
                ),
                SizedBox(
                  height: width * 0.02,
                ),
                Row(
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
                        Text(data.list[index].grade!.toUpperCase(),
                          style: TextStyle(
                              color: themeColor1,
                              fontSize: width * 0.040
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: width * 0.04,
                    ),
                    Row(
                      children: [
                        Text("Edition: ",
                          style: TextStyle(
                              color: themeColor1,
                              fontSize: width * 0.040,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(data.list[index].edition!.toUpperCase(),
                          style: TextStyle(
                              color: themeColor1,
                              fontSize: width * 0.040
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
                          child: Text(myData.name!.substring(0,1).toUpperCase(),style: TextStyle(
                            color: Colors.white,
                            fontSize: 11
                          ),),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Text(myData.name!.toUpperCase(),
                        style: TextStyle(
                            color: themeColor1,
                            fontSize: width * 0.040
                        ),
                      ),
                    ],
                  ),
                    InkWell(
                      onTap: ()async{
            await canLaunch(data.list[index].url) ? await launch(data.list[index].url) : Fluttertoast.showToast(
                msg: "Somethings went wrong",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0
            );
            }  ,
                      child: Container(
                        decoration: BoxDecoration(
                            color: themeColor1,
                            borderRadius: BorderRadius.circular(width * 0.01)
                        ),
                        padding: EdgeInsets.symmetric(vertical: width *0.015,horizontal: width *0.035),
                        child: Row(children: [
                          Text("Download",style: TextStyle(
                            color: Colors.white,
                            fontSize: 10
                          ),),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          Icon(Icons.download,color: Colors.white,size: width *0.04,)
                        ],),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      })
    );
  }
}

