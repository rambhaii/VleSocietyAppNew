import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:vlesociety/Dashboard/controller/DashboardController.dart';

import '../../AppConstant/APIConstant.dart';
import '../../AppConstant/textStyle.dart';
import 'Community.dart';
import 'MyAsk.dart';
import 'forum.dart';

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
  Widget build(BuildContext context) {
    print("dsvbvdfghfghsjvbs");
    controller.getCommunityNetworkApi();
    return Container(
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
                  ? CarouselSlider(
                      options: CarouselOptions(
                        height: 130.0,
                        viewportFraction: 1,
                      ),
                      items: controller.bannerModel.value.data!.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              height: 130.0,
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(left: 10.0, right: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                  image:
                                  DecorationImage(
                                      image: NetworkImage(
                                          BASE_URL + i.image.toString()),
                                      fit: BoxFit.fill)
                              ),
                            );
                          },
                        );
                      }).toList(),
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
          SizedBox(
            height: 8,
          ),
          Container(
            height: 35,
            child: TabBar(
                onTap: (value) {
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
          // Expanded(
          //   flex: Flex.l,
          //   child: TabBarView(children: [
          //       MyAsk(),
          //       MyAsk(),
          //       MyAsk(),
          //     ]),
          // ),
        ],
      ),
    );
  }
}
