import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vlesociety/Dashboard/view/profile/tawk_widget.dart';

import '../../Ads/AdHelper.dart';
import '../../AppConstant/APIConstant.dart';
import '../../AppConstant/textStyle.dart';
import '../../UtilsMethod/BaseController.dart';
import '../../UtilsMethod/UtilsMethod.dart';
import '../controller/DashboardController.dart';
import 'SingleImageView.dart';
import 'WebViewPage.dart';

class ServicesDescription extends StatefulWidget
{  final String desc;
  final String url;
  final String title;
  final String image;
  const ServicesDescription( this.desc, this.url, this.title, this.image, {Key? key}) : super(key: key);

  @override
  State<ServicesDescription> createState() => _ServicesDescriptionState();
}

class _ServicesDescriptionState extends State<ServicesDescription> {
  DashboardController controller=Get.find();
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

    return
    Scaffold(
      bottomNavigationBar:getAd() ,
        extendBodyBehindAppBar: false,
        extendBody: false,
        backgroundColor: Colors.white,
        floatingActionButton:
        Padding(
          padding: const EdgeInsets.only(left: 10,right: 10,bottom: 0),
          child: Card(
            shadowColor: Colors.white,
            elevation: 2.0,
            surfaceTintColor: Colors.white,
            child: InkWell(
              highlightColor: Colors.yellow.withOpacity(0.3),
              splashColor: Colors.greenAccent.withOpacity(0.8),
              focusColor: Colors.green.withOpacity(0.0),
              hoverColor: Colors.blue.withOpacity(0.8),
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
                                  onAdFailedToShowFullScreenContent: ((ad, error)
                                  {
                                    ad.dispose();
                                    interstitialAd!.dispose();
                                    debugPrint(error.message);
                                  }),
                                  onAdDismissedFullScreenContent: (ad)
                                  {
                                    ad.dispose();
                                    interstitialAd!.dispose();
                                    if(widget.url.isNotEmpty)
                                    {
                                      // Get.to(WebViewPage(url,title));}
                                      Get.to(
                                          ChatAd( directChatLink: widget.url, title:widget.title,
                                            onLoad: ()
                                        {
                                          print('Hello Tawk!');
                                        },
                                        onLinkTap: (String url)
                                        {
                                          print(url);
                                        },
                                        placeholder: const Center(
                                          child: Text('Loading...'),
                                        ),))
                                      ;}
                                  }

                              );
                        },
                        onAdFailedToLoad: (err) {
                          debugPrint(err.message);
                        },
                      ));
                }else
                {
                  if(widget.url.isNotEmpty)
                  {
                    // Get.to(WebViewPage(url,title));}
                    Get.to(ChatAd( directChatLink: widget.url,
                      title:widget.title,

                      onLoad: ()
                      {
                        print('Hello Tawk!');
                      },
                      onLinkTap: (String url)
                      {
                        print(url);
                      },
                      placeholder: const Center(
                        child: Text('Loading...'),
                      ),));}
                }




              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: Center(child: Text("Go To Site",
                style: bodyText1Style.copyWith(color: Colors.grey,fontSize: 22),)),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                    elevation: 0.0,
                    leadingWidth: 60,

                    title: widget.title!=null?
                    Text(widget.title, style: subtitleStyle.copyWith(fontWeight: FontWeight.w900,fontSize: 18)
                    ):Text("", style: TextStyle(color: Colors.black, fontSize: 16)
                    ),
                  )
                ),
              ),
            ]
          ),
          preferredSize: Size(
            double.infinity,
            60.0,
          ),
        ),
        body:SingleChildScrollView(
          child:widget.desc!=null?
          Column
            (
            children: [
              Container(
                    padding: EdgeInsets.only(left: 10,right: 10),
                    width: double.infinity,
                    color: Colors.white70,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: double.infinity,
                          child:
                          Column(
                            children:
                            [
                              SizedBox(
                                height: 20,
                              ),

                              widget.image!=null ?widget.image!.isNotEmpty?
                              Card(
                                elevation: 0.5,
                                shape:RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: InkWell(
                                    onTap: (){
                                      Get.to(SingleImageView(BASE_URL +  widget.image.toString()));
                                    },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      imageUrl: BASE_URL + widget.image.toString(),

                                      height: 200,
                                      width: double.infinity,
                                      placeholder: (context, url) =>
                                          Center(child: const CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              ):Center():Center(),

                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                              //  height:Get.height/2+20,
                                width: double.infinity,
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children:
                                      [
                                        SizedBox(height: 20,),
                                        widget.title!=null?Text(
                                          widget.title.toString(),
                                          style: bodyText1Style.copyWith(fontSize: 22),
                                        ):Center(),

                                        Html(
                                            data:widget.desc.toString(),
                                            style:
                                            {
                                              "body": Style(
                                                fontSize: FontSize(19.0),
                                                //letterSpacing: 1.1,
                                                textAlign: TextAlign.justify,
                                                lineHeight: LineHeight(1.8),
                                              ),
                                            },
                                            onLinkTap: (String? url, Map<String,
                                                String> attributes,
                                                element)
                                            async{
                                              await launch(url!);
                                            }
                                        ),


                                      ],
                                    ),
                                  ),
                                ),
                              ),




                              /* Text(
                                data.title.toString(),
                                style: bodyText1Style,
                              ),*/
                             /* Html(
                                data:desc.toString(),
                                style: {
                                  "body": Style(
                                    fontSize: FontSize(12.0),

                                  ),
                                },
*/



                            ],
                          ),
                        ),
                        // ListView.separated(itemBuilder: itemBuilder, separatorBuilder: separatorBuilder, itemCount: itemCount)
                      ],
                    )),


              ],
             ):Center(

         child:  Column
           (
           children: [
             Container(
                 padding: EdgeInsets.only(left: 10,right: 10),
                 width: double.infinity,
                 color: Colors.white70,
                 child: Icon(
                     Icons.error_outline
                 )
             ),


           ],
         ),

          )

        )


    );
  }
}
