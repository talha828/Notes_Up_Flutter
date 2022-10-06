import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:quick_notes/Screens/get_start_screen/chat_with_friend_screen/chat_with_friend_screen.dart';
import 'package:quick_notes/Screens/get_start_screen/connect_with_others_screen/connect_with_others_screen.dart';
import 'package:quick_notes/Screens/get_start_screen/share_yours_notes_screen/share_your_notes_screen.dart';
import 'package:quick_notes/constant/constant.dart';
import 'package:quick_notes/custome_widget/custome_scaffold.dart';
import 'package:quick_notes/globle_variable.dart';
import 'package:quick_notes/text_string_collection/text_string_collection.dart';
import '../../../custome_widget/main_button.dart';
import 'package:page_transition/page_transition.dart';
import '../../../image_collection/A.dart';
import '../../sign_up_screen/sign_up_screen.dart';
import '../../welcome_screen/welcome_screen.dart';

class ShareYourCollection extends StatefulWidget {


  @override
  State<ShareYourCollection> createState() => _ShareYourCollectionState();
}

class _ShareYourCollectionState extends State<ShareYourCollection> {
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: PageIndicatorContainer(
      child: PageView(
        children: <Widget>[
          ShareYourNotes(),
          ConnectWithOthers(),
          ChatWithFriend(),
        ],
        controller: controller,
      ),
      align: IndicatorAlign.bottom,
      length: 3,
      indicatorSpace: 20.0,
      padding: const EdgeInsets.symmetric(vertical: 25),
      indicatorColor: Colors.white,
      indicatorSelectorColor: themeColor1,
      shape: IndicatorShape.circle(size: 12),
    ));
  }
}







