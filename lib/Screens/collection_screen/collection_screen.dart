
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:quick_notes/constant/constant.dart';
import 'package:quick_notes/globle_variable.dart';
import 'package:quick_notes/image_collection/A.dart';
import 'package:quick_notes/model/file_details_model.dart';
import 'package:quick_notes/text_string_collection/text_string_collection.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({Key key}) : super(key: key);

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {

  //List<FileDetails>files=[];
  getData(){
    FirebaseAuth _auth=FirebaseAuth.instance;
    DatabaseReference ref3 =
    FirebaseDatabase.instance.reference().child('notes_details').child(_auth.currentUser.uid);
    Stream<Event> streams = ref3.onValue;
    streams.forEach((value) {
      print("key"+value.snapshot.key);
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
      ):ListView.separated(
        separatorBuilder: (context,index){
          return SizedBox(height: width * 0.05, );
        },
          itemCount: data.list.length,
          itemBuilder: (context,index){
        return Container(
          color: themeColor1.withOpacity(0.1),
          margin: EdgeInsets.symmetric(horizontal: width * 0.05,vertical: width * 0.04),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: themeColor1),
            ),
            padding: EdgeInsets.symmetric(vertical: width * 0.04,horizontal: width * 0.06),
            margin: EdgeInsets.symmetric(horizontal: width * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.list[index].name.toUpperCase(),
                  style: TextStyle(
                    color: themeColor1,
                    fontSize: width * 0.05
                  ),
                ),
                SizedBox(
                  height: width * 0.02,
                ),
                Text(data.list[index].author.toUpperCase(),
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
                    Text("Grade: ",
                      style: TextStyle(
                          color: themeColor1,
                          fontSize: width * 0.040,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(data.list[index].author.toUpperCase(),
                      style: TextStyle(
                          color: themeColor1,
                          fontSize: width * 0.040
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      })
    );
  }
}

