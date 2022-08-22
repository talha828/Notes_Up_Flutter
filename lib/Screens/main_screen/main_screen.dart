import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:quick_notes/Screens/chat_screen/chat_screen.dart';
import 'package:quick_notes/Screens/collection_screen/collection_screen.dart';
import 'package:quick_notes/Screens/contact_us_screen/contact_us_screen.dart';
import 'package:quick_notes/Screens/notes_search.dart';
import 'package:quick_notes/Screens/splash_screen/splash_screen.dart';
import 'package:quick_notes/Screens/upload_screen/upload_screen.dart';
import 'package:quick_notes/constant/constant.dart';
import 'package:quick_notes/globle_variable.dart';
import 'package:quick_notes/model/user_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentPage = 0;
  List page = [
    ChatScreen(),
    UploadScreen(),
    CollectionScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    var myData = Provider.of<UserDetails>(context);
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
                child: IconButton(
                 icon:Icon( Icons.search,
                     color: themeColor1),
                  onPressed: ()=>        Navigator.push(context, PageTransition(type: PageTransitionType.leftToRight,duration: Duration(milliseconds: 1500), child: NotesSearch())),
                ),
              )
            ],
          ),
          bottomNavigationBar: FancyBottomNavigation(
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
          drawer: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text(
                    myData.name.toUpperCase(),
                    style: TextStyle(color: Colors.white),
                  ),
                  accountEmail: Text(
                    myData.email,
                    style: TextStyle(color: Colors.white),
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      myData.name.substring(0, 1).toUpperCase(),
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
                    pref.setString("email", null);
                    pref.setString("password", null);
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
