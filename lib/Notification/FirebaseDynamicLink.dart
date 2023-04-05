

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:share_plus/share_plus.dart';

import '../AppConstant/APIConstant.dart';

class FirebaseDynamicLinkService
{

  static Future<String> buildDynamicLinks(String title,String image,String docId,bool short)
  async
  {
    String url = "https://vlesocietyapp.page.link/";
    final DynamicLinkParameters dynamicLinkParams = DynamicLinkParameters(
    /*  link: Uri.parse("https://vlesocietyapp.page.link"),
      uriPrefix: "https://example.page.link",*/
     /* uriPrefix: url,
      link: Uri.parse('$url/$docId'),
    */
      uriPrefix: kUriPrefix,
      link: Uri.parse(kUriPrefix + kProductpageLink),
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
      {

        url1 =await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);
      }
    final dynamicLink =
    await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
    String? desc = '${dynamicLink.shortUrl.toString()}';
    await Share.share(desc, subject: title,);

    return url1.toString();


  }

 static Future<void> initDynamicLinks(BuildContext context) async
  {
    FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
    dynamicLinks.onLink.listen((dynamicLinkData)
    {
      final Uri? deeplink = dynamicLinkData!.link;
      if(deeplink != null)
      {
        handleMyLink(deeplink);
      }
      // Navigator.pushNamed(context, dynamicLinkData.link.path);
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
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