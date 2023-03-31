import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vlesociety/AppConstant/textStyle.dart';

import 'QuestionHistory.dart';
class showresult extends StatelessWidget {
  final String ttCorrect;
  final String ttInCorrect;
  final String quize_id;
  final List<String> selectedAnsList;

  const showresult(this.selectedAnsList, {Key? key, required this.ttCorrect, required this.ttInCorrect, required this.quize_id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("dsjghkdjfmjdjfh"+quize_id);
    return Scaffold(

      body: Stack(
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
            child: Center(
              child: Container(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Congratulations!",style: subtitleStyle.copyWith(fontSize: 26)),
                    SizedBox(height: MediaQuery.of(context).size.height/10,),
                    Text("You have successfully completed",style: subtitleStyle,),
                    SizedBox(height: 20,),
                    Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(onPressed: (){},
                            child: Row(
                              children: [
                                Icon(Icons.check,color:Colors.green.shade600,size: 19),
                                Text(" $ttCorrect Correct",style:smallTextStyle,),
                              ],
                            ),style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                      backgroundColor:MaterialStateProperty.all(Colors.grey.shade200),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                           ),),
                          )),
                        SizedBox(width: 20,),
                        TextButton(onPressed: (){},
                            child: Row(
                              children: [
                                Icon(Icons.close,color:Colors.red,size: 19,),
                                Text(" $ttInCorrect Incorrect",style: smallTextStyle,),
                              ],
                            ),style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                              backgroundColor:MaterialStateProperty.all(Colors.grey.shade200),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          elevation: 0,
                          shape: BeveledRectangleBorder(side: BorderSide(color: Colors.grey.shade300),
                              borderRadius:BorderRadius.circular(4) )
                      ),
                      onPressed: (){
                        Share.share(
                            subject:"Quize Result", "$ttCorrect Correct & $ttInCorrect Incorrect");
                      },child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: Text("Share Result",style: subtitleStyle,),
                        ),
                        Container(
                          width:MediaQuery.of(context).size.width*0.6,
                          decoration: BoxDecoration(
                          ),
                        )
                      ],
                    ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          elevation: 0,
                          shape: BeveledRectangleBorder(side: BorderSide(color: Colors.grey.shade300),
                              borderRadius:BorderRadius.circular(4) )
                      ),
                      onPressed: ()
                      {
                        print("jkdsfhhjg"+selectedAnsList.toString());
                       Get.to(QuestionHistory(quize_id,selectedAnsList));
                      },child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: Text("Show Result",style: subtitleStyle.copyWith(fontWeight: FontWeight.w400),),
                        ),
                        Container(
                          width:MediaQuery.of(context).size.width*0.6,
                          decoration: BoxDecoration(
                          ),
                        )
                      ],
                    ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          elevation: 0,
                          shape: BeveledRectangleBorder(side: BorderSide(color: Colors.grey.shade300),
                              borderRadius:BorderRadius.circular(4) )
                      ),
                      onPressed: (){
                        Navigator.pop(context);
                      },child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: Text("Attempt New Quiz",style: subtitleStyle.copyWith(fontWeight: FontWeight.w400),),
                        ),
                        Container(
                          width:MediaQuery.of(context).size.width*0.6,
                          decoration: BoxDecoration(
                          ),
                        )
                      ],
                    ),
                    ),

                  ],
                ),
              ),
            ),
          ),

          Positioned(
              top: 100,
              left: 0,
              right: 0,
            child: Lottie.asset('assets/json/confetti.json',
                repeat: false,
                frameRate: FrameRate.max
                ,fit:BoxFit.fill),
          )
        ],
      ),
    );
  }
}
