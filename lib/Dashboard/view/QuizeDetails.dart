
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:vlesociety/AppConstant/textStyle.dart';
import 'package:vlesociety/Dashboard/controller/DashboardController.dart';
import 'package:vlesociety/Dashboard/model/QuizModel.dart';
import 'package:vlesociety/Dashboard/view/quizeQA/question.dart';

import '../../AppConstant/APIConstant.dart';
import '../../UtilsMethod/UtilsMethod.dart';


class QuizeDetails extends StatelessWidget
{  DashboardController controller = Get.find();

final Datum data;
QuizeDetails(this.data);

@override
Widget build(BuildContext context) {
  controller.getQuizNetworkApi();
  var desc = parse(data.description);
  String parsedString = parse(desc.body!.text).documentElement!.text;
  return Scaffold(
      floatingActionButton:  Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 40,
          margin: const EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
          width: double.infinity,
          child:data.id!=null ? ElevatedButton(
              onPressed: ()
              { if (controller.userType == "Guest")
              {
              UtilsMethod.PopupBox(context, "Attempt quiz");
              } else {
                Get.to(() => question(quizeId: data.id.toString()));
              } },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white)
              ),
              child:Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Attempt".toUpperCase(),style: bodyText2Style.copyWith(color: Colors.blue),)
                ],
              ) // trying to move to the bottom
          ):Column()
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: PreferredSize(
        child: Stack(
          children: [
            Positioned(
                top: -80.h,
                right: 60.w,
                child: Container(
                  height: 150.h,
                  width: 150.w,
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
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment:MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 5.h,),
                      Text(data.title.toString(),
                        style: subtitleStyle.copyWith(fontWeight: FontWeight.w900,fontSize: 14.sp),maxLines: 1,overflow: TextOverflow.ellipsis,),
                     SizedBox(height: 3.h,),
                      Text(data.totalPoints.toString()+  "  Point".toUpperCase(),
                        style: smallTextStyle.copyWith(color: Colors.blue,fontSize: 12.sp),maxLines: 1,overflow: TextOverflow.ellipsis,),
                    ],
                  ),
                  backgroundColor: Colors.white.withOpacity(0.5),
                  leading: Padding(
                      padding: EdgeInsets.only(left: 10.0.w),
                      child: Container(
                        height: 8.h,
                        width: 8.w,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle
                        ),
                        child: IconButton(onPressed: ()
                        {
                          Get.back();
                        },icon: Icon(Icons.arrow_back_ios_new,color: Colors.black,),),
                      )

                  ),
                  leadingWidth: 50.w,
                  elevation: 0.0,
                ),
              ),
            ),
          ],
        ),
        preferredSize: Size(
          double.infinity,
          60.0,
        ),
      ),
      body: Obx(()=>controller.quizModel.value.data!=null?
      SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 15.w,right: 15.w,top: 1.h),
                child: Card(
                  shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Container(
                    height: 190.h,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage
                          (
                            image: NetworkImage(BASE_URL+data.image.toString()),fit: BoxFit.fill
                        )
                    ),
                  ),
                ),
              ),

              Container(
                  padding: EdgeInsets.only(left: 15,right: 15,top: 20,),
                  width: MediaQuery.of(context).size.width,
                  child:data.description!=null?
                  Text(parsedString
                    ,maxLines: 15,overflow: TextOverflow.ellipsis,textAlign: TextAlign.justify,
                    style: bodyText2Style.copyWith(color: Colors.black.withOpacity(0.6)),):
                  Container()

              ),
            ],
          ),
        ),
      )
          :Container())
  );
}
}