import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vlesociety/Dashboard/model/TestimonialModel.dart';
import 'package:vlesociety/Dashboard/view/profile.dart';

import '../../../AppConstant/APIConstant.dart';
import '../../controller/DashboardController.dart';

class TestimonialsDetails extends StatelessWidget {
  Datum value1;
   TestimonialsDetails( this.value1, {Key? key}) : super(key: key);
  DashboardController controller = Get.find();

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
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
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: AppBar(
                    backgroundColor: Colors.white.withOpacity(0.5),
                    leading: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.amber.withOpacity(0.1),
                        backgroundImage: NetworkImage(BASE_URL+controller.image),
                      ),
                    ),
                    leadingWidth: 60,
                    title: Text(controller.userName.toString(), style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    elevation: 0.0,
                    actions: [
                      RawMaterialButton (
                        constraints: BoxConstraints(maxHeight: 40, minWidth: 40),
                        onPressed: () {
                          Get.to(()=>Profile());
                          //  controller.logout();
                        },
                        shape: CircleBorder(
                            side: BorderSide(width: 0.5, color: Colors.black)),
                        child: Image.asset("assets/images/menu.png",
                          height: 15,
                          width: 20,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      )

                    ],
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
