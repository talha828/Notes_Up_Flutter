import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quick_notes/Screens/sign_up_screen/sign_up_screen.dart';
import 'package:quick_notes/Screens/upload_screen/note_successfully_uploaded/note_success_fully_uploaded.dart';
import 'package:quick_notes/constant/constant.dart';
import 'package:quick_notes/custome_widget/main_button.dart';
import 'package:quick_notes/globle_variable.dart';
import 'package:quick_notes/image_collection/A.dart';
import 'package:quick_notes/text_string_collection/text_string_collection.dart';

class UploadFromGallery extends StatefulWidget {
  const UploadFromGallery({Key key}) : super(key: key);

  @override
  State<UploadFromGallery> createState() => _UploadFromGalleryState();
}

class _UploadFromGalleryState extends State<UploadFromGallery> {

  void pickFile()async{
    var file=await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if(file != null){
      pdf=File(file.files.single.path);
      double size=file.files.single.size/(1024 *1024);
      this.size=size.toStringAsFixed(2);
      name=file.files.single.name;
      setState(() {});
    }
  }
  bool isLoading=false;
  setLoading(bool value){
    setState(() {
      isLoading=value;
    });
  }
  void postFile(String fileName,String author,String grade,String edition,var then)async{
    if(fileName != ""){
      if(author != ""){
        if(grade != ""){
          if(edition != ""){
            setLoading(true);
            FirebaseStorage _storage = FirebaseStorage.instance;
            var reference = _storage.ref().child("Pdf/${name}");
            var uploadTask =await reference.putFile(pdf).snapshot.ref.getDownloadURL().catchError((e){
              Fluttertoast.showToast(
                  msg: "Somethings went wrong,try, again",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
              setLoading(false);
            });
              print("The download URL is " + uploadTask.toString());
            FirebaseAuth _auth = FirebaseAuth.instance;
            FirebaseDatabase.instance
                .reference()
                .child("notes_search_logs").child(name+author+grade+edition+_auth.currentUser.uid)
                .set({
              "details":{
                "file_name":name,
                "author_name":author,
                "grade":grade,
                "edition":edition,
                "url":uploadTask.toString(),
                "uid":_auth.currentUser.uid,
                "search_key":(name+author+grade+edition+_auth.currentUser.uid).trim(),
              }
            });
            FirebaseDatabase.instance
                .reference()
                .child("notes_details").child(_auth.currentUser.uid).child(name.replaceAll(".pdf", "").trim())
                .set({
              "details":{
                "file_name":name,
                "author_name":author,
                "grade":grade,
                "edition":edition,
                "url":uploadTask.toString(),
                "uid":_auth.currentUser.uid,
                "search_key":(name+author+grade+edition+_auth.currentUser.uid).trim(),
              }
            }).then(then).catchError((e){
              setLoading(false);
              Fluttertoast.showToast(
                  msg: "Somethings went wrong",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            });
            }
            Fluttertoast.showToast(
              msg: "Please suggest the edition",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
            );
        }else{
          Fluttertoast.showToast(
              msg: "Please fill the grade",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
          );
        }
      }else{
        Fluttertoast.showToast(
            msg: "Please fill the author name",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    }else{
      Fluttertoast.showToast(
          msg: "Please suggest the file name",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

  TextEditingController fileName=TextEditingController();
  TextEditingController author=TextEditingController();
  TextEditingController grade=TextEditingController();
  TextEditingController edition=TextEditingController();
  File pdf;
  String size;
  String name;
  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: ()=>Navigator.pop(context),icon: Icon(Icons.arrow_back_ios_rounded,color: themeColor1,),),
          backgroundColor: Colors.white,
          title: Text("Upload From Gallery",style: TextStyle(color: themeColor1),),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                height: height,
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      //margin: EdgeInsets.symmetric(horizontal: width *0.07),
                      decoration: BoxDecoration(
                        border: Border.all(style: BorderStyle.solid,color: themeColor1),
                        borderRadius: BorderRadius.circular(10),
                        color: themeColor1.withOpacity(0.1),
                      ),
                      height: height * 0.25,
                      child:          Column(
                        children: [
                          InkWell(
                            onTap: ()=>pickFile(),
                            child: Container(
                                margin: EdgeInsets.symmetric(vertical: width *0.05),
                                width:width * 0.5,
                                child: SvgPicture.asset(A.assets_upload,width: width * 0.3,height: width *0.2,)),
                          ),
                          Text(pdf==null?TextCollection.text_no_upload_from_gallery:TextCollection.text_file_successfully_uploaded,style: TextStyle(fontSize: width * 0.06,fontWeight: FontWeight.w100),textAlign: TextAlign.center,),
                          Text(pdf==null?TextCollection.text_no_upload_from_gallery_subtitle_1:TextCollection.text_your_file_size_is+"($size).MB" ,style: TextStyle(color:Colors.grey,fontWeight: FontWeight.w500,),textAlign: TextAlign.center,),

                        ],
                      ),

                    ),
                    //Text(TextCollection.text_upload_your_notes,style: TextStyle(fontSize:  width * 0.08,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
                    QuickTextField(
                      title: TextCollection.text_field_name,
                      icon: Icons.person,
                      hintText: TextCollection.text_field_name,
                      onChange: (value) {},
                      controller: fileName,
                    ),
                    QuickTextField(
                      title: TextCollection.text_Author_name,
                      icon: Icons.perm_contact_cal_outlined,
                      hintText: TextCollection.text_Author_name,
                      onChange: (value) {},
                      controller: author,
                    ),
                    QuickTextField(
                      title: TextCollection.text_grade,
                      icon: Icons.grade_outlined,
                      hintText: TextCollection.text_grade,
                      onChange: (value) {},
                      controller: grade,
                    ),

                    QuickTextField(
                      title: TextCollection.text_Edition,
                      icon: Icons.edit_attributes_outlined,
                      hintText: TextCollection.text_Edition,
                      onChange: (value) {},
                      controller: edition,
                    ),
                    MainButton(
                        text: TextCollection.text_Upload,
                        onTap: ()=>postFile(fileName.text, author.text, grade.text, edition.text, (value){
                          setLoading(false);
                          fileName.clear();
                          author.clear();
                          grade.clear();
                          edition.clear();
                          pdf=null;
                          setState(() {});
                          Fluttertoast.showToast(
                            msg: "Notes Successfully Uploaded",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                          );
                          Navigator.push(context, PageTransition(type: PageTransitionType.leftToRight,duration: Duration(milliseconds: 1500), child: NoteSuccessfullyUploaded()));
                        })),
                  ],
                ),
              ),
            ),
            isLoading?Positioned.fill(child:LoadingIndicator()):Container()
          ],
        )
      ),
    );
  }
}
