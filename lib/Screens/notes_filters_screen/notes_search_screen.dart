import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quick_notes/Screens/chat_screen/chat_screen.dart';
import 'package:quick_notes/Screens/sign_up_screen/sign_up_screen.dart';
import 'package:quick_notes/constant/constant.dart';
import 'package:quick_notes/globle_variable.dart';
import 'package:quick_notes/text_string_collection/text_string_collection.dart';

class FiltersNotes extends StatefulWidget {
  const FiltersNotes({Key key}) : super(key: key);

  @override
  State<FiltersNotes> createState() => _FiltersNotesState();
}

class _FiltersNotesState extends State<FiltersNotes> {
  TextEditingController controller=TextEditingController();
  TextEditingController controller1=TextEditingController();
  TextEditingController controller2=TextEditingController();
  TextEditingController controller3=TextEditingController();
  List<String>subject=["Physics","Math","Biology","History","Science"];
  List<String>exam=["AQA","Edexcel","IGCSE","Exam Board 1","Exam Board 2"];
  List<String>pricess=["Under 13\$","13\$ to 15\$","15\& to 30\$","Over 30\$","Less than 15\$"];
  List<bool>color=[true,true,true,true,true,];
  List<bool>color1=[true,true,true,true,true,];
  List<bool>color2=[true,true,true,true,true,];
  bool page=false;
  bool prices=false;
  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    return SafeArea(child: Scaffold(
      appBar:  AppBar(
        iconTheme: IconThemeData(color: themeColor1),
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            "Search Notes Preview",
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                color: themeColor1,
              ),
            ),
          ),
        ),
        actions: [
          RotationTransition(
            turns: AlwaysStoppedAnimation(330/365),
            child: IconButton(
              icon:Icon( Icons.send,
                  color: Colors.white),
              onPressed: (){},
            ),
          )
        ],
      ),
      body:SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: width * 0.04,horizontal: width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Trending Prices",style: TextStyle(fontSize: width * 0.05),),
                    Text("Add more",style: TextStyle(fontSize: width * 0.04,color: Colors.white),),
                  ],
                ),
              ),
              SizedBox(height: width * 0.02,),
              Container(
                height: width * 0.2,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                    return Row(
                      children: [
                        InkWell(
                          onTap:(){
                            setState(() {
                              color2[index]=color2[index]?false:true;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: themeColor1),
                                color: color2[index]==false?themeColor1:Colors.white
                            ),
                            padding: EdgeInsets.symmetric(vertical: width * 0.013,horizontal:width  *0.04),
                            margin: EdgeInsets.symmetric(vertical: width * 0.02,horizontal:width  *0.01),
                            child: Text(pricess[index],style: TextStyle(color: color2[index]==false?Colors.white:themeColor1),),
                          ),
                        ),
                      ],
                    );
                  },itemCount:pricess.length ,
                ),
              ),
              SizedBox(height: width * 0.02,),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Select Subject",style: TextStyle(fontSize: width * 0.05),),
                    Text("Add more",style: TextStyle(fontSize: width * 0.04,color: themeColor1),),
                  ],
                ),
              ),
              SizedBox(height: width * 0.02,),
              Container(
                height: width * 0.2,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                  return Row(
                    children: [
                      InkWell(
                        onTap:(){
                          setState(() {
                            color[index]=color[index]?false:true;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: themeColor1),
                            color: color[index]==false?themeColor1:Colors.white
                          ),
                          padding: EdgeInsets.symmetric(vertical: width * 0.013,horizontal:width  *0.04),
                          margin: EdgeInsets.symmetric(vertical: width * 0.02,horizontal:width  *0.01),
                          child: Text(subject[index],style: TextStyle(color: color[index]==false?Colors.white:themeColor1),),
                        ),
                      ),
                    ],
                  );
                },itemCount:subject.length ,
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Select Exam Board",style: TextStyle(fontSize: width * 0.05),),
                    Text("Add more",style: TextStyle(fontSize: width * 0.04,color: themeColor1),),
                  ],
                ),
              ),
              SizedBox(height: width * 0.02,),
              Container(
                height: width * 0.2,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                    return Row(
                      children: [
                        InkWell(
                          onTap:(){
                            setState(() {
                              color1[index]=color1[index]?false:true;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: themeColor1),
                                color: color1[index]==false?themeColor1:Colors.white
                            ),
                            padding: EdgeInsets.symmetric(vertical: width * 0.013,horizontal:width  *0.04),
                            margin: EdgeInsets.symmetric(vertical: width * 0.02,horizontal:width  *0.01),
                            child: Text(exam[index],style: TextStyle(color: color1[index]==false?Colors.white:themeColor1),),
                          ),
                        ),
                      ],
                    );
                  },itemCount:exam.length ,
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.symmetric(vertical: width * 0.02),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Verified Notes",style: TextStyle(fontSize: width * 0.05),),
                    Icon(Icons.arrow_forward_ios,color: themeColor1,)
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.symmetric(vertical: width * 0.02),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Friend Notes Only",style: TextStyle(fontSize: width * 0.05),),
                    Icon(Icons.arrow_forward_ios,color: themeColor1,)
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.symmetric(vertical: width * 0.02),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Free Notes Only",style: TextStyle(fontSize: width * 0.05),),
                    Icon(Icons.arrow_forward_ios,color: themeColor1,),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.symmetric(vertical: width * 0.02),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Show More",style: TextStyle(fontSize: width * 0.05,color: themeColor1),),
                    Icon(Icons.arrow_forward_ios,color: themeColor1,),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.symmetric(vertical: width * 0.02),
                child:Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Number Of Pages",style: TextStyle(fontSize: width * 0.05,),),
                        InkWell(
                            onTap: (){
                              setState(() {
                                page=page?false:true;
                              });
                            },
                            child: Icon(Icons.remove_red_eye_outlined,color: page?themeColor1:Colors.grey,)),
                      ],
                    ),
                    Visibility(
                      visible: page,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width:width * 0.45,
                            child: QuickTextField(
                              title: "Min",
                              icon: Icons.price_change,
                              hintText:"Min",
                              onChange: (value) {},
                              controller: controller,
                            ),
                          ),
                          Container(
                            width:width * 0.45,
                            child: QuickTextField(
                              title: "Max",
                              icon: Icons.price_change,
                              hintText:"Max",
                              onChange: (value) {},
                              controller: controller1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: width * 0.02),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Enter Price limit",style: TextStyle(fontSize: width * 0.05,),),
                        InkWell(
                            onTap: (){
                              setState(() {
                                prices=prices?false:true;
                              });
                            },
                            child: Icon(Icons.remove_red_eye_outlined,color: prices?themeColor1:Colors.grey,)),
                      ],
                    ),
                    Visibility(
                      visible: prices,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width:width * 0.45,
                            child: QuickTextField(
                              title: "Min",
                              icon: Icons.price_change,
                              hintText:"Min",
                              onChange: (value) {},
                              controller: controller2,
                            ),
                          ),
                          Container(
                            width:width * 0.45,
                            child: QuickTextField(
                              title: "Max",
                              icon: Icons.price_change,
                              hintText:"Max",
                              onChange: (value) {},
                              controller: controller3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
        SizedBox(
          height: width * 0.04,
        ),





        InkWell(
          onTap: (){},
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: width * 0.01),
            decoration: BoxDecoration(
                color: themeColor1,
                borderRadius: BorderRadius.circular(30)
            ),
            padding: EdgeInsets.symmetric(vertical: width * 0.025),
            child:
            Text("Show Result (48)",style: TextStyle(fontSize: width * 0.06,color: Colors.white,fontWeight: FontWeight.w100),textAlign: TextAlign.center,)
            ,),
        ),
            ],
          ),
        ),
      ) ,
    ));
  }
}
