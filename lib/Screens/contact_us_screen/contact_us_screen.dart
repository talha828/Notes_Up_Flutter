import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quick_notes/constant/constant.dart';
import 'package:quick_notes/globle_variable.dart';
import 'package:quick_notes/text_string_collection/text_string_collection.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    width= MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: themeColor1),
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: ()=>Navigator.pop(context),
            child: Icon(Icons.arrow_back_ios_rounded,color: themeColor1,)),
        title: Center(
          child: Text(
            "Contact Us",
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                color: themeColor1,
              ),
            ),
          ),
        ),
        actions: [
         Icon(Icons.email,color: Colors.white,)
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              backgroundColor: themeColor1,
                radius: 80,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: Image.asset("assets/image/metteus.jpg",fit: BoxFit.cover,))),

            Text(
              "Metteus Stephens",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                  fontSize: width * 0.077, fontWeight: FontWeight.bold,),
            ),
            Text("Metteus Stephens is the Founder and the CEO of this company. In case you have an problem and any issue feel free to contact us on our email .please leave a feed back in our email",style: TextStyle(fontSize:  width * 0.04,),textAlign: TextAlign.center,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.email,color: Colors.grey,),SizedBox(width: width * 0.02,),Text("metteusstephens246@gmail.com")
              ],
            )
          ],
        ),
      ),
    );
  }
}
