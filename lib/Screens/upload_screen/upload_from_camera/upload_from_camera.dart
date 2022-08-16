import 'dart:io';
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
  const UploadFromCamera({Key key}) : super(key: key);

  @override
  State<UploadFromCamera> createState() => _UploadFromCameraState();
}

class _UploadFromCameraState extends State<UploadFromCamera> {
  TextEditingController password = TextEditingController();
  bool isLoading = false;
  List<File> file = [

  ];
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
                          File image = await ImagePicker.pickImage(
                              source: ImageSource.camera);
                          file.add(image);
                          setState(() {});
                        },
                        child: file.length > 0
                            ? Container(
                                height: height * 0.25,
                                child: ListView.separated(
                                  separatorBuilder: (context,index){
                                    return SizedBox(width: width * 0.02,);
                                  },
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: file.length+1,
                                    itemBuilder: (context, index) {
                                    if(index==0){
                                      return InkWell(
                                        onTap: ()async{
                                          var camera = await Permission.camera.request();
                                          var gallery = await Permission.storage.request();
                                          File image = await ImagePicker.pickImage(
                                              source: ImageSource.camera);
                                          file.add(image);
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
                                          file.remove(file[index-1]);
                                        });
                                    },
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          File(file[index-1].path),
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
                        controller: password,
                      ),
                      QuickTextField(
                        title: TextCollection.text_Author_name,
                        icon: Icons.perm_contact_cal_outlined,
                        hintText: TextCollection.text_Author_name,
                        onChange: (value) {},
                        controller: password,
                      ),
                      QuickTextField(
                        title: TextCollection.text_grade,
                        icon: Icons.grade_outlined,
                        hintText: TextCollection.text_grade,
                        onChange: (value) {},
                        controller: password,
                      ),

                      QuickTextField(
                        title: TextCollection.text_Edition,
                        icon: Icons.edit_attributes_outlined,
                        hintText: TextCollection.text_Edition,
                        onChange: (value) {},
                        controller: password,
                      ),
                      MainButton(
                          text: TextCollection.text_Upload, onTap: () async{

                        final pdf = pw.Document();
                       for(var i in file){
                         var image = pw.MemoryImage(
                           i.readAsBytesSync(),
                         );
                         pdf.addPage(pw.Page(build: (pw.Context context) {
                           return
                             pw.Image(image);// Center
                         }));
                         Directory appDocDir = await getApplicationDocumentsDirectory();
                         final file = File("${appDocDir.path}/example.pdf");
                         print(file.path);
                         final bytes = await pdf.save();
                         await file.writeAsBytes(bytes,flush: true);
                            print("done");
                       }
                      }),
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
