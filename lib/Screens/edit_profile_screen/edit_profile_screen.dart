import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quick_notes/Screens/main_screen/main_screen.dart';
import 'package:quick_notes/Screens/sign_up_screen/sign_up_screen.dart';
import 'package:quick_notes/constant/constant.dart';
import 'package:quick_notes/custome_widget/main_button.dart';
import 'package:quick_notes/globle_variable.dart';
import 'package:quick_notes/model/user_details.dart';
import 'package:quick_notes/text_string_collection/text_string_collection.dart';

class ProfileScreen extends StatefulWidget {
  UserDetails? data;
  ProfileScreen({this.data});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController name=TextEditingController();
  TextEditingController country=TextEditingController();
  TextEditingController city=TextEditingController();
  TextEditingController institute=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController grade=TextEditingController();
  bool isLoading=false;

  setLoading(bool value){
    setState(() {
      isLoading =value;
    });
  }
  @override
  void initState() {
    name=TextEditingController(text: widget.data!.name);
    country=TextEditingController(text: widget.data!.country);
    city=TextEditingController(text: widget.data!.city);
    institute=TextEditingController(text: widget.data!.institute);
    grade=TextEditingController(text: widget.data!.grade);
    email=TextEditingController(text: widget.data!.email);
    password=TextEditingController(text: widget.data!.password);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(
      //   iconTheme: IconThemeData(color: themeColor1),
      //   backgroundColor: Colors.white,
      //   title: Center(
      //     child: Text(
      //       "Edit Profile",
      //       style: GoogleFonts.montserrat(
      //         textStyle: TextStyle(
      //           color: themeColor1,
      //         ),
      //       ),
      //     ),
      //   ),
      //   actions: [
      //     Padding(
      //       padding: EdgeInsets.all(width * 00.02),
      //       child: IconButton(
      //         icon: Icon(Icons.search, color: Colors.white),
      //         onPressed: () {},
      //       ),
      //     )
      //   ],
      // ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: width * 0.07,vertical: width * 0.1),
                        child: CircleAvatar(
                          radius: width * 0.07,
                          backgroundColor: themeColor1,
                          child: Text(
                            widget.data!.name.toString().substring(0,1).toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: width * 0.07
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name.text.toString().toUpperCase(),style: TextStyle(
                            fontSize: width * 0.05,),),
                          SizedBox(
                            height: width * 0.02,
                          ),
                          Text(name.text.toString(),style: TextStyle(
                            fontSize: width * 0.03,),),
                        ],
                      ),
                    ],
                  ),
                  Divider(height: 2,color: Colors.grey.withOpacity(0.5),),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.08,vertical: width * 0.08),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        QuickTextField(
                          title: TextCollection.text_field_name,
                          icon: Icons.person,
                          hintText: name.text.toString()=="null"?"Loading":name.text.toString(),
                          onChange: (value) {},
                          controller: name,
                        ),
                        SizedBox(height: width * 0.05,),
                        QuickTextField(
                          title: TextCollection.text_country,
                          icon: Icons.add_location_alt_outlined,
                          hintText: country.text.toString()=="null"?"Loading":country.text.toString(),
                          onChange: (value) {},
                          controller: country,
                        ),
                        SizedBox(height: width * 0.05,),
                        QuickTextField(
                          title: TextCollection.text_city,
                          icon: Icons.location_searching,
                          hintText: city.text.toString()=="null"?"Loading":city.text.toString(),
                          onChange: (value) {},
                          controller: city,
                        ),
                        SizedBox(height: width * 0.05,),
                        QuickTextField(
                          title: TextCollection.text_institute,
                          icon: Icons.school,
                          hintText:institute.text.toString()=="null"?"Loading":institute.text.toString(),
                          onChange: (value) {},
                          controller: institute,
                        ),
                        SizedBox(height: width * 0.05,),
                        QuickTextField(
                          title: TextCollection.text_grade,
                          icon: Icons.grade,
                          hintText:grade.text.toString()=="null"?"Loading":grade.text.toString(),
                          onChange: (value) {},
                          controller: grade,
                        ),
                        SizedBox(height: width * 0.05,),
                        MainButton(
                          text: TextCollection.text_Edit,
                          onTap: ()async{
                            setLoading(true);
                            FirebaseAuth _auth = FirebaseAuth.instance;
                            FirebaseDatabase.instance
                                .reference()
                                .child("userinfo").child(_auth.currentUser!.uid)
                                .set({
                              "details":{
                                "email":email.text,
                                "password":password.text,
                                "name":name.text,
                                "country":country.text,
                                "city":city.text,
                                "institute":institute.text,
                                "grade":grade.text,
                                "uid":_auth.currentUser!.uid,
                              }
                            })
                            .then((value)async{
                                AwesomeDialog(
                                context: context,
                                dialogType: DialogType.SUCCES,
                                animType: AnimType.BOTTOMSLIDE,
                                title: 'Successfully Edit',
                                desc: "Profile successfully edit",
                                btnOkColor: themeColor1,
                                btnOkOnPress: () {},
                              )..show().then((value) {
                                setLoading(false);
                                Navigator.push(context, MaterialPageRoute(builder:
                                (context)=>MainScreen()));});
                            });

                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          isLoading?Positioned.fill(child: LoadingIndicator()):Container(),
        ],
      )
    );
  }
}
