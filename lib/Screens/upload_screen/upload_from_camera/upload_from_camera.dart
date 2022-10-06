import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quick_notes/Screens/sign_up_screen/sign_up_screen.dart';
import 'package:quick_notes/Screens/upload_screen/note_successfully_uploaded/note_success_fully_uploaded.dart';
import 'package:quick_notes/constant/constant.dart';
import 'package:quick_notes/custome_widget/main_button.dart';
import 'package:quick_notes/globle_variable.dart';
import 'package:quick_notes/image_collection/A.dart';
import 'package:quick_notes/text_string_collection/text_string_collection.dart';

class UploadFromCamera extends StatefulWidget {


  @override
  State<UploadFromCamera> createState() => _UploadFromCameraState();
}

class _UploadFromCameraState extends State<UploadFromCamera> {
  TextEditingController filename = TextEditingController();
  TextEditingController author = TextEditingController();
  TextEditingController grade = TextEditingController();
  TextEditingController edition = TextEditingController();
  bool isLoading = false;
  List<File> image = [];

  postData(String filename,String author,String grade,String edition,var then)async{
    if(filename!=""){
      if(author != ""){
        if(grade != ""){
          if(edition != ""){
            setLoading(true);
            final pdf = pw.Document();
            for(var i in image){
              var image = pw.MemoryImage(
                i.readAsBytesSync(),
              );
              pdf.addPage(pw.Page(build: (pw.Context context) {
                return
                  pw.Image(image);// Center
              }));
            }
            Directory appDocDir = await getApplicationDocumentsDirectory();
            final file = File("${appDocDir.path}/example.pdf");
            print(file.path);
            final bytes = await pdf.save();
            await file.writeAsBytes(bytes,flush: true);
            FirebaseStorage _storage = FirebaseStorage.instance;
            var reference = _storage.ref().child("Pdf/${filename}");
            var uploadTask =await reference.putFile(file).snapshot.ref.getDownloadURL().then((value){
              FirebaseAuth _auth = FirebaseAuth.instance;
              FirebaseDatabase.instance
                  .reference()
                  .child("notes_search_logs").child(filename+author+grade+edition+_auth.currentUser!.uid)
                  .set({
                "details":{
                  "file_name":filename,
                  "author_name":author,
                  "grade":grade,
                  "edition":edition,
                  "url":value.toString(),
                  "uid":_auth.currentUser!.uid,
                  "search_key":(filename+author+grade+edition+_auth.currentUser!.uid).trim(),
                }
              });
              FirebaseDatabase.instance
                  .reference()
                  .child("notes_details").child(_auth.currentUser!.uid).child(filename.replaceAll(".pdf", "").trim())
                  .set({
                "details":{
                  "file_name":filename,
                  "author_name":author,
                  "grade":grade,
                  "edition":edition,
                  "url":value.toString(),
                  "uid":_auth.currentUser!.uid,
                  "search_key":(filename+author+grade+edition+_auth.currentUser!.uid).trim(),
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
            }).catchError((onError){
              setLoading(false);
              print(onError.toString());
              Fluttertoast.showToast(
                  msg: "Somethings went wrong,try again",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            });

          }else{
            Fluttertoast.showToast(
              msg: "file name in empty",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
            );
          }
        }else{
          Fluttertoast.showToast(
            msg: "author name is empty",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
          );
        }
      }else{
        Fluttertoast.showToast(
          msg: "grade is empty",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
      }
    }else{
      Fluttertoast.showToast(
        msg: "Please suggest the edition",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    }
  }
  setLoading(bool value){
    setState(() {
      isLoading=value;
    });
  }
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: themeColor1,
              ),
            ),
            backgroundColor: Colors.white,
            title: Text(
              "Upload From Camera",
              style: TextStyle(color: themeColor1),
            ),
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
                      InkWell(
                        onTap: () async {
                          var camera = await Permission.camera.request();
                          var gallery = await Permission.storage.request();
                          XFile? images = await ImagePicker().pickImage(
                              source: ImageSource.camera);
                          image.add(File(images!.path));
                          setState(() {});
                        },
                        child: image.length > 0
                            ? Container(
                                height: height * 0.25,
                                child: ListView.separated(
                                  separatorBuilder: (context,index){
                                    return SizedBox(width: width * 0.02,);
                                  },
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: image.length+1,
                                    itemBuilder: (context, index) {
                                    if(index==0){
                                      return InkWell(
                                        onTap: ()async{
                                          var camera = await Permission.camera.request();
                                          var gallery = await Permission.storage.request();
                                          XFile? images = await ImagePicker().pickImage(
                                              source: ImageSource.camera);
                                          image.add(File(images!.path));
                                          setState(() {});
                                        },
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 10),
                                            color: themeColor1.withOpacity(0.1),
                                            width: 100,
                                            child: Container(
                                              child: SvgPicture.asset(
                                                A.assets_upload,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  return Dismissible(
                                    direction: DismissDirection.vertical,
                                    key: UniqueKey(),
                                    onDismissed: (direction){
                                        setState(() {
                                          image.remove(image[index-1]);
                                        });
                                    },
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          File(image[index-1].path),
                                          fit: BoxFit.fill,
                                        )),
                                  );
                                }))
                            : Container(
                                //margin: EdgeInsets.symmetric(horizontal: width *0.07),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      style: BorderStyle.solid,
                                      color: themeColor1),
                                  borderRadius: BorderRadius.circular(10),
                                  color: themeColor1.withOpacity(0.1),
                                ),
                                height: height * 0.25,
                                child: Column(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: width * 0.05),
                                        width: width * 0.5,
                                        child: SvgPicture.asset(
                                          A.assets_upload,
                                          width: width * 0.3,
                                          height: width * 0.2,
                                        )),
                                    Text(
                                      TextCollection.text_Upload_from_camera,
                                      style: TextStyle(
                                          fontSize: width * 0.06,
                                          fontWeight: FontWeight.w100),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      TextCollection
                                          .text_no_upload_from_camera_subtitle_1,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                      ),
                      //Text(TextCollection.text_upload_your_notes,style: TextStyle(fontSize:  width * 0.08,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
                      QuickTextField(
                        title: TextCollection.text_field_name,
                        icon: Icons.person,
                        hintText: TextCollection.text_field_name,
                        onChange: (value) {},
                        controller: filename,
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
                          text: TextCollection.text_Upload, onTap:()=> postData(filename.text, author.text, grade.text, edition.text, (value){
                        setLoading(false);
                        filename.clear();
                        author.clear();
                        grade.clear();
                        edition.clear();
                        image=[];
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
                      })
                      ),
                    ],
                  ),
                ),
              ),
              isLoading
                  ? Positioned.fill(child: LoadingIndicator())
                  : Container()
            ],
          )),
    );
  }
}
