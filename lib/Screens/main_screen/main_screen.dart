import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:quick_notes/Screens/chat_screen/chat_screen.dart';
import 'package:quick_notes/Screens/collection_screen/collection_screen.dart';
import 'package:quick_notes/Screens/contact_us_screen/contact_us_screen.dart';
import 'package:quick_notes/Screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:quick_notes/Screens/home_screen/home_screen.dart';
import 'package:quick_notes/Screens/notes_search.dart';
import 'package:quick_notes/Screens/splash_screen/splash_screen.dart';
import 'package:quick_notes/Screens/upload_screen/upload_screen.dart';
import 'package:quick_notes/constant/constant.dart';
import 'package:quick_notes/globle_variable.dart';
import 'package:quick_notes/group_chat_screen/group_chat_screen.dart';
import 'package:quick_notes/model/search_notes.dart';
import 'package:quick_notes/model/user_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    var myData = Provider.of<UserDetails>(context);
    List page = [
      HomePage(),
      GroupChatScreen(),
      UploadScreen(),
      CollectionScreen(),
      ProfileScreen(data: myData,),
    ];
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: themeColor1),
            backgroundColor: Colors.white,
            title: Center(
              child: Text(
                "Notes Up",
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
                child: RotationTransition(
                  turns: AlwaysStoppedAnimation(330/365),
                  child: IconButton(
                   icon:Icon( Icons.send,
                       color: themeColor1),
                    onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen())),
                  ),
                ),
              )
            ],
          ),
          bottomNavigationBar: CurvedNavigationBar(
            height: 75,
            color: themeColor1,
            backgroundColor:
            Colors.white,
            items: <Widget>[
              Icon(Icons.home,color: Colors.white,),
              Icon(Icons.message, size: 20,color: Colors.white,),
              Icon(Icons.upload, size: 20,color: Colors.white,),
              Icon(Icons.file_copy, size: 20,color: Colors.white,),
              Icon(Icons.person, size: 20,color: Colors.white,),
            ],
            onTap: (index) {
              setState(() {
                currentPage=index;
              });
            },
          ),
          //   initialSelection: 0,
          //   circleColor: themeColor1,
          //   inactiveIconColor: themeColor1,
          //   tabs: [
          //     TabData(iconData: Icons.home, title: "Home"),
          //     TabData(iconData: Icons.message, title: "Group Chat"),
          //     //TabData(iconData: Icons.upload, title: "Upload"),
          //     TabData(iconData: Icons.collections_bookmark, title: "Collection"),
          //     TabData(iconData: Icons.person, title: "Profile")
          //   ],
          //   onTabChangedListener: (position) {
          //     print(position);
          //     setState(() {
          //       currentPage = position;
          //     });
          //   },
          // ),
          drawer: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text(
                    myData.name!.toUpperCase(),
                    style: TextStyle(color: Colors.white),
                  ),
                  accountEmail: Text(
                    myData.email!,
                    style: TextStyle(color: Colors.white),
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      myData.name!.substring(0, 1).toUpperCase(),
                      style: TextStyle(fontSize: 40.0, color: themeColor1),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.home,
                    color: themeColor1,
                  ),
                  title: Text("Home"),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.search,
                    color: themeColor1,
                  ),
                  title: Text("Search Notes"),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>NotesSearch()));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.contacts,
                    color: themeColor1,
                  ),
                  title: Text("Contact Us"),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactUsScreen()));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: themeColor1,
                  ),
                  title: Text("Logout"),
                  onTap: () async {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    pref.setString("email", "null");
                    pref.setString("password", "null");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SplashScreen()));
                  },
                ),
              ],
            ),
          ),
          body: page[currentPage]),
    );
  }
}
