
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:vlesociety/Dashboard/view/CommunityDetails.dart';
import 'package:vlesociety/Dashboard/view/profile/tawk_widget.dart';

import '../Ads/AdHelper.dart';

class InterstitialExampleState
{

   static void loadInterstitialAd(BuildContext context,String id,String data)
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
                     onAdDismissedFullScreenContent: (ad)
                     {
                       ad.dispose();
                       interstitialAd!.dispose();
                       data.toString().contains("Https")?
                       Get.to(
                           ChatAd( directChatLink:data.toString(), title:"",
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
                             ),)):
                       Get.to(() => CommunityDetails(cid:id.toString()));
                     }

                 );
           },
           onAdFailedToLoad: (err) {
             debugPrint(err.message);
           },
         ));
   }



}