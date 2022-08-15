import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick_notes/Screens/sign_up_screen/sign_up_screen.dart';
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
  TextEditingController password=TextEditingController();
  bool isLoading=false;
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
                          Container(
                              margin: EdgeInsets.symmetric(vertical: width *0.05),
                              width:width * 0.5,
                              child: SvgPicture.asset(A.assets_upload,width: width * 0.3,height: width *0.2,)),
                          Text(TextCollection.text_no_upload_from_gallery,style: TextStyle(fontSize: width * 0.06,fontWeight: FontWeight.w100),textAlign: TextAlign.center,),
                          Text(TextCollection.text_no_upload_from_gallery_subtitle_1,style: TextStyle(color:Colors.grey,fontWeight: FontWeight.w500,),textAlign: TextAlign.center,),

                        ],
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
                        text: TextCollection.text_Upload,
                        onTap: (){}),
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
