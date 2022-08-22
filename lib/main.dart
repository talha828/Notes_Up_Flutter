import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quick_notes/Screens/get_start_screen/share_your_collection_screen/share_your_collection_screen.dart';
import 'package:quick_notes/Screens/main_screen/main_screen.dart';
import 'package:quick_notes/Screens/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quick_notes/Screens/upload_screen/upload_from_gallery/upload_from_gallery.dart';
import 'package:quick_notes/constant/constant.dart';
import 'package:quick_notes/model/chat_model.dart';
import 'package:quick_notes/model/file_details_model.dart';
import 'package:quick_notes/model/search_chat_model.dart';
import 'package:quick_notes/model/search_notes.dart';
import 'package:quick_notes/model/user_details.dart';
import 'package:quick_notes/model/user_model.dart';

import 'Screens/login_screen/login_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserModel>(create:(_)=> UserModel()),
        ChangeNotifierProvider<StoreFile>(create:(_)=> StoreFile()),
        ChangeNotifierProvider<UserDetails>(create:(_)=> UserDetails()),
        ChangeNotifierProvider<SearchNotes>(create:(_)=> SearchNotes()),
        ChangeNotifierProvider<SearchChatModel>(create:(_)=> SearchChatModel()),
        ChangeNotifierProvider<ChatList>(create:(_)=> ChatList()),
      ],
      child: MaterialApp(


        theme: ThemeData(
          primaryColor: themeColor1,
          primaryTextTheme:GoogleFonts.montserratTextTheme(
            Theme.of(context).textTheme,
          ),
          textTheme: GoogleFonts.montserratTextTheme(
            Theme.of(context).textTheme,
          )
        ),
        home: SplashScreen(),
      ),
    );
  }
}

