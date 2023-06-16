import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:vlesociety/Dashboard/controller/DashboardController.dart';
import 'package:vlesociety/UtilsMethod/UtilsMethod.dart';

import '../../Ads/AdHelper.dart';
import '../../AppConstant/APIConstant.dart';
import '../../AppConstant/AppConstant.dart';
import '../../AppConstant/textStyle.dart';
import '../../Auth/controller/login_controller.dart';
import '../../Auth/model/StateModel.dart';
import '../../CSC/View/CscDetails.dart';
import 'Community.dart';
import 'MyAsk.dart';
import 'ServicesDescription.dart';

class ServicePage extends StatefulWidget {
  ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> with TickerProviderStateMixin
{
  LoginController loginController=Get.put(LoginController());
  DashboardController controller = Get.find();
  late TabController tabController;
  AnimationController? _controller;
  Animation<double>? _animation;
  int selectedSize1 =0;
  int ? filter=0;
  @override
  void initState()
  {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    _controller = AnimationController(duration: const Duration(seconds: 1),
        vsync: this,
        value: 0,
        lowerBound: 0,
        upperBound: 1
    );
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
    loginController.getStateNetworkApi();
    controller.getServiceNetworkApi();
    controller.getCscNetworkApi();
   return Column(
     children: [
       SizedBox(
         height: 8,
       ),
       Container
         (
         height: 40,

         child: TabBar(
             onTap: (value)
             {
               controller.selectedServicesIndex.value = value;
               if (value == 0)
               {
                 controller.getServiceNetworkApi();
                 controller.serviceModel.value.data!.clear();
                 controller.serviceModel.refresh();

               }
               if (value == 1)
               {

                 controller. getServicesGovernmentNetworkApi("");
               }
               if (value == 2)
               {
                 print("sdjkhjh");
                 controller.getServicesCSCNetworkApi();
                 controller.serviceCSCModel.value.data!.clear();
                 controller.serviceCSCModel.refresh();

               }

             },

             labelColor: Colors.orange,
             unselectedLabelColor: Colors.black.withOpacity(0.56),
             isScrollable: true,
             controller: tabController,
             labelStyle: bodyText1Style.copyWith(fontSize: 14),
             unselectedLabelStyle: bodyText2Style.copyWith(fontSize: 14),
             indicatorPadding: EdgeInsets.zero,
             indicatorColor: Colors.transparent,
             padding: EdgeInsets.zero,
             tabs: [
               const Tab(
                 child: Text("SERVICES "),
               ),
               const Tab(
                 child: Text("GOVT. SCHEMES"),
               ),
               const Tab(
                 child: Text("CSC SERVICES"),
               ),
             ]),
       ),
       Obx(
             () =>
                 Container(
           child:
           controller.selectedServicesIndex.value == 0
               ? FadeTransition(opacity: _animation!, child: Obx(
                 () => controller.serviceModel.value.data != null
                 ? GridView.count(
                 shrinkWrap: true,
                 primary: false,
                 padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
               /*  crossAxisSpacing: 2,
                 mainAxisSpacing: 1,*/
                     crossAxisSpacing: 1.5,
                     mainAxisSpacing: 18,
                 crossAxisCount: 3,
                 children: List.generate(
                   controller.serviceModel.value.data!.length,
                       (index) => GestureDetector(
                     onTap: ()
                     {
                       controller.serviceModel.value.data![index].is_gosite=='0'?
                       controller.getServicesSubCategoryNetworkApi(controller.serviceModel.value.data![index].id.toString(),controller.serviceModel.value.data![index].title.toString())
                           :Get.to(ServicesDescription( controller.serviceModel.value.data![index].description.toString(),controller.serviceModel.value.data![index].url.toString(),controller.serviceModel.value.data![index].title.toString(),controller.serviceModel.value.data![index].image.toString()));
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
                                       controller.serviceModel.value.data![index].image.toString()),fit: BoxFit.fill)),
                         ),
                         SizedBox(
                           height: 5,
                         ),
                         Text(
                           controller.serviceModel.value.data![index].title.toString()
                           ,
                           style: smallTextStyle
                               .copyWith(
                               fontSize: 13.sp),
                           maxLines: 2,
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
               : controller.selectedServicesIndex.value == 1
               ?FadeTransition(opacity: _animation!,
               child: Stack(
                 children: [

                     SingleChildScrollView
                       (
                        child:
                        Obx(
                             () => controller.governmentServiceModel.value.data != null
                             ? GridView.count(
                             shrinkWrap: true,
                             primary: false,
                             padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
                                 crossAxisSpacing: 1.5,
                                 mainAxisSpacing: 18,
                             crossAxisCount: 3,
                             children: List.generate(
                               controller.governmentServiceModel.value.data!.length,
                                   (index) => GestureDetector(
                                 onTap: ()
                                 {
                                   if(controller.settingModel.value.data!.adsStatus.toString()=="1")
                                   {
                                     InterstitialAd? interstitialAd;
                                     InterstitialAd.load(
                                         adUnitId:  AdHelper.interstitialAdUnitId,
                                         request: const AdRequest(),
                                         adLoadCallback: InterstitialAdLoadCallback(
                                           onAdLoaded: (ad)
                                           {

                                             interstitialAd = ad;
                                             interstitialAd!.show();
                                             interstitialAd!.fullScreenContentCallback =
                                                 FullScreenContentCallback(
                                                     onAdFailedToShowFullScreenContent: ((ad, error) {
                                                       ad.dispose();
                                                       interstitialAd!.dispose();
                                                       debugPrint(error.message);
                                                     }),
                                                     onAdDismissedFullScreenContent: (ad) {
                                                       ad.dispose();
                                                       interstitialAd!.dispose();
                                                          controller.governmentServiceModel.value.data![index].is_gosite=='0'?
                                                           controller.getServicesGovernmentSubCategoryNetworkApi(controller.governmentServiceModel.value.data![index].id.toString(),
                                                           controller.governmentServiceModel.value.data![index].title.toString())
                                                           :Get.to(ServicesDescription( controller.governmentServiceModel.value.data![index].description.toString(),
                                                           controller.governmentServiceModel.value.data![index].url.toString(),controller.governmentServiceModel.value.data![index].title.toString(),
                                                           controller.governmentServiceModel.value.data![index].image.toString()));
                                                       // Get.to(SubCategoryOfServices( controller.serviceModel.value.data![index].id.toString()))
                                                       //  UtilsMethod.launchUrls(controller.serviceModel.value.data![index].url.toString());
                                                     }

                                                 );
                                           },
                                           onAdFailedToLoad: (err) {
                                             debugPrint(err.message);
                                           },
                                         ));
                                   }else
                                   {
                                     controller.governmentServiceModel.value.data![index].is_gosite=='0'?
                                     controller.getServicesGovernmentSubCategoryNetworkApi(controller.governmentServiceModel.value.data![index].id.toString(),
                                         controller.governmentServiceModel.value.data![index].title.toString())
                                         :Get.to(ServicesDescription( controller.governmentServiceModel.value.data![index].description.toString(),
                                         controller.governmentServiceModel.value.data![index].url.toString(),controller.governmentServiceModel.value.data![index].title.toString(),
                                         controller.governmentServiceModel.value.data![index].image.toString()));
                                     // Get.to(SubCategoryOfServices( controller.serviceModel.value.data![index].id.toString()))
                                     //  UtilsMethod.launchUrls(controller.serviceModel.value.data![index].url.toString());
                                   }



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
                                                   controller.governmentServiceModel.value.data![index].image.toString()),fit: BoxFit.fill)),
                                     ),
                                     SizedBox(
                                       height: 5,
                                     ),
                                     Text(
                                       controller.governmentServiceModel.value.data![index].title.toString()
                                       ,
                                       style: smallTextStyle
                                           .copyWith(
                                           fontSize: 13.sp),
                                       maxLines: 2,
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
                       ),
                        ),
                   Positioned(
                       right: 10,
                       top: Get.height/11.2,
                       child: Align(alignment: Alignment.centerRight,
                           child:Column(
                             crossAxisAlignment: CrossAxisAlignment.end,
                             children: [

                               InkWell(
                                 onTap: (){
                                   _showBottomSheetFilter(context,""!);
                                 },
                                 child: Container(
                                   alignment: Alignment.center,
                                   height: 50,
                                   width: 50,
                                   decoration: BoxDecoration(
                                     shape: BoxShape.circle,
                                     color: Color(0xff1200FF).withOpacity(0.1),
                                     border:
                                     Border.all(width: 1, color: Color(0xff1200FF).withOpacity(0.1)),
                                     boxShadow: [
                                       BoxShadow(
                                         color: Color.fromRGBO(255, 255, 255, 0.7),
                                         blurRadius: 10,
                                         spreadRadius: 2,
                                       ),
                                     ],
                                   ),
                                   child: Image.asset("assets/images/filter.png",height: 30,width: 30,)
                                  /* Icon(
                                     Icons.add,
                                     size: 28,
                                     color: Color(0xff1200FF),
                                   ),*/
                                 ),
                               ),


                             /*  RawMaterialButton(
                                   constraints: BoxConstraints(maxHeight: 50, minWidth: 50),
                                   onPressed: ()
                                   {

                                      _showBottomSheetFilter(context,""!);
                                      },
                                   shape: CircleBorder(),
                                   child:CircleAvatar(
                                     backgroundColor: Colors.red.withOpacity(0.2),
                                     backgroundImage: AssetImage("assets/images/filter.png",),
                                   )),*/

                             ],
                           ) )),

                 ],
               )

           )
               : controller.selectedServicesIndex.value == 2
               ? FadeTransition(opacity: _animation!, child: Obx(
                 () => controller.serviceCSCModel.value.data != null
                 ? GridView.count(
                 shrinkWrap: true,
                 primary: false,
                 padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
               /*  crossAxisSpacing: 2,
                 mainAxisSpacing: 1,*/
                     crossAxisSpacing: 1.5,
                     mainAxisSpacing: 18,
                 crossAxisCount: 3,
                 children: List.generate(
                   controller.serviceCSCModel.value.data!.length,
                       (index) => GestureDetector(
                     onTap: ()
                     {



                           if(controller.settingModel.value.data!.adsStatus.toString()=="1")
                           {
                             InterstitialAd? interstitialAd;
                             InterstitialAd.load(
                                 adUnitId:  AdHelper.interstitialAdUnitId,
                                 request: const AdRequest(),
                                 adLoadCallback: InterstitialAdLoadCallback(
                                   onAdLoaded: (ad)
                                   {

                                     interstitialAd = ad;
                                     interstitialAd!.show();
                                     interstitialAd!.fullScreenContentCallback =
                                         FullScreenContentCallback(
                                             onAdFailedToShowFullScreenContent: ((ad, error) {
                                               ad.dispose();
                                               interstitialAd!.dispose();
                                               debugPrint(error.message);
                                             }),
                                             onAdDismissedFullScreenContent: (ad) {
                                               ad.dispose();
                                               interstitialAd!.dispose();
                                               controller.serviceCSCModel.value.data![index].is_gosite=='0'?
                                               controller.getServicesCSCSubCategoryNetworkApi(controller.serviceCSCModel.value.data![index].id.toString(),
                                                   controller.serviceCSCModel.value.data![index].title.toString())
                                                   :Get.to(ServicesDescription( controller.serviceCSCModel.value.data![index].description.toString(),
                                                   controller.serviceCSCModel.value.data![index].url.toString(),
                                                   controller.serviceCSCModel.value.data![index].title.toString(),
                                                   controller.serviceCSCModel.value.data![index].image.toString()));
                                             }

                                         );
                                   },
                                   onAdFailedToLoad: (err) {
                                     debugPrint(err.message);
                                   },
                                 ));
                           }else
                           {
                             controller.serviceCSCModel.value.data![index].is_gosite=='0'?
                             controller.getServicesCSCSubCategoryNetworkApi(controller.serviceCSCModel.value.data![index].id.toString(),
                                 controller.serviceCSCModel.value.data![index].title.toString())
                                 :Get.to(ServicesDescription( controller.serviceCSCModel.value.data![index].description.toString(),
                                 controller.serviceCSCModel.value.data![index].url.toString(),
                                 controller.serviceCSCModel.value.data![index].title.toString(),
                                 controller.serviceCSCModel.value.data![index].image.toString()));
                           }





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
                           height: 5,
                         ),
                         Text(
                           controller.serviceCSCModel.value.data![index].title.toString(),
                           style: smallTextStyle.copyWith(fontSize: 13.sp),
                           maxLines: 2,
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
               :Container()
         ),
       )
     ],
   );
  }
  void _showBottomSheetFilter(BuildContext context,String cat_Id)
  {
    showDialog(
      context: context,
      builder: (_) =>
          Dialog(
            insetPadding: EdgeInsets.only(left: 150,),
            backgroundColor: Colors.transparent,
            child:
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                  ),
              child:
              Column(
                children:
                [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: ()
                          {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.close,color: Colors.grey,)),
                    ],
                  ),
                  Text("Filter by State Name    ",style: bodyText1Style.copyWith(color: Colors.red,fontSize: 20,),),
                 SizedBox(height: 10,),
                  Obx(() => loginController.stateData.value.data!=null?
                  SingleChildScrollView(
                    child: Container(
                         padding: EdgeInsets.only(left: 10,),
                        height: Get.height/1.14,
                        child:
                        GridView.count
                          (
                          childAspectRatio:5.5,
                          crossAxisCount: 1,
                          crossAxisSpacing: 1,
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          children: List.generate(loginController.stateData.value.data!.length, (index)
                          {
                            return GestureDetector(
                              onTap: ()
                              {
                                  selectedSize1 = index;
                                  controller. getServicesGovernmentNetworkApi(loginController.stateData.value.data![index].stateId.toString());
                                setState(()
                                {
                                  filter=1;
                                  controller.governmentServiceModel.value.data!.clear();
                                  controller.governmentServiceModel.refresh();
                                  //controller.getArticleByCategoryNetworkApi( controller.communityCategoryModel.value.data![index].id.toString());
                                  //  filter=1;
                                  //isCategory=false;
                                });
                              },

                              child: Container(
                                child: Text(loginController.stateData.value.data![index].stateTitle.toString()
                                  ,  style: bodyText1Style.copyWith(
                                   color: selectedSize1 == index
                                  ? Colors.orange
                                      : Colors.black,
                                  ),


                                ),
                              ),
                            );
                          },),
                        )),
                  ):Center())

                ],
              ),
            ),
          ),
    );



  }


}
