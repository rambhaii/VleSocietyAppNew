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
import 'package:vlesociety/Dashboard/controller/DashboardController.dart';
import 'package:vlesociety/UtilsMethod/UtilsMethod.dart';

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
   // controller. getServicesGovernmentNetworkApi("");
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
               }
               if (value == 1)
               {
                 controller. getServicesGovernmentNetworkApi("");
               }
               if (value == 2)
               {
                 controller.getCscNetworkApi();
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
                 crossAxisSpacing: 10,
                 mainAxisSpacing: 1,
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
                           height: 8,
                         ),
                         Text(
                           controller.serviceModel.value.data![index].title.toString()
                           ,
                           style: smallTextStyle
                               .copyWith(
                               fontSize: 11.sp),
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
                             crossAxisSpacing: 10,
                             mainAxisSpacing: 1,
                             crossAxisCount: 3,
                             children: List.generate(
                               controller.governmentServiceModel.value.data!.length,
                                   (index) => GestureDetector(
                                 onTap: ()
                                 {
                                   controller.governmentServiceModel.value.data![index].is_gosite=='0'?
                                   controller.getServicesGovernmentSubCategoryNetworkApi(controller.governmentServiceModel.value.data![index].id.toString(),
                                       controller.governmentServiceModel.value.data![index].title.toString())
                                       :Get.to(ServicesDescription( controller.governmentServiceModel.value.data![index].description.toString(),
                                       controller.governmentServiceModel.value.data![index].url.toString(),controller.governmentServiceModel.value.data![index].title.toString(),
                                       controller.governmentServiceModel.value.data![index].image.toString()));
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
                                                   controller.governmentServiceModel.value.data![index].image.toString()),fit: BoxFit.fill)),
                                     ),
                                     SizedBox(
                                       height: 8,
                                     ),
                                     Text(
                                       controller.governmentServiceModel.value.data![index].title.toString()
                                       ,
                                       style: smallTextStyle
                                           .copyWith(
                                           fontSize: 11.sp),
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
               ?  Obx(()=> controller.cscModel.value.data != null?
           Padding(
             padding: EdgeInsets.only(
               left: 10,right: 10
             ),
             child:
             Column(

               children: [
                 GridView.count(
                   physics: NeverScrollableScrollPhysics(),
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
                                 width: 85.h,
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
             ),
           ):
           Center(
             child: CupertinoActivityIndicator(),
           ),
           ) :Container()
         ),
       )
     ],
   );
  }
  void _showBottomSheetFilter(BuildContext context,String cat_Id)
  {

   /* showModalBottomSheet(
      context: context,
      barrierColor: Colors.black.withOpacity(0.60),
      isScrollControlled: true,
      backgroundColor: Colors.white70,
      builder: (context)
      {
        return Obx(() => loginController.stateData.value.data!=null?
        Padding(
          padding: const EdgeInsets.only(left: 150),
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                color: Colors.red,
                  padding: EdgeInsets.all(10),
                  height: Get.height,
                  width: 10,
                  child:
                  GridView.count
                    (
                    childAspectRatio:2,
                    crossAxisCount: 1,
                    crossAxisSpacing: 10,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: List.generate(loginController.stateData.value.data!.length, (index)
                    {
                      return GestureDetector(
                        onTap: ()
                        {
                       //   selectedSize1 = index;
                          controller.getArticleWithFilterNetworkApi(cat_Id,loginController.stateData.value.data![index].stateId.toString());
                          setState(()
                          {
                            //controller.getArticleByCategoryNetworkApi( controller.communityCategoryModel.value.data![index].id.toString());
                          //  filter=1;
                            //isCategory=false;
                          });
                        },

                        child: Container(
                          child: Text(loginController.stateData.value.data![index].stateTitle.toString()
                            ,  style: bodyText1Style.copyWith(
                             *//* color: selectedSize1 == index
                                  ? Colors.black
                                  : Colors.grey,*//*
                            ),


                          ),
                        ),
                      );
                    },),
                  )),
            ),
          ),
        ):Center())
        ;
      },
    );*/

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