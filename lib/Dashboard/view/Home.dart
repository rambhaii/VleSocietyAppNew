import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vlesociety/Dashboard/controller/DashboardController.dart';
import 'package:vlesociety/Dashboard/view/profile/PointRedeem.dart';
import 'package:vlesociety/Dashboard/view/quize.dart';
import '../../AppConstant/APIConstant.dart';
import '../../AppConstant/textStyle.dart';
import 'Community.dart';
import 'MyAsk.dart';
import 'Services.dart';


class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  DashboardController controller = Get.find();

  late TabController tabController;
  AnimationController? _controller;
  Animation<double>? _animation;


  @override
  void initState()
  {
    super.initState();

    controller.getBannerNetworkApi();
    controller.getgetUserDetailsNetworkApi();

    controller.getCommunityNetworkApi();
    tabController = TabController(length: 2, vsync: this);
    _controller = AnimationController(
        duration: const Duration(seconds: 1),
        vsync: this,
        value: 0,
        lowerBound: 0,
        upperBound: 1);
    _animation =
        CurvedAnimation(parent: _controller!, curve: Curves.fastOutSlowIn);
    _controller!.forward();


  }

  @override
  void dispose() {

    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    controller.getCommunityNetworkApi();
    controller.selectedComunityIndex.value = 0;
    return
      Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 8,
          ),

          Container(
            child: Obx(
              () => controller.bannerModel.value.data != null
                  ? Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                    child: CarouselSlider(
                        options: CarouselOptions(
                          height: 190.0,
                          viewportFraction: 1,
                          aspectRatio: 16/9,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration: Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.3,
                          scrollDirection: Axis.horizontal,
                        ),
                        items: controller.bannerModel.value.data!.map((i)
                        {
                          return Builder(
                            builder: (BuildContext context)
                            {
                              return InkWell(
                                onTap: ()
                                async
                                {

                                  if(i.rediret_type.toString()=="1")
                                    {
                                      //Get.to(ServicePage());
                                      controller.selectedIndex.value = 2;
                                    }
                                  else if(i.rediret_type.toString()=="2")
                                    {
                                      controller.selectedIndex.value = 3;
                                      //Get.to(QuizPage());
                                    }
                                  else if(i.rediret_type.toString()=="3")
                                  {
                                    controller.selectedIndex.value = 0;
                                    //Get.to(QuizPage());
                                  }
                                  else if(i.rediret_type.toString()=="4")
                                  {
                                    controller.selectedIndex.value = 1;
                                    //Get.to(QuizPage());
                                  }
                                  else if(i.rediret_type.toString()=="5")
                                  {
                                    controller.selectedIndex.value = 2;
                                    //Get.to(QuizPage());
                                  }
                                  else if(i.rediret_type.toString()=="6")
                                  {
                                    controller.selectedIndex.value = 4;
                                    //Get.to(QuizPage());
                                  }
                                  else if(i.rediret_type.toString()=="7")
                                  {
                                  controller.gettransactionPointsDetails();

                                  }
                                  else if(i.rediret_type.toString()=="8")
                                  {

                                  controller.getReferalPointsDetailNetworkApi();
                                  }
                                  else if(i.rediret_type.toString()=="0")
                                    {
                                      await launch(i.url!=null?i.url.toString():"");
                                    }

                                  },
                                child:
                                Column(
                                  children: [
                                    Container(
                                      height: 110.0.h,
                                      width: MediaQuery.of(context).size.width,
                                     // margin: EdgeInsets.only(left: 10.0, right: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.white,
                                        image:
                                        DecorationImage
                                          (
                                          image: NetworkImage(BASE_URL + i.image.toString()),
                                          fit: BoxFit.fill,
                                             ),),),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0,left: 30,right: 30),
                                      child: Text(i.title.toString(),
                                        style: bodyText1Style.copyWith(
                                              color: Colors.black54,
                                              fontSize: 12,
                                             letterSpacing:1
                                          ),
                                          maxLines: 2,


                                      ),
                                    )
                                  ],
                                ));
                            },
                          );
                        }).toList(),
                      ),
                  )
                  : Container(
                      height: 130.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                    ),
            ),
          ),

          Container(
            height: 35,
            child: TabBar(
                onTap: (value)
                {
                  controller.selectedComunityIndex.value = value;
                  if (value == 1)
                  {
                    controller.getAskApi();
                  }
                },
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black.withOpacity(0.56),
                isScrollable: true,
                controller: tabController,
                labelStyle: bodyText1Style.copyWith(fontSize: 12),
                unselectedLabelStyle: bodyText2Style.copyWith(fontSize: 12),
                indicatorPadding: EdgeInsets.zero,
                indicatorColor: Colors.transparent,
                padding: EdgeInsets.zero,
                tabs: [
                  const Tab(
                    child: Text("COMMUNITY"),
                  ),
                  const Tab(
                    child: Text("MY ASK"),
                  ),
                ]),
          ),
          Obx(
            () => Container(
              child: controller.selectedComunityIndex.value == 0
                  ? FadeTransition(opacity: _animation!, child: CommunityPage())
                  : controller.selectedComunityIndex.value == 1
                      ? MyAsk()
                      : Container(),
            ),
          )

        ],
      ),
    );




  }


  void showAlertBox()
  {
    Get.defaultDialog
      (

        title: 'Are you sure!',
        titleStyle: TextStyle(fontSize: 20),
        middleText: 'if you want to logout please press Yes otherwise No',
        backgroundColor: Colors.white,
        radius:5,
        textCancel: 'No',

        textConfirm: 'yes',
        onCancel: (){},
        onConfirm: ()
        {  controller.logout();

        }
    );




  }

}

