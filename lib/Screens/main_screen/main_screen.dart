import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick_notes/constant/constant.dart';
import 'package:quick_notes/globle_variable.dart';
import 'package:quick_notes/image_collection/A.dart';
import 'package:quick_notes/text_string_collection/text_string_collection.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int currentPage=0;
  List page=[ChatScreen(),TempScreen(num: 2),TempScreen(num: 3),];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: themeColor1,
          title: Text("DashBoard"),
        ),
        bottomNavigationBar:  FancyBottomNavigation(
          initialSelection: 0,
          circleColor: themeColor1,
          inactiveIconColor: themeColor1,
          tabs: [
            TabData(iconData: Icons.home, title: "Home"),
            TabData(iconData: Icons.search, title: "Search"),
            TabData(iconData: Icons.shopping_cart, title: "Basket")
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
            ],
          ),
        ),
        body:page[currentPage]
      ),
    );
  }
}

class TempScreen extends StatelessWidget {
  int num;
  TempScreen({this.num});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Text(num.toString()),
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SvgPicture.asset(A.assets_empty_chat,width: width * 0.5,height: width *0.4,),
          SizedBox(
            height:width * 0.06 ,
          ),
          Text(TextCollection.text_no_message,style: TextStyle(fontSize: width * 0.06,fontWeight: FontWeight.w100),textAlign: TextAlign.center,),
          SizedBox(
            height:width * 0.04 ,
          ),
          Text(TextCollection.text_no_message_subtitle_1,style: TextStyle(fontWeight: FontWeight.w500,),textAlign: TextAlign.center,),
          Text(TextCollection.text_no_message_subtitle_2,style: TextStyle(fontWeight: FontWeight.w500,),textAlign: TextAlign.center,),


        ],
      ),
    );
  }
}
