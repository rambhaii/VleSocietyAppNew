import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:html/parser.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../AppConstant/APIConstant.dart';
import '../../../AppConstant/AppConstant.dart';
import '../../../AppConstant/textStyle.dart';
import '../../../Widget/CustomAppBarWidget.dart';
import '../../controller/DashboardController.dart';
import '../profile.dart';

class PressMedia extends StatelessWidget {
   PressMedia({Key? key}) : super(key: key);
  DashboardController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      PreferredSize(
          preferredSize: Size(
            double.infinity,
            60.0,
          ),
          child: CustomAppBar(
              title: GetStorage().read(AppConstant.userName),
              Points: controller.points,
              image:BASE_URL+GetStorage().read(AppConstant.profileImg)
          )
      ),
       body: Obx(() =>controller.pressMediaData.value.data!=null?
           ListView.builder(itemCount:controller.pressMediaData.value.data?.length ,
               itemBuilder: (context,index)
       {
          final data = controller.pressMediaData.value.data![index];
          var desc = parse(data.description);
          String parsedString = parse(desc.body!.text).documentElement!.text;
         return Padding(
           padding: const EdgeInsets.only(left: 8,right: 8,bottom: 5),
           child: Card(

             shadowColor: Colors.white,
             shape:RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(10.0),
             ),
             child: Padding(
               padding: const EdgeInsets.only(right: 6.0),
               child: Container(

                 height:65.h,
                 decoration: BoxDecoration(
                 ),
                 child: InkWell(
                   onTap: (){
                     controller.getPressMediaDetailsNetWorkApi(data.id.toString(),context);
                   },
                   child: Row(
                     children: [
                       SizedBox(width: 15,),
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text(data.title.toString(),style: bodyText1Style.copyWith(fontSize: 13),),
                           data.description!=null?
                           Container(
                               width: Get.width/1.5,
                               child:  Text(parsedString
                                 ,maxLines: 2,overflow: TextOverflow.ellipsis,
                                 style: bodyText2Style.copyWith(color: Colors.black.withOpacity(0.6)),),
                             ):Center()
                               //Text(data.description.toString(),style: bodyText1Style.copyWith(fontSize: 13,color: Colors.black87))),
                         ],
                       ),
                       Spacer(),
                       Container(
                         height: 70,
                         width: 70,
                         child: CircleAvatar(
                           radius: 10,
                           backgroundColor: Colors.amber.withOpacity(0.1),
                           backgroundImage: NetworkImage(BASE_URL+data.image.toString()),
                         ),
                       ) ,



                     ],
                   ),
                 ),
               ),
             ),
           ),
         );
       }
       ):Container()
       )


    );
  }
}
