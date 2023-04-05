

import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../../../AppConstant/textStyle.dart';
import '../../controller/quize_controller.dart';
import '../../model/Quiz_Model/quizq_model.dart';

class QuestionHistory extends StatefulWidget
{  final String quizeId;
     var selectedAnsList;
   QuestionHistory( this.quizeId, this. selectedAnsList, {Key? key}) : super(key: key);

  @override
  State<QuestionHistory> createState() => _QuestionHistoryState();
}

class _QuestionHistoryState extends State<QuestionHistory>
{
   late QuizeController controller;
   @override
   void initState()
   {
     controller  = Get.put(QuizeController(quizeId:widget.quizeId ));
     controller.getQuizqNetworkApi();
     // TODO: implement initState
     super.initState();
   }

  @override
  Widget build(BuildContext context)
  {
   print("hfgjsghs"+widget.selectedAnsList.toString());
    return
      Scaffold(
      appBar: PreferredSize(
    child: Stack(
    children: [
    Positioned(
        top: -80,
        right: 60,
        child: Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:   Color(0xffcdf55a),

          ),
        )
    ),
    ClipRRect(
    child: BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
    child: AppBar(
    backgroundColor: Colors.white.withOpacity(0.5),
    leading: Container(
    height: 8,
    width: 8,
    decoration: BoxDecoration(

    ),
    child: IconButton(
    onPressed:()=> Navigator.of(context).pop(),
    icon: Icon(Icons.arrow_back_ios_new,color: Colors.black,),),
    ),
    elevation: 0.0,
    leadingWidth: 60,

  /*  title: title!=null?
    Text(title, style: subtitleStyle.copyWith(fontWeight: FontWeight.w900,fontSize: 16)
    ):Text("", style: TextStyle(color: Colors.black, fontSize: 16)
    ),*/
    )
    ),
    ),
    ]
    ),
    preferredSize: Size(
    double.infinity,
    60.0,
    ),
    ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Obx(() =>
            controller.quizqModel.value.data!= null
                ?
            ListView.builder(
                shrinkWrap: true,
                itemCount:controller.quizqModel.value.data!.questionList!.length,
                physics: ScrollPhysics(),
                itemBuilder: (context,index)
                {
                  final datas = controller.quizqModel.value.data!.questionList![index];
                  return Container(

                    margin: EdgeInsets.only(left: 15,right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Padding(
                          padding: EdgeInsets.only(right: 0),
                          child: Text("Q.${index+1} "+datas.question.toString(),style: titleStyle.copyWith(fontSize: 16,letterSpacing: 1.5,height: 1.2))
                          ),
                        SizedBox(height: 10,),
                        Padding(padding: EdgeInsets.only(left: 20,top: 0,bottom: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                          [


                            Text("1. "+datas.optA.toString(),style: bodyText1Style.copyWith(color:datas.answer.toString().contains("A")?Colors.green:Colors.black54),),
                            Text("2. "+datas.optB.toString(),style: bodyText1Style.copyWith(color:datas.answer.toString().contains("B")?Colors.green:Colors.black54),),
                            Text("3. "+datas.optC.toString(),style: bodyText1Style.copyWith(color:datas.answer.toString().contains("C")?Colors.green:Colors.black54),),
                            Text("4. "+datas.optD.toString(),style: bodyText1Style.copyWith(color:datas.answer.toString().contains("D")?Colors.green:Colors.black54),),
                          //  Text("Select Answer : "+datas.answer.toString(),style: bodyText1Style.copyWith(color:widget.selectedAnsList.toString().contains(datas.answer.toString())?Colors.red:Colors.black54),),




                          ],
                        ),


                      )


                      ],
                    ),
                  );
                }
                )
                :Container()),

          ],
        ),
      ),
    );;
  }
}
