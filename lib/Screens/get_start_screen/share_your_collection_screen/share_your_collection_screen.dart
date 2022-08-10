import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:quick_notes/custome_widget/custome_scaffold.dart';
import 'package:quick_notes/globle_variable.dart';
import 'package:quick_notes/text_string_collection/text_string_collection.dart';
import '../../../custome_widget/main_button.dart';
import 'package:page_transition/page_transition.dart';
import '../../../image_collection/A.dart';
import '../../sign_up_screen/sign_up_screen.dart';
import '../../welcome_screen/welcome_screen.dart';

class ShareYourCollection extends StatefulWidget {
  const ShareYourCollection({Key key}) : super(key: key);

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
      indicatorSelectorColor: Color(0xff6c63ff),
      shape: IndicatorShape.circle(size: 12),
    ));
  }
}

class ShareYourNotes extends StatelessWidget {
  const ShareYourNotes({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SvgPicture.asset(A.assets_collection,width: width * 0.7 ,height: width *0.5,),
            Text(TextCollection.text_share_your_notes,style: TextStyle(fontSize:  width * 0.09,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
            Text(TextCollection.text_share_your_notes_subtitle,style: TextStyle(fontWeight: FontWeight.w500,),textAlign: TextAlign.center,),
            SizedBox(height: 10,),
            //TODO :Main button
            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: width * 0.09),
            //   decoration: BoxDecoration(
            //   color: Color(0x9f6c63ff),
            //     borderRadius: BorderRadius.circular(5)
            //   ),
            //   padding: EdgeInsets.symmetric(vertical: width * 0.025),
            //   child:
            //   Text(TextCollection.text_next,style: TextStyle(fontSize: width * 0.06,color: Colors.white),textAlign: TextAlign.center,)
            //   ,)

          ],
        ),
      ),
    );
  }
}

class ConnectWithOthers extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SvgPicture.asset(A.assets_connection, width: width * 0.7 ,height: width *0.5,),
            Text(TextCollection.text_connect_with_others,style: TextStyle(fontSize:  width * 0.08,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
            Text(TextCollection.text_share_your_notes_subtitle,style: TextStyle(fontWeight: FontWeight.w500,),textAlign: TextAlign.center,),
            SizedBox(height: 10,),
            //TODO :Main button
            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: width * 0.09),
            //   decoration: BoxDecoration(
            //   color: Color(0x9f6c63ff),
            //     borderRadius: BorderRadius.circular(5)
            //   ),
            //   padding: EdgeInsets.symmetric(vertical: width * 0.025),
            //   child:
            //   Text(TextCollection.text_next,style: TextStyle(fontSize: width * 0.06,color: Colors.white),textAlign: TextAlign.center,)
            //   ,)

          ],
        ),
      ),
    );
  }
}


class ChatWithFriend extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SvgPicture.asset(A.assets_share, width: width * 0.7 ,height: width *0.5,),
              Text(TextCollection.text_Chat_with_Friend,style: TextStyle(fontSize:  width * 0.08,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
              Text(TextCollection.text_Chat_with_Friend_subtitle,style: TextStyle(fontWeight: FontWeight.w500,),textAlign: TextAlign.center,),
              MainButton(text: TextCollection.text_next,onTap: ()=>    Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft,duration: Duration(milliseconds: 1500), child: WelcomeScreen())),
              )])),
          ),
    );
  }
}

