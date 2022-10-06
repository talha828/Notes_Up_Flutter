import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quick_notes/Screens/notes_filters_screen/notes_search_screen.dart';
import 'package:quick_notes/Screens/sign_up_screen/sign_up_screen.dart';
import 'package:quick_notes/constant/constant.dart';
import 'package:quick_notes/globle_variable.dart';
import 'package:quick_notes/image_collection/A.dart';
import 'package:quick_notes/model/search_notes.dart';
import 'package:quick_notes/text_string_collection/text_string_collection.dart';
import 'package:url_launcher/url_launcher.dart';

class NotesSearch extends StatefulWidget {

  @override
  State<NotesSearch> createState() => _NotesSearchState();
}

class _NotesSearchState extends State<NotesSearch> {
  TextEditingController search=TextEditingController();
  int num=0;
  getData(){
    Provider.of<SearchNotes>(context,listen: false).clearKeys();
    Provider.of<SearchNotes>(context,listen: false).clearFiles();
    FirebaseAuth _auth=FirebaseAuth.instance;
    DatabaseReference ref3 =
    FirebaseDatabase.instance.reference().child('notes_search_logs');
    Stream<Event> streams = ref3.onValue;
    streams.forEach((value) {
      //print(value.snapshot.key);
      value.snapshot.value.forEach((key,value){
        //print(key);
        Provider.of<SearchNotes>(context,listen: false).storeKeys(key.toString());
        value.forEach((key,value){
          Provider.of<SearchNotes>(context,listen: false).storeFiles(new Map<String,dynamic>.from(value));
        });
      });
    });
  }
  @override
  void initState() {
    getData();
    super.initState();
  }
  List<FileDetails>file=[];
  @override
  Widget build(BuildContext context) {
    var data=Provider.of<SearchNotes>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: themeColor1),
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            "Search Notes",
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
            SizedBox(
              height: width * 0.02,
            ),
            Container(child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap:(){
                      setState(() {
                        num=0;
                      });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: themeColor1),
                      borderRadius: BorderRadius.circular(5),
                      color: num==0?themeColor1:Colors.white,
                    ),

                    padding:EdgeInsets.symmetric(vertical: width * 0.04,horizontal: width * 0.04),
                    child: Text("File ",style: TextStyle(
                      color: num==0?Colors.white:themeColor1
                    ),),
                  ),
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      num=1;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: themeColor1),
                      borderRadius: BorderRadius.circular(5),
                      color: num==1?themeColor1:Colors.white,
                    ),

                    padding:EdgeInsets.symmetric(vertical: width * 0.04,horizontal: width * 0.04),
                    child: Text("Author",style: TextStyle(
                        color: num==1?Colors.white:themeColor1
                    ),),
                  ),
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      num=2;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: themeColor1),
                      borderRadius: BorderRadius.circular(5),
                      color: num==2?themeColor1:Colors.white,
                    ),
                    padding:EdgeInsets.symmetric(vertical: width * 0.04,horizontal: width * 0.04),
                    child: Text("Intitute",style: TextStyle(
                        color: num==2?Colors.white:themeColor1
                    ),),
                  ),
                ),
              ],
            )
            ),
            SizedBox(
              height: width * 0.05,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: themeColor1),
                borderRadius: BorderRadius.circular(width * 0.01)
              ),
              child:TextField(
                onChanged: (value){
                  file.clear();
                  for(int i=0;i<data.searchKeys.length;i++){
                    if(data.searchKeys[i].contains(value)){
                     file.add(data.fileDetails[i]);
                    }
                  }
                  setState(() {});
                },
                decoration: InputDecoration(
                    focusedBorder: InputBorder.none,
                    hintText: TextCollection.text_search_notes,
                  contentPadding: EdgeInsets.symmetric(horizontal: width * 0.04)
                ),
              ),
            ),
            SizedBox(
              height: width * 0.06,
            ),
            InkWell(
              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>FiltersNotes())),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04,vertical: width * 0.02),
                decoration: BoxDecoration(
                  color: themeColor1,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Text("Show Future preview of search Notes",style: TextStyle(color: Colors.white),),),
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
                            Text(file[index].author!.toUpperCase(),
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
                                    Text(file[index].grade!.toUpperCase(),
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
                                    Text(file[index].edition!.toUpperCase(),
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
                                  onTap: ()async{
                                    await canLaunch(file[index].url) ? await launch(file[index].url) : Fluttertoast.showToast(
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
                  }),
            )
          ],
        ),
      ),
    );
  }
}
