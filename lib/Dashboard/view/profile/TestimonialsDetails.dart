import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vlesociety/Dashboard/model/TestimonialModel.dart';
import 'package:vlesociety/Dashboard/view/profile.dart';

import '../../../AppConstant/APIConstant.dart';
import '../../../AppConstant/AppConstant.dart';
import '../../../Widget/CustomAppBarWidget.dart';
import '../../controller/DashboardController.dart';

class TestimonialsDetails extends StatelessWidget {
  Datum value1;
   TestimonialsDetails( this.value1, {Key? key}) : super(key: key);
  DashboardController controller = Get.find();

  @override
  Widget build(BuildContext context)
  {
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
        body:value1!=null?
        Padding(
          padding: EdgeInsets.only(left: 20,right: 20),
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                Html(
                    data: value1.description.toString(),
                    style: {
                      "body": Style(
                        fontSize: FontSize(12.0.sp),
                        textAlign: TextAlign.justify,
                      ),
                    },
                    onLinkTap: (String? url,
                        RenderContext context,
                        Map<String, String> attributes,
                        element) async {
                      await launch(url!);
                    }),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.only(top: 5),
                  alignment: Alignment.topCenter,
                  child: CircleAvatar(
                    radius: 60.r,
                    backgroundColor: Colors.blue,
                    backgroundImage: NetworkImage(BASE_URL+value1.profile.toString()),
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,

                  child: Text(
                    value1.name.toString(),
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,



                    ),


                  ),
                ),
                SizedBox(height: 1,),
                Container(
                  alignment: Alignment.topCenter,
                  child:

                  Text(
                    value1.location.toString(),
                    style: TextStyle(
                      fontSize: 15.spMax,
                      fontWeight: FontWeight.w300,

                    ),


                  ),
                )
              ],
            ),
          ),
        ):Container()



    );
  }
}
