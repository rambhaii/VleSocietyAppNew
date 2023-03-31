import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vlesociety/CSC/CSCPage.dart';
import 'package:vlesociety/Dashboard/controller/DashboardController.dart';

import '../../AppConstant/APIConstant.dart';
import '../../AppConstant/textStyle.dart';
import '../Dashboard/model/ArticalModel.dart';
import '../Dashboard/view/MyAsk.dart';
import 'View/CscDetails.dart';

class CSCHome extends StatefulWidget {
  CSCHome({super.key});

  @override
  State<CSCHome> createState() => _CSCHomeState();
}

class _CSCHomeState extends State<CSCHome> with TickerProviderStateMixin {
  DashboardController controller = Get.find();

  late TabController tabController;
  AnimationController? _controller;
  Animation<double>? _animation;
  @override
  void initState() {
    super.initState();
    controller.getCscNetworkApi();
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
    return Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 8.h,
          ),
          Container(
            child: Obx(
              () => controller.bannerModel.value.data != null
                  ? CarouselSlider(
                      options: CarouselOptions(
                        height: 130.h,
                        viewportFraction: 1,
                      ),
                      items: controller.bannerModel.value.data!.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              height: 130.h,
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(left: 12.0.w, right: 12.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                  image: DecorationImage(
                                      image: NetworkImage(BASE_URL + i.image.toString()), fit: BoxFit.fill)),
                            );
                          },
                        );
                      }).toList(),
                    )
                  : Container(
                      height: 130.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        /*  SizedBox(
            height: 8,
          ),
          Container(
            height: 35,
            child: TabBar(
                onTap: (value)
                {
                  controller.selectedComunityIndex.value = value;
                  if (value == 1) {
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
                    child: Text("CSE NEWS"),
                  ),
                  const Tab(
                    child: Text("SHOP"),
                  ),
                  const Tab(
                    child: Text("REWARDS"),
                  ),
                ]),
          ),
          Obx(
            () => Container(
              child: controller.selectedComunityIndex.value == 0
                  ? FadeTransition(opacity: _animation!, child: CSCPage())
                  : controller.selectedComunityIndex.value == 1
                      ? Container()
                      : Container(),
            ),
          )*/
          SizedBox(height: 10,),

      Obx(()=> controller.cscModel.value.data != null?
      Column(
      children: [
        GridView.count(
          physics: ScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
          childAspectRatio: 3/2.6,
          shrinkWrap: true,
          children: List.generate(controller.cscModel.value.data!.length, (index)
          {

            final datas = controller.cscModel.value.data![index];
            return GestureDetector(
              onTap: (){
                Get.to(()=>CscDetails(datas));
              },
              child: Card(
                color: Colors.white,
                shadowColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
                ),
                elevation: 2,
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10,),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: BASE_URL + datas.image.toString(),
                        height: 65.h,
                        width: 55.h,
                        placeholder: (context, url) =>
                            Center(child: const CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                      ),
                    ),
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Text(datas.title.toString(),
                           style: bodyText1Style.copyWith(fontSize: 12.sp),overflow: TextOverflow.ellipsis,
                        //   textAlign: TextAlign.justify,
                           maxLines: 3,),
                       )],

                ),
              ),
            );
          },),
        ),
      ],
    ):
      Center(
        child: CupertinoActivityIndicator(),
      ),
  )






        ],
      ),
    );
  }


  void _showBottomSheet(BuildContext context, ArticleDatum datum)
  {
    showModalBottomSheet(
      context: context,
      barrierColor: Colors.black.withOpacity(0.12),
      isScrollControlled: true,
      backgroundColor: Colors.white70,
      builder: (context)
      {
        return
          ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
                padding: EdgeInsets.all(10),
                height: Get.height - 90.h,
                width: double.infinity,
                color: Colors.white70,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      width: 40,
                      height: 6,
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.5, color: Colors.black26),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: BASE_URL + datum.image.toString(),
                        height: 200,
                        width: double.infinity,
                        placeholder: (context, url) =>
                            Center(child: const CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    Container(
                      height: Get.height / 2 + 20,
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              datum.title.toString(),
                              style: bodyText1Style,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              height: 3,
                              thickness: 2,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Html(data: datum.description.toString()),
                          ],
                        ),
                      ),
                    ),
                    // ListView.separated(itemBuilder: itemBuilder, separatorBuilder: separatorBuilder, itemCount: itemCount)
                  ],
                )),
          ),
        );
      },
    );
  }

}
