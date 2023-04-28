

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:share_plus/share_plus.dart';
import 'package:whatsapp_share/whatsapp_share.dart';

import '../AppConstant/APIConstant.dart';
import '../AppConstant/AppConstant.dart';

class FirebaseDynamicLinkService
{
  GetStorage _storage=GetStorage();
  static Future<String> buildDynamicLinks(String title,String image,String docId,bool short,int type,String userId)
  async
  {
    String url = "https://vlesocietyapp.page.link/";
    final DynamicLinkParameters dynamicLinkParams = DynamicLinkParameters(

      uriPrefix: kUriPrefix,
     //link: Uri.parse(kUriPrefix + kProductpageLink),
      link: Uri.parse("https://www.google.com/refer?referral_id=${userId}&postId=${docId}"),
      androidParameters: const AndroidParameters(
        packageName: "com.vlesociety.vlesociety",
        minimumVersion: 30,
      ),

/*      iosParameters: const IOSParameters(
        bundleId: "com.example.app.ios",
        appStoreId: "123456789",
        minimumVersion: "1.0.1",
      ),
      googleAnalyticsParameters: const GoogleAnalyticsParameters(
        source: "twitter",
        medium: "social",
        campaign: "example-promo",
      ),*/
      socialMetaTagParameters: SocialMetaTagParameters(
          description: '',
          imageUrl:
          Uri.parse("$image"),
          title: title),

    );


    Uri url1;
    if(short)
      {
        final ShortDynamicLink shortDynamicLink=    await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
        url1=shortDynamicLink.shortUrl ;

      }
    else
      {url1 =await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);
      }


    final dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
    String? desc = '${dynamicLink.shortUrl.toString()}';
     if(type==1)
       {
       await Share.share(desc, subject: title,);}
     else if(type==2)
       {
         await WhatsappShare.share
           (
           text:desc,
           //linkUrl: 'https://www.animationmedia.org/',
           phone: '911234567890',

         );
       }

    return url1.toString();


  }

 static Future<void> initDynamicLinks() async
  {


    final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
    if (initialLink != null)
    {
      final Uri deepLink = initialLink.link;
      print("dfjk${deepLink.path.toString()}");


      var isRefer = deepLink.pathSegments.contains('refer');
      if (isRefer)
      {
        var referral_id = deepLink.queryParameters['referral_id'];
        var postId = deepLink.queryParameters['postId'];
        print(referral_id.toString());
        print("djkfhjg"+postId.toString());
        if (referral_id != null)
        { /* GetStorage _storage=GetStorage();
        _storage.write(AppConstant.referId,referral_id);
         */

          /* GeneratedRoute.navigateTo(
          SignUpView.routeName,
          args: code,
        );*/
        }
      }






    }

   //handleMyLink(deeplink);

  }
  static Future<void> handleMyLink(Uri url)async
  {
    List<String> sepeatedLink = [];
    /// osama.link.page/Hellow --> osama.link.page and Hellow
    sepeatedLink.addAll(url.path.split('/'));

    print("The Token that i'm interesed in is ${sepeatedLink[1]}");
    //  Get.to(()=>ProductDetailScreen(sepeatedLink[1]));

  }



}