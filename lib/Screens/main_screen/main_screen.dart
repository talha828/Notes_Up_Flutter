import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quick_notes/Screens/chat_screen/chat_screen.dart';
import 'package:quick_notes/Screens/collection_screen/collection_screen.dart';
import 'package:quick_notes/Screens/splash_screen/splash_screen.dart';
import 'package:quick_notes/Screens/upload_screen/upload_screen.dart';
import 'package:quick_notes/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int currentPage=0;
  List page=[ChatScreen(),UploadScreen(),CollectionScreen(),];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: themeColor1),
          backgroundColor: Colors.white,
          title: Center(
            child: Text("Notes Up",style:
            GoogleFonts.montserrat(
              textStyle: TextStyle(
                color: themeColor1,
              ),
            ),
            ),
          ),
          actions: [
            Icon(Icons.search,color: Colors.white,)
          ],
        ),
        bottomNavigationBar:  FancyBottomNavigation(
          initialSelection: 0,
          circleColor: themeColor1,
          inactiveIconColor: themeColor1,
          tabs: [
            TabData(iconData: Icons.message_outlined, title: "Chat Board"),
            TabData(iconData: Icons.upload, title: "Upload"),
            TabData(iconData: Icons.collections_bookmark, title: "Collection")
          ],
          onTabChangedListener: (position) {
            print(position);
            setState(() {
              currentPage = position;
            });
          },
        ),
        drawer:  Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text("Mettaus Stephens"),
                accountEmail: Text("MettausStephens@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    "M",
                    style: TextStyle(fontSize: 40.0,color: themeColor1),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home,color: themeColor1,), title: Text("Home"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.settings,color: themeColor1,), title: Text("Settings"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.contacts,color: themeColor1,), title: Text("Contact Us"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.logout,color: themeColor1,), title: Text("Logout"),
                onTap: ()async{
                  SharedPreferences pref=await SharedPreferences.getInstance();
                  pref.setString("email", null);
                  pref.setString("password", null);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SplashScreen()));
                },
              ),
            ],
          ),
        ),
        body:page[currentPage]
      ),
    );
  }
}



