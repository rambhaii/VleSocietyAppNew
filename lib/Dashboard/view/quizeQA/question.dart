import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vlesociety/AppConstant/textStyle.dart';
import 'package:vlesociety/Dashboard/model/Quiz_Model/quizq_model.dart';

import '../../../Widget/CircularButton.dart';

import '../../controller/quize_controller.dart';
import 'showresult.dart';
class question extends StatefulWidget {
  final String quizeId;
  const question({Key? key, required this.quizeId}) : super(key: key);

  @override
  State<question> createState() => _questionState();
}
class _questionState extends State<question>
{
  late QuizeController controller;
  bool onTapPressed = false;
  @override
  void initState()
  {

    controller  = Get.put(QuizeController(quizeId:widget.quizeId ));
    controller.getQuizqNetworkApi();
    controller.ind.value=0;
    controller.startTimer();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context)
  {
    print("sdsdfgfdgghd"+controller.secondString.value+""+controller.minuteString.value);
    return Stack(
      children: [
        Scaffold(
          body: Container(
            height: Get.height,
            width: Get.width,
            child: Obx(()=>controller.quizqModel.value.data!=null ?
             Stack(
                children: [
                  Positioned(
                    top: -60,
                    right: 50,
                      child: Container(
                        height: 150,
                        width: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                         color:   Color(0xffcdf55a),
                          ),
                      )
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                    child: Container(
                      color: Colors.white.withOpacity(0.2),
                      child: PageView.builder(
                          itemCount:controller.quizqModel.value.data!.questionList!.length,
                          controller: controller.pageController,
                          physics: NeverScrollableScrollPhysics(),
                          onPageChanged: (value){

                          },
                          itemBuilder: (context, index)
                          {
                            final QuestionList datas=controller.quizqModel.value.data!.questionList![index];
                            return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Question ${index+1}/${controller.quizqModel.value.data!.questionList!.length}",style: bodyText2Style.copyWith(color: Colors.grey),),
                             SizedBox(height: 40,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                padding: EdgeInsets.only(left: 15,right: 15),
                                    child: Text(datas.question.toString(),style: titleStyle.copyWith(fontSize: 20,letterSpacing: 1.5,height: 1.2))),
                                ListView(
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.only(top: 40),
                                  shrinkWrap: true,
                                  children: [
                                    GestureDetector(

                                      onTap:onTapPressed ? null :
                                          ()
                                      {
                                         onTapPressed = true;

                                        controller.selectedIndex.value=0;
                                        Map a={};
                                        a["opt_a"]=datas.optA;
                                        a["opt_b"]=datas.optB;
                                        a["opt_c"]=datas.optC;
                                        a["opt_d"]=datas.optD;
                                        String answer="";
                                        a.keys.forEach((key)
                                        {
                                          if(key.toString().toLowerCase().contains(datas.answer!.toLowerCase()))
                                           {answer=datas.answer.toString();
                                           }}
                                        );
                                        if(answer!="")
                                        {controller.quizqModel.value.data!.questionList![index].correctAns=answer;
                                          print("data");
                                        }
                                        else
                                        {
                                        }
                                        print("sdfhfhd     "+datas.correctAns.toString());
                                        controller.quizqModel.refresh();

                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(left: 20,right: 20,),
                                        padding: EdgeInsets.only(top: 13,bottom: 13),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(color:datas.correctAns.toString().contains("A")?Colors.green.withOpacity(0.7) :datas.correctAns==""?Colors.grey.withOpacity(0.4):Colors.red.withOpacity(0.4),width: 1.3)
                                        ),
                                        child: Text("1. "+datas.optA.toString(),style: bodyText1Style,),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap:onTapPressed ? null :(){
                                        onTapPressed = true;
                                        controller.selectedIndex.value=1;
                                          Map a={};
                                          a["opt_a"]=datas.optA.toString();
                                          a["opt_b"]=datas.optB.toString();
                                          a["opt_c"]=datas.optC.toString();
                                          a["opt_d"]=datas.optD.toString();
                                          String answer="";
                                          a.keys.forEach((key)
                                          {
                                            if(key.toString().toLowerCase().contains(datas.answer!.toLowerCase()))
                                            {answer=datas.answer.toString();
                                            }}
                                          );
                                          if(answer!="")
                                          {controller.quizqModel.value.data!.questionList![index].correctAns=answer;
                                          print("data");
                                          }
                                          else
                                          {
                                          }
                                          print("sdfhfhd     "+datas.correctAns.toString());
                                          controller.quizqModel.refresh();

                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(left: 20,right: 20,top: 15),
                                        padding: EdgeInsets.only(top: 13,bottom: 13),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(color:datas.correctAns.toString().contains("B")?Colors.green.withOpacity(0.7) :datas.correctAns==""?Colors.grey.withOpacity(0.4):Colors.red.withOpacity(0.4),width: 1.3)
                                        ),
                                        child: Text("2. "+datas.optB.toString(),style: bodyText1Style,),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap:onTapPressed ? null :(){
                                        onTapPressed = true;
                                        controller.selectedIndex.value=2;
                                          Map a={};
                                          a["opt_a"]=datas.optA;
                                          a["opt_b"]=datas.optB;
                                          a["opt_c"]=datas.optC;
                                          a["opt_d"]=datas.optD;
                                          String answer="";
                                          a.keys.forEach((key)
                                          {
                                            if(key.toString().toLowerCase().contains(datas.answer!.toLowerCase()))
                                            {answer=datas.answer.toString();
                                            }}
                                          );
                                          if(answer!="")
                                          {controller.quizqModel.value.data!.questionList![index].correctAns=answer;
                                          print("data");
                                          }
                                          else
                                          {
                                          }
                                          print("sdfhfhd     "+datas.correctAns.toString());
                                          controller.quizqModel.refresh();


                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(left: 20,right: 20,top: 15),
                                        padding: EdgeInsets.only(top: 13,bottom: 13),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(color:datas.correctAns.toString().contains("C")?Colors.green.withOpacity(0.7) :datas.correctAns==""?Colors.grey.withOpacity(0.4):Colors.red.withOpacity(0.4),width: 1.3)
                                        ),
                                        child: Text("3. "+datas.optC.toString(),style: bodyText1Style,),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap:onTapPressed ? null :()
                                      {
                                        onTapPressed = true;
                                        controller.selectedIndex.value=3;
                                          Map a={};
                                          a["opt_a"]=datas.optA;
                                          a["opt_b"]=datas.optB;
                                          a["opt_c"]=datas.optC;
                                          a["opt_d"]=datas.optD;
                                          String answer="";
                                          a.keys.forEach((key)
                                          {
                                            if(key.toString().toLowerCase().contains(datas.answer!.toLowerCase()))
                                            {answer=datas.answer.toString();
                                            }}
                                          );
                                          if(answer!="")
                                          {controller.quizqModel.value.data!.questionList![index].correctAns=answer;
                                          print("data");
                                          }
                                          else
                                          {
                                          }
                                          print("sdfhfhd     "+datas.correctAns.toString());
                                          controller.quizqModel.refresh();

                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(left: 20,right: 20,top: 15),
                                        padding: EdgeInsets.only(top: 13,bottom: 13),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(color:datas.correctAns.toString().contains("D")?Colors.green.withOpacity(0.7) :datas.correctAns==""?Colors.grey.withOpacity(0.4):Colors.red.withOpacity(0.4),width: 1.3)
                                             ),
                                        child: Text("4. "+datas.optD.toString(),style: bodyText1Style,),
                                      ),
                                    )
                                  ],
                                )
                                // ListView.builder(
                                //   itemCount: 4,
                                //     shrinkWrap: true,
                                //     physics: NeverScrollableScrollPhysics(),
                                //     itemBuilder:
                                //     (context,index){
                                //   return  Container(
                                //       margin: EdgeInsets.only(left: 20,right: 20,top: 15),
                                //        padding: EdgeInsets.only(top: 13,bottom: 13),
                                //       alignment: Alignment.center,
                                //     decoration: BoxDecoration(
                                //      borderRadius: BorderRadius.circular(5),
                                //       border: Border.all(color: Colors.grey.withOpacity(0.4),width: 1)
                                //     ),
                                //     child: Text("Answer  "+index.toString(),style: bodyText1Style,),
                                //   );
                                // }),
                              ],
                            ),

                          ],
                        );
                      }),
                    ),
                  ),
                  Positioned(
                    right: 20,
                    bottom: Get.height*0.2,
                    child: CircularButton(onPress: ()
                    {
                      if(controller.selectedIndex==-1)
                        {
                          Get.snackbar("Alert!", "Please Select Option",borderRadius: 4,backgroundGradient: LinearGradient(colors: [
                            Colors.amber,Colors.black26
                          ]),
                          icon: Icon(Icons.warning_amber)
                          );
                          return;
                        }
                       onTapPressed = false;
                      controller.jumptopage();
                      },


                    ),
                  ),
                ],
              )

            :Container()),
          ),
        ),
      ],
    );
  }
}
