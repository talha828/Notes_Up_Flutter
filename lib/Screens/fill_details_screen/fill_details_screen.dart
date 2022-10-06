import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:quick_notes/Screens/main_screen/main_screen.dart';
import 'package:quick_notes/Screens/sign_up_screen/sign_up_screen.dart';
import 'package:quick_notes/Screens/welcome_screen/welcome_screen.dart';
import 'package:quick_notes/backend/database/database.dart';
import 'package:quick_notes/custome_widget/main_button.dart';
import 'package:quick_notes/globle_variable.dart';
import 'package:quick_notes/image_collection/A.dart';
import 'package:quick_notes/model/user_details.dart';
import 'package:quick_notes/model/user_model.dart';
import 'package:quick_notes/text_string_collection/text_string_collection.dart';

class FillYourDetailsScreen extends StatefulWidget {
  const FillYourDetailsScreen({Key? key}) : super(key: key);

  @override
  State<FillYourDetailsScreen> createState() => _FillYourDetailsScreenState();
}

class _FillYourDetailsScreenState extends State<FillYourDetailsScreen> {
  TextEditingController country =TextEditingController();
  TextEditingController city =TextEditingController();
  TextEditingController school =TextEditingController();
  TextEditingController grade =TextEditingController();
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    var user=Provider.of<UserModel>(context);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                height: height   ,
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SvgPicture.asset(
                      A.assets_sign_up,
                      width: width * 0.5,
                      height: width * 0.4,
                    ),
                    SizedBox(
                      height: width * 0.04,
                    ),
                    Text(
                      TextCollection.text_fill_your_details_below,
                      style: TextStyle(
                          fontSize: width * 0.077, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: width * 0.03,
                    ),
                    QuickTextField(
                      title: TextCollection.text_country,
                      icon: Icons.add_location_alt_outlined,
                      hintText: TextCollection.text_country,
                      onChange: (value) {},
                      controller: country,
                    ),
                    QuickTextField(
                      title: TextCollection.text_city,
                      icon: Icons.location_searching,
                      hintText: TextCollection.text_city,
                      onChange: (value) {},
                      controller: city,
                    ),
                    QuickTextField(
                      title: TextCollection.text_institute,
                      icon: Icons.school_outlined,
                      hintText: TextCollection.text_institute,
                      onChange: (value) {},
                      controller: school,
                    ),
                    QuickTextField(
                      title: TextCollection.text_grade,
                      icon: Icons.grade,
                      hintText: TextCollection.text_grade,
                      onChange: (value) {},
                      controller: grade,
                    ),
                    SizedBox(
                      height: width * 0.02,
                    ),
                    MainButton(
                        text: TextCollection.text_Sign_up,
                        onTap: (){
                          Database().storeUserSignUpData(user.name!, user.email!, user.password!, country.text, city.text, school.text, grade.text, (value)async{
                            FirebaseAuth _auth= FirebaseAuth.instance;
                            var ref3=FirebaseDatabase.instance.reference().child('userinfo').child(_auth.currentUser!.uid);
                            Stream<Event> streams = ref3.onValue;
                            streams.forEach((value) async{
                              print("key" +value.snapshot.key!);
                              print("Value" +value.snapshot.value['details'].toString());
                                Provider.of<UserDetails>(context,listen: false).saveData(new Map<String,dynamic>.from(value.snapshot.value['details']));});
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen()));
                            setLoading(false);
                          },(value){
                            setState(() {
                              isLoading=value;
                            });
                          });
                        }
                    ),
                  ],
                ),
              ),
            ),
            isLoading?Positioned.fill(child: LoadingIndicator()):Container()
          ],
        )
      ),
    );
  }
  setLoading(bool value){
    setState(() {
      isLoading=value;
    });
  }
}
