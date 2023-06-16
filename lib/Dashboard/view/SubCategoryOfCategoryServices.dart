import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../Ads/AdHelper.dart';
import '../../AppConstant/textStyle.dart';
import '../controller/DashboardController.dart';
import 'ServicesDescription.dart';

class SubCategoryOfCategoryServices extends StatelessWidget
{
 final String title;
 final String type;
  SubCategoryOfCategoryServices(this.title, this.type, {Key? key}) : super(key: key);
  DashboardController controller = Get.find();
 Widget getAd()
 {
   BannerAdListener bannerAdListener=BannerAdListener(onAdWillDismissScreen: (ad)
   {
     ad.dispose();
   },onAdClicked: (ad){
     print("Ad got closed");
   });
   BannerAd bannerAd=BannerAd(
       size:  AdSize.banner,
       adUnitId: AdHelper.bannerAdUnitId,
       request:  const AdRequest(),

       listener: BannerAdListener(
         // Called when an ad is successfully received.
         onAdLoaded: (ad)
         {
           debugPrint('$ad loaded.');

         },
         // Called when an ad request failed.
         onAdFailedToLoad: (ad, err)
         {
           debugPrint('BannerAd failed to load: $err');
           // Dispose the ad here to free resources.
           ad.dispose();
         },

         onAdOpened: (Ad ad) {},
         // Called when an ad removes an overlay that covers the screen.
         onAdClosed: (Ad ad) {

         },
         // Called when an impression occurs on the ad.
         onAdImpression: (Ad ad) {},

       )
   );

   bannerAd.load();
   return SizedBox(
     height: 100,

     child: AdWidget(ad: bannerAd),

   );
 }
  @override
  Widget build(BuildContext context)
  {
  //  controller.getServicesSubCategoryNetworkApi(id);
    return
      Scaffold(
          bottomNavigationBar:getAd() ,
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
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: AppBar(
                    backgroundColor: Colors.white.withOpacity(0.5),
                    leading: Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(

                      ),
                      child: IconButton(
                        onPressed:()=> Navigator.of(context).pop(),
                        icon: Icon(Icons.arrow_back_ios_new,color: Colors.black,),),
                    ),
                    leadingWidth: 60,
                    elevation: 0.0,
                    title: title!=null?
                    Text(title, style: subtitleStyle.copyWith(fontWeight: FontWeight.w900,fontSize: 16)
                    ):Text("", style: TextStyle(color: Colors.black, fontSize: 16)
                    ),
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

        body:
        Obx(() =>controller.serviceCategoryModel1.value.data!= null?ListView.builder(
            itemCount: controller.serviceCategoryModel1.value.data!.length,
            itemBuilder: (context,index){
              return
                Padding(
                  padding: const EdgeInsets.only(left: 12.0,right: 12,top: 10),
                  child: Card(
                    shadowColor: Colors.white,
                    elevation: 1.0,
                    surfaceTintColor: Colors.white,
                    child: InkWell(
                      highlightColor: Colors.yellow.withOpacity(0.3),
                      splashColor: Colors.greenAccent.withOpacity(0.8),
                      focusColor: Colors.green.withOpacity(0.0),
                      hoverColor: Colors.blue.withOpacity(0.8),
                      onTap: ()
                      {
                        print(  "xvbjchv"+controller.serviceCategoryModel1.value.data![index].isGosite.toString());

                        if(type=="0")
                          {
                            controller.serviceCategoryModel1.value.data![index].isGosite=='0'?
                            controller.getServicesSubCategoryOfCategoryThirdLevelNetworkApi(controller.serviceCategoryModel1.value.data![index].id.toString(),controller.serviceCategoryModel1.value.data![index].title.toString())
                                :Get.to(ServicesDescription( controller.serviceCategoryModel1.value.data![index].description.toString(),controller.serviceCategoryModel1.value.data![index].url.toString(),controller.serviceCategoryModel1.value.data![index].title.toString(),controller.serviceCategoryModel1.value.data![index].image.toString()));

                          }else if(type=="1")
                            {
                              controller.serviceCategoryModel1.value.data![index].isGosite=='0'?
                              controller.getServicesGovernmentSubCategoryOfCategoryThirdLevelNetworkApi(controller.serviceCategoryModel1.value.data![index].id.toString(),controller.serviceCategoryModel1.value.data![index].title.toString())
                                  :Get.to(ServicesDescription( controller.serviceCategoryModel1.value.data![index].description.toString(),controller.serviceCategoryModel1.value.data![index].url.toString(),controller.serviceCategoryModel1.value.data![index].title.toString(),controller.serviceCategoryModel1.value.data![index].image.toString()));

                            }
                        else if(type=="2")
                          {
                            print("dgdgdggdh"+controller.serviceCategoryModel1.value.data![index].isGosite.toString()+"    "+controller.serviceCategoryModel1.value.data![index].id.toString());
                            controller.serviceCategoryModel1.value.data![index].isGosite=='0'?
                            controller.getServicesCSCSSubCategoryOfCategoryThirdLevelNetworkApi(controller.serviceCategoryModel1.value.data![index].id.toString(),controller.serviceCategoryModel1.value.data![index].title.toString())
                                :Get.to(ServicesDescription( controller.serviceCategoryModel1.value.data![index].description.toString(),controller.serviceCategoryModel1.value.data![index].url.toString(),controller.serviceCategoryModel1.value.data![index].title.toString(),controller.serviceCategoryModel1.value.data![index].image.toString()));

                          }


                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        child: Center(child: Text(controller.serviceCategoryModel1.value.data![index].title.toString(),
                          style: bodyText1Style.copyWith(color: Colors.grey,fontSize: 16),)),
                      ),
                    ),
                  ),
                );
            }):
        Center(
          child: CupertinoActivityIndicator(),
        ),
        )

    );
  }
}