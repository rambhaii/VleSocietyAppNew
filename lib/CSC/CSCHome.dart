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
import 'package:url_launcher/url_launcher.dart';
import 'package:vlesociety/CSC/CSCPage.dart';
import 'package:vlesociety/Dashboard/controller/DashboardController.dart';

import '../../AppConstant/APIConstant.dart';
import '../../AppConstant/textStyle.dart';
import '../Dashboard/model/ArticalModel.dart';
import '../Dashboard/view/MyAsk.dart';
import '../Dashboard/view/ServicesDescription.dart';
import '../Widget/loading_widget.dart';
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
    controller.getServicesCSCNetworkApi();
    controller.getArticleByCategoryNetworkApi( "7");
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



                      ),
                      items: controller.bannerModel.value.data!.map((i)
                      {
                        return Builder(
                          builder: (BuildContext context) {
                            return InkWell(
                              onTap: ()
                              async{
                                await launch(i.url!=null?i.url.toString():"");
                              },
                              child: Container(
                                height: 130.h,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(left: 12.0.w, right: 12.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white,
                                    image: DecorationImage(
                                        image: NetworkImage(BASE_URL + i.image.toString()), fit: BoxFit.fill)),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 65.0,left: 5,right: 5),
                                    child: Text(i.title.toString(),
                                        style: bodyText1Style.copyWith(
                                            color: Colors.white,
                                            fontSize: 15
                                        ),overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                        textAlign: TextAlign.center

                                    ),
                                  ),

                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    )
                  :
              Container(
                      height: 130.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
          SizedBox(height: 10,),
          controller.articleModelByCategory.value.data!.isNotEmpty? Column(children:
          [Obx(
             ()=> controller.articleModelByCategory.value.data != null?
         Column(
           children: [
            Container(
              height:130.h,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                 scrollDirection: Axis.horizontal,
                  itemCount: controller.articleModelByCategory.value.data!.length,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context,int index)
                  {
                    final data=controller.articleModelByCategory.value.data![index];
                     return Container(
                       height: 130.h,
                       width: 160.w,
                       child: GestureDetector(
                       onTap: (){
                          Get.to(()=>CscDetails(data));
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
                                 imageUrl: BASE_URL + data.image.toString(),
                                 height: 55.h,
                                 width: 75.h,
                                 placeholder: (context, url) =>
                                     Center(child: const CircularProgressIndicator()),
                                 errorWidget: (context, url, error) =>
                                 const Icon(Icons.error),
                               ),
                             ),
                             Padding(
                               padding: const EdgeInsets.only(left: 8.0,right: 8,top: 8,bottom: 8),
                               child: Text(data.title.toString(),
                                 style: bodyText1Style.copyWith(fontSize: 12.sp),overflow: TextOverflow.ellipsis,
                                 //   textAlign: TextAlign.justify,
                                 maxLines: 3,),
                             )],

                         ),
                       ),
                   ),
                     );
              }),
            )
           ],
         ):
             Center(child: CupertinoActivityIndicator(),),
       ),
            controller.isLoadingCSCPage.value?const LoadingWidget():Container(),],):Container(),

          SizedBox(height: 25,),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text("CSC SERVICES", style: titleStyle.copyWith(fontWeight: FontWeight.w800,fontSize: 19,height:.3)),
          ),
          SizedBox(height: 10,),
          FadeTransition(opacity: _animation!, child: Obx(
                () => controller.serviceCSCModel.value.data != null
                ? GridView.count(
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                crossAxisSpacing: 10,
                mainAxisSpacing: 1,
                crossAxisCount: 3,
                children: List.generate(
                  controller.serviceCSCModel.value.data!.length,
                      (index) => GestureDetector(
                    onTap: ()
                    {
                          controller.serviceCSCModel.value.data![index].is_gosite=='0'?
                          controller.getServicesCSCSubCategoryNetworkApi(controller.serviceCSCModel.value.data![index].id.toString(),
                          controller.serviceCSCModel.value.data![index].title.toString())
                          :Get.to(ServicesDescription( controller.serviceCSCModel.value.data![index].description.toString(),
                          controller.serviceCSCModel.value.data![index].url.toString(),
                          controller.serviceCSCModel.value.data![index].title.toString(),
                          controller.serviceCSCModel.value.data![index].image.toString()));

                      // Get.to(SubCategoryOfServices( controller.serviceModel.value.data![index].id.toString()))
                      //  UtilsMethod.launchUrls(controller.serviceModel.value.data![index].url.toString());
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 55.h,
                          width: 55.w,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors
                                      .white
                                      .withOpacity(
                                      0.8),
                                  offset: Offset(
                                      -3.0, -3.0),
                                  blurRadius: 10.0,
                                ),
                                BoxShadow(
                                  color: Colors
                                      .black
                                      .withOpacity(
                                      0.1),
                                  offset: Offset(
                                      3.0, 3.0),
                                  blurRadius: 10.0,
                                ),
                              ],
                              color: Colors.white,
                              image: DecorationImage(
                                  image: NetworkImage(BASE_URL +
                                      controller.serviceCSCModel.value.data![index].image.toString()),fit: BoxFit.fill)),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          controller.serviceCSCModel.value.data![index].title.toString(),
                          style: smallTextStyle.copyWith(fontSize: 11.sp),
                          maxLines: 1,
                          overflow:
                          TextOverflow.ellipsis,
                          textAlign:
                          TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ))
                : Center(
              child: CupertinoActivityIndicator(),
            ),
          ))

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
