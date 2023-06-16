import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vlesociety/AppConstant/APIConstant.dart';
import 'package:vlesociety/AppConstant/AppConstant.dart';
import 'package:vlesociety/Dashboard/controller/DashboardController.dart';
import 'package:vlesociety/Widget/CustomAppBarWidget.dart';

import '../SingleImageView.dart';
class AboutCSC extends StatefulWidget {
  const AboutCSC({Key? key}) : super(key: key);

  @override
  State<AboutCSC> createState() => _AboutCSCState();
}

class _AboutCSCState extends State<AboutCSC> {
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
      body: Obx(()=> controller.aboutCscModel.value.data!=null
          ?
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
                itemCount: controller.aboutCscModel.value.data!.id!.length,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder:
                    (context,index){
                  return Padding(
                    padding: const EdgeInsets.only(left: 12,right: 12,),
                    child: Column(
                      children: [
                        Container(
                          child: Card(
                            shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: InkWell(
                            onTap: (){
                            Get.to(SingleImageView(BASE_URL +  controller.aboutCscModel.value.data!.
                            image.toString()));
                            },
                              child: Container(
                                height: 170.h,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: NetworkImage(BASE_URL+controller.aboutCscModel.value.data!.
                                        image.toString()),fit: BoxFit.fill
                                    )
                                ),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5,),
                            Row(
                              children:
                              [
                                Text(controller.aboutCscModel.value.data!.title.toString()
                                  ,style: TextStyle(fontSize: 23),textAlign: TextAlign.justify,),
                              ],
                            ),
                            SizedBox(height: 1,),

                            Html(
                                data: controller.aboutCscModel.value.data!.description.toString(),
                                style: {
                                  "body": Style(
                                    fontSize: FontSize(16.0),
                                    //letterSpacing: 1.1,
                                    textAlign: TextAlign.justify,
                                    lineHeight: LineHeight(1.8),
                                  ),
                                },
                                onLinkTap: (String? url,

                                    Map<String, String> attributes,
                                    element) async {
                                  await launch(url!);
                                }),
                          ],
                        ),
                      ],
                    ),
                  );
                })
          ],
        ),
      ):Container()
      ),
    );
  }
}