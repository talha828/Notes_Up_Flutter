import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quick_notes/Screens/upload_screen/upload_from_camera/upload_from_camera.dart';
import 'package:quick_notes/Screens/upload_screen/upload_from_gallery/upload_from_gallery.dart';
import 'package:quick_notes/constant/constant.dart';
import 'package:quick_notes/globle_variable.dart';
import 'package:quick_notes/image_collection/A.dart';
import 'package:quick_notes/text_string_collection/text_string_collection.dart';

class UploadScreen extends StatefulWidget {


  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height:width * 0.06 ,
          ),
          InkWell(
            onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadFromGallery())),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: width *0.07),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: themeColor1.withOpacity(0.1),
              ),
              height: height * 0.3,
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
          ),
          InkWell(
            onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadFromCamera())),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: width *0.07),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: themeColor1.withOpacity(0.1),
              ),
              height: height * 0.3,
              child:          Column(

                children: [
                  Container(
                      margin: EdgeInsets.symmetric(vertical: width *0.05),
                      width:width * 0.5,
                      child: SvgPicture.asset(A.assets_upload,width: width * 0.3,height: width *0.2,)),
                  Text(TextCollection.text_click_images,style: TextStyle(fontSize: width * 0.06,fontWeight: FontWeight.w100),textAlign: TextAlign.center,),
                  Text(TextCollection.text_no_upload_from_gallery_subtitle_1,style: TextStyle(color:Colors.grey,fontWeight: FontWeight.w500,),textAlign: TextAlign.center,),

                ],
              ),

            ),
          ),
          SizedBox(
            height:width * 0.06 ,
          ),
        ],
      ),
    );
  }
}