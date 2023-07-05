import 'dart:io';
import 'dart:ui';

import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:html/parser.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import 'package:readmore/readmore.dart';
import 'package:simple_url_preview/simple_url_preview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vlesociety/AppConstant/textStyle.dart';
import 'package:vlesociety/Dashboard/controller/DashboardController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:vlesociety/Dashboard/view/profile/tawk_widget.dart';
import 'package:vlesociety/Dashboard/view/profile/youtube.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:whatsapp_share/whatsapp_share.dart';
import '../../Ads/AdHelper.dart';
import '../../AppConstant/APIConstant.dart';
import 'package:share_plus/share_plus.dart';
import '../../AppConstant/AppConstant.dart';
import '../../Notification/FirebaseDynamicLink.dart';
import '../../UtilsMethod/UtilsMethod.dart';
import '../../Widget/loading_widget.dart';
import '../AddMobAds.dart';
import '../model/CommunityModel.dart';
import 'CommunityDetails.dart';
import 'GallaryCommunity.dart';
import 'SingleImageView.dart';


class CommunityPage extends StatefulWidget {
  CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage>
{

  DashboardController controller = Get.find();
  final followContrller modelfollow = Get.put(followContrller());
  int show3 = 0;
  late bool dd;
  late String va;
  int count = 0;
  int cuntnumber = 0;
  CommunityDatum communityModel2 = Get.put(CommunityDatum());

  late WebViewController _con;



  @override
  void initState()
  {
    // TODO: implement initState
    super.initState();

  //  loadAd();
  }

  @override
  void dispose() {
    //_bannerAd?.dispose();
    super.dispose();
  }



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
  _launchURL(String urlvalue) async
  {

    final uri = Uri.parse(urlvalue);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $urlvalue';
    }
  }


  @override
  Widget build(BuildContext context)
  {
    controller.getCommunityNetworkApi();

    return
      Obx(
      () => Column(
        children:
        [ Column(
            children: controller.communityModel.value.data != null
                ? List.generate(
                    controller.communityModel.value.data!.length,
                    (index)
                    {
                      final data = controller.communityModel.value.data![index];
                      print("jdksfhjg"+data.ttlLike.toString());
                      count = int.parse(data.ttlLike.toString());
                        String desc=data.description.toString();
                        String dataUrlValue=desc;

                       dataUrlValue = dataUrlValue.replaceFirst(RegExp('H'), 'h');





                      return
                        GestureDetector(
                        onTap: ()
                        {
                          print("fhghjjh"+data.description.toString());
                         if(controller.settingModel.value.data!.adsStatus.toString()=="1")
                           {
                             InterstitialExampleState.loadInterstitialAd(context, data.id.toString(),data.description.toString());
                           }
                         else
                           {
                             data.description.toString().contains("Https")?

                             Get.to(
                                 ChatAd( directChatLink:data.description.toString(), title:"",
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
                             :
                             Get.to(() => CommunityDetails(cid: data.id.toString(),));

                           }



                          //
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading:
                              InkWell(
                                onTap: (){
                                  showDialog(
                                    context: context,
                                    builder: (_) =>
                                        Dialog(
                                          alignment: Alignment.center,
                                          insetPadding:EdgeInsets.all(20) ,
                                          backgroundColor: Colors.transparent,
                                          child:
                                          Container(
                                            height: 300,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child:
                                            Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Column(
                                                children:
                                                   [

                                                     CachedNetworkImage(
                                                       fit: BoxFit.cover,
                                                       imageUrl: BASE_URL + data.addByPic.toString(),
                                                       height: 280,
                                                       width: double.infinity,
                                                       placeholder: (context, url) => Center(
                                                           child: const CupertinoActivityIndicator()),
                                                       errorWidget: (context, url, error) =>
                                                           CircleAvatar(
                                                               backgroundColor:
                                                               Colors.amber.withOpacity(0.1),
                                                               child: const Icon(
                                                                 Icons.image_not_supported_outlined,
                                                                 color: Colors.black26,
                                                               )),
                                                     )

                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                  );
                                },
                                child: ClipOval(
                                  child:
                                  CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: BASE_URL + data.addByPic.toString(),
                                    height: 50,
                                    width: 50,
                                    placeholder: (context, url) => Center(
                                        child: const CupertinoActivityIndicator()),
                                    errorWidget: (context, url, error) =>
                                        CircleAvatar(
                                            backgroundColor:
                                                Colors.amber.withOpacity(0.1),
                                            child: const Icon(
                                              Icons.image_not_supported_outlined,
                                              color: Colors.black26,
                                            )),
                                  ),
                                ),
                              ),

                              title: Row(children:
                              [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(data.addBy ?? '', style: bodyText1Style.copyWith(fontSize: 12),),
                                    Text(
                                      timeago.format(
                                          DateTime.parse(data.addDate.toString())
                                      ),
                                      style: smallTextStyle.copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10,
                                          color: Colors.black.withOpacity(0.5)),
                                    )
                                  ],
                                ),
                                      SizedBox(width: 10,),
                                         Container(
                                           child:  data.is_verify=="1"?
                                           Image(image: AssetImage("assets/images/verified.png",),width: 15,height: 15,
                                           ):Container()
                                         )],),

                              trailing: Container(
                                width: 90,
                                child: Row(
                                  children: [
                                    GetBuilder<followContrller>(
                                      builder: (modelfollow) => IconButton(
                                          onPressed: () {
                                            if (controller.userType == "Guest") {
                                              UtilsMethod.PopupBox(context, "follow the user");
                                            } else {
                                              data.followStatus != "Following"
                                                  ? controller.getfollowNetworkApi(
                                                      data.addById.toString(), '1')
                                                  : controller.getfollowNetworkApi(
                                                      data.addById.toString(), '2');
                                              data.isSlected =
                                                  data.isSlected == true
                                                      ? false
                                                      : true;
                                              controller.communityModel.value =
                                                  controller.communityModel.value;
                                              controller.communityModel.refresh();
                                            }
                                          },
                                          icon: data.isSlected!
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Container(
                                                    padding: EdgeInsets.all(5),
                                                    height: 40,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            width: .5,
                                                            color: Colors.black)),
                                                    child: Image.asset(
                                                      "assets/images/addf.png",
                                                      color: Colors.black,
                                                      width: 10,
                                                      filterQuality:
                                                          FilterQuality.high,
                                                    ),
                                                  ),
                                                )
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Container(
                                                    padding: EdgeInsets.all(5),
                                                    height: 40,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            width: .5,
                                                            color: Colors.blue)),
                                                    child: Image.asset(
                                                      "assets/images/removef.png",
                                                      color: Colors.blue,
                                                      width: 10,
                                                      filterQuality:
                                                          FilterQuality.high,
                                                    ),
                                                  ),
                                                )),
                                    ),
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
                                          border: Border.all(
                                              width: 0.7, color: Colors.grey)),
                                      child:PopupMenuButton<int>(
                                        padding: EdgeInsets.zero,
                                        icon: Icon(
                                          Icons.adaptive.more,
                                          color: Colors.grey,
                                        ),

                                        itemBuilder: (context) => List.generate(
                                          controller
                                              .reportPostApi.value.data!.length,
                                          (index) => PopupMenuItem(
                                            height: 30,
                                            child: Text(
                                              controller.reportPostApi.value
                                                  .data![index].title
                                                  .toString(),
                                              style: smallTextStyle,
                                            ),
                                            onTap: ()
                                            {

                                            if (controller.userType == "Guest")
                                            {
                                            UtilsMethod.PopupBox(context, controller.reportPostApi.value
                                                .data![index].title
                                                .toString());
                                            } else {

                                              controller.postReportNetworkApi(
                                                  controller.reportPostApi.value
                                                      .data![index].id
                                                      .toString(),
                                                  data.id.toString());
                                            }
                                            },
                                          ),
                                        ),
                                        offset: Offset(0, 30),
                                        color: Colors.white,
                                        elevation: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 5, right: 0),
                              child: Column(
                                children:
                                [
                                /*  ReadMoreText(
                                  parse(data!.description.toString()).body!.text,
                                    style:
                                        TextStyle(fontSize: 12, letterSpacing: 1),
                                    textAlign: TextAlign.justify,
                                    trimLines: 2,
                                    colorClickableText: Colors.pink,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: 'Show more',
                                    trimExpandedText: '  Show less',
                                    moreStyle: smallTextStyle,
                                    lessStyle: smallTextStyle,
                                  ),
                                  */
                                 data.description.toString().contains("Https")?
                               Container(
                                 child: Row(
                                     crossAxisAlignment: CrossAxisAlignment.end,
                                     mainAxisAlignment: MainAxisAlignment.end,
                                     children: [
                                       Text("View more...",style: bodyText1Style.copyWith(
                                     color: Colors.blue.shade400,
                                     fontWeight: FontWeight.w400,
                                     fontSize: 14)
                                       ),
                                       Icon(
                                         Icons.arrow_forward_ios_rounded,
                                         color: Colors.blue,
                                         size: 14,
                                       )

                                     ],
                                 )


                                /* height: 200,
                                 child:  WebView(
                                   initialUrl:  data.description,
                                   javascriptMode: JavascriptMode.unrestricted,
                                   onWebViewCreated: (WebViewController webViewController) {
                                     // _controller.complete(webViewController);
                                     _con = webViewController;
                                     //_loadHTML();
                                   },
                                   onProgress: (int progress) {
                                     print("WebView is loading (progress : $progress%)");
                                   },
                                   navigationDelegate: (NavigationRequest request) {
                                     if (request.url.startsWith(data.description.toString()))
                                     {
                                       print('blocking navigation to $request}');
                                       return NavigationDecision.prevent;
                                     }
                                     print('allowing navigation to $request');
                                     return NavigationDecision.navigate;
                                   },
                                   onPageStarted: (String url) {
                                     print('Page started loading: $url');
                                   },
                                   onPageFinished: (String url) {
                                     print('Page finished loading: $url');
                                   },
                                   gestureNavigationEnabled: true,
                                 )*/
                               ):

                                  Html(
                                      data:data.description.toString(),
                                      style:
                                      {
                                        "body": Style(
                                          fontSize: FontSize(12.0),
                                          letterSpacing: 1,
                                          textAlign: TextAlign.justify,
                                          lineHeight: LineHeight(1),
                                          maxLines: 5
                                        ),
                                      },
                                      onLinkTap: (String? url, Map<String,
                                          String> attributes,
                                          element)
                                      async{
                                        await launch(url!);
                                      }
                                  )

                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            data.image.toString().isNotEmpty?
                                InkWell(
                                  onTap: ()
                                  {
                                    print("dkfjghj");
                                    Get.to(SingleImageView(BASE_URL + data.image.toString()));
                                  },
                                  child: Container(
                                  height: 250,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              BASE_URL + data.image.toString()
                                          ),
                                              fit: BoxFit.fill
                                      )
                                  ),
                              ),
                                ):
                            data.description.toString().contains("Https")||data.description.toString().contains("https")?
                            Container
                              (
                                    height: 320,
                                    width: Get.width.w,
                                    child:
                                    AnyLinkPreview(
                                      link:dataUrlValue,


                                        bodyMaxLines: 3,
                                        bodyTextOverflow: TextOverflow.ellipsis,
                                        titleStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                        errorWidget: Container(
                                          height: 150,
                                          width: Get.width.w,
                                          child: Image.asset("assets/images/errorimage.jpg",
                                              width: Get.width.w,
                                              height: 150,
                                              fit:BoxFit.fill ),
                                        ),

                                        onTap: ()
                                        {
                                          Get.to(
                                              ChatAd( directChatLink:data.description.toString(), title:"",
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
                                                ),)
                                          );
                                        }
                                    ),
                               /* SimpleUrlPreview(
                              url:  dataUrlValue,
                             bgColor: Colors.white38,


                              previewHeight: 200,
                             previewContainerPadding: EdgeInsets.all(2),
                              titleLines: 2,
                              descriptionLines: 2,
                              titleStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                //color: Colors.blue,
                              ),
                              descriptionStyle: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).primaryColor,
                              ),
                              siteNameStyle: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).primaryColor,
                              ),

                              onTap: () => print('Hello Flutter URL Preview'),
                            ),*/
                              /*AnyLinkPreview(
                                    link:  dataUrlValue,
                                    displayDirection: UIDirection.uiDirectionHorizontal,
                                    showMultimedia: false,
                                    bodyMaxLines: 5,
                                    bodyTextOverflow: TextOverflow.ellipsis,
                                    titleStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                    bodyStyle: TextStyle(color: Colors.grey, fontSize: 12),
                                    errorBody: 'Show my custom error body',
                                    errorTitle: 'Show my custom error title',
                                    errorWidget: Container(
                                      color: Colors.grey[300],
                                      child: Text('Oops!'),
                                    ),
                                    errorImage: "https://google.com/",
                                    cache: Duration(days: 7),
                                    backgroundColor: Colors.grey[300],
                                    borderRadius: 12,
                                    removeElevation: false,
                                    boxShadow: [BoxShadow(blurRadius: 3, color: Colors.grey)],
                                    onTap: ()
                                    {
                                      Get.to(
                                          ChatAd( directChatLink:data.description.toString(), title:"",
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
                                            ),));
                                    }, // This disables tap event

                                )*/

                               ):Container(

                            ),

                            Row(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    RawMaterialButton(
                                      onPressed: ()
                                      {
                                        if (controller.userType == "Guest") {
                                          UtilsMethod.PopupBox(context, "like");
                                        } else {
                                          // controller.getCommunityNetworkApi();
                                          data.aslike == "1"
                                              ? controller
                                                  .getComunitylikeDislikeNetworkApi(
                                                      data.id.toString(), '2')
                                              : controller
                                                  .getComunitylikeDislikeNetworkApi(
                                                      data.id.toString(), '1');
                                          data.likeslected =
                                              data.likeslected == true
                                                  ? false
                                                  : true;
                                          controller.communityModel.value =
                                              controller.communityModel.value;
                                          controller.communityModel.refresh();
                                        }
                                      },
                                      child: data.likeslected!
                                          ? Image.asset(
                                              "assets/images/likecom.png",
                                              height: 25,
                                              width: 25,
                                            )
                                          : Image.asset(
                                              "assets/images/likecommunity.png",
                                              height: 25,
                                              width: 25,
                                            ),
                                      constraints: BoxConstraints(
                                          maxHeight: 30, maxWidth: 30),
                                      shape: CircleBorder(),
                                    ),
                                    data.likeslected!
                                        ? Text(
                                            "${count + 1} like",
                                      style: bodyText1Style.copyWith(
                                          color: Colors.blue.shade400,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12),
                                          )
                                        : Text(
                                            "${count} like",
                                      style: bodyText1Style.copyWith(
                                          color: Colors.blue.shade400,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12),
                                          ),
                                  ],
                                ),
                                SizedBox(width: 20.w,),

                                Column(
                                  children:
                                  [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    RawMaterialButton(
                                      onPressed: ()
                                      {
                                        if (controller.userType == "Guest")
                                        {
                                          UtilsMethod.PopupBox(context, "comment");
                                        }
                                        else
                                        {
                                          controller.getAnswerNetworkApi(data.id.toString());
                                          _showBottomSheet(context, data.id.toString());
                                        }
                                      },
                                      child: Image.asset(
                                        "assets/images/edit.png",
                                        height: 23,
                                        width: 23,
                                        color: Colors.black,
                                      ),
                                      constraints:
                                          BoxConstraints(maxHeight: 30, maxWidth: 40),
                                      shape: CircleBorder(),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          controller.getAnswerNetworkApi(data.id.toString());
                                          _showCommentSheet(context, data.id.toString());
                                        },
                                        child: Text("${data.ttlAnswer} Comment",
                                            style: bodyText1Style.copyWith(
                                                color: Colors.blue.shade400,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 12))),
                                  ],
                                ),
                                SizedBox(width: 20.w,),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    RawMaterialButton(
                                      onPressed: () async {
                                        if (controller.userType == "Guest") {
                                          UtilsMethod.PopupBox(context, "share");
                                        } else
                                        {
                                          //buildDynamicLinks(data.description.toString(),BASE_URL+data.image.toString(),data.id.toString());
                                          String generateDeeplink = await FirebaseDynamicLinkService.buildDynamicLinks(
                                                      data.description.toString(),
                                                      BASE_URL +
                                                          data.image.toString(),
                                                      data.id.toString(),
                                                      false,1,"");

                                          if (generateDeeplink.isNotEmpty)
                                          {
                                            controller.getcommunityShareNetworkApi(
                                                data.id.toString());
                                            controller.getCommunityNetworkApi();
                                          }
                                        }
                                      },
                                      /*
                                 {
                                    Share.share(subject: BASE_URL + data.image.toString(), data.description.toString());
                                  }*/
                                      /*
                                 async
                                 {
                                final urlPreview =BASE_URL+data.image.toString();
                                final url = Uri.parse(urlPreview);
                                final response = await http.get(url);
                                final bytes = response.bodyBytes;
                                final temp = await getTemporaryDirectory();
                                final path = '${temp.path}/image.jpg';
                                File(path).writeAsBytesSync(bytes);
                                await Share.shareFiles([path], text: data.description.toString()+"\n"+'https://www.animationmedia.org/');
                                },*/
                                      child: Image.asset(
                                        "assets/images/share.png",
                                        height: 25,
                                        width: 25,
                                      ),
                                      constraints: BoxConstraints(
                                          maxHeight: 30, maxWidth: 40),
                                      shape: CircleBorder(),
                                    ),
                                    Text("${data.ttlShare.toString()
                                      } share",
                                        style: bodyText1Style.copyWith(
                                            color: Colors.blue.shade400,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 12))
                                  ],
                                ),
                                SizedBox(width: 20.w,),
                                RawMaterialButton
                                  (
                                  onPressed: () async
                                  {
                                    /* final urlPreview =BASE_URL+data.image.toString();
                   final url = Uri.parse(urlPreview);
                   final response = await http.get(url);
                   final bytes = response.bodyBytes;
                   final temp = await getTemporaryDirectory();
                   final path = '${temp.path}/image.jpg';
                   File(path).writeAsBytesSync(bytes);
                   await Share.shareFiles([path], text: data.description.toString()+"\n"+'https://www.animationmedia.org/');
               */
                                    if (controller.userType == "Guest")
                                    {
                                      UtilsMethod.PopupBox(context, "share");
                                    }
                                    else
                                    {

                                      String generateDeeplink =
                                      await FirebaseDynamicLinkService.buildDynamicLinks(data.description.toString(),
                                          BASE_URL +
                                              data.image.toString(),
                                          data.id.toString(),
                                          false,2,"");
                                      if (generateDeeplink.isNotEmpty)
                                      {
                                        controller.getcommunityShareNetworkApi(
                                            data.id.toString());
                                        controller.getCommunityNetworkApi();
                                      }

                                    }
                                  },
                                  child: Image.asset(
                                    "assets/images/whatsapp.png",
                                    height: 27,
                                    width: 27,
                                  ),
                                  constraints:
                                      BoxConstraints(maxHeight: 30, maxWidth: 40),
                                  shape: CircleBorder(),
                                ),
                                Expanded(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                   /* TextButton(
                                        onPressed: () {
                                          controller.getAnswerNetworkApi(data.id.toString());
                                          _showCommentSheet(context, data.id.toString());
                                        },
                                        child: Text("${data.ttlAnswer} Comment",
                                            style: bodyText1Style.copyWith(
                                                color: Colors.blue.shade400,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 12))),
                                    Container(
                                      height: 3,
                                      width: 3,
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          shape: BoxShape.circle),
                                    ),*/
                                    TextButton(
                                        onPressed: () {},
                                        child: Text("${data.ttlView} Views",
                                            style: bodyText1Style.copyWith(
                                                color: Colors.blue.shade400,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12))),
                                  ],
                                )),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0, right: 4.0,bottom: 5),
                              child: Divider(
                                thickness: 1.8,
                                height: 5,
                                color: Colors.grey.withOpacity(0.2),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  )
                : [
                    Center(
                      child: CupertinoActivityIndicator(),
                    )
                  ],
          ),
          controller.isLoadingPage.value?const LoadingWidget():Container(),
        ],
      ),
    );
  }






  void _showBottomSheet(BuildContext context, String id) {
    TextEditingController etmessage = TextEditingController();
    controller.rxMessaage.value = "";
    controller.rxMessaage.value = "";
    showModalBottomSheet(
      context: context,
      barrierColor: Colors.black.withOpacity(0.1),
      isScrollControlled: true,
      backgroundColor: Colors.white70,
      builder: (context) {
        return ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              width: double.infinity,
              height: Get.height - 150,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Container(
                    padding: EdgeInsets.all(10),
                    // height: h * 0.45,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: 40,
                          height: 7,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 0.5, color: Colors.black38),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Obx(
                          () => controller.answerModel.value.data != null
                              ? Expanded(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemBuilder: (context, index)
                                    {
                                      String commmentReply=   controller.answerModel.value.data![index].addById.toString()    ;
                                      if(
                                      GetStorage().read(AppConstant.id).toString()==commmentReply)
                                      {
                                        return ListTile(
                                            contentPadding: EdgeInsets.zero,

                                            trailing:ClipOval(
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl: BASE_URL +
                                                    controller.answerModel.value
                                                        .data![index].addByPic
                                                        .toString(),
                                                height: 50,
                                                width: 50,
                                                placeholder: (context, url) =>
                                                    Center(
                                                        child:
                                                        const CircularProgressIndicator()),
                                                errorWidget:
                                                    (context, url, error) =>
                                                const Icon(Icons.error),
                                              ),
                                            ), 

                                            title: Container(
                                                padding: EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 8,
                                                    bottom: 8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey
                                                            .withOpacity(0.7),
                                                        width: 0.5),
                                                    borderRadius:
                                                    BorderRadius.circular(8),
                                                    color: Colors.black
                                                        .withOpacity(0.1)),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      controller.answerModel
                                                          .value.data![index]
                                                          .addBy ??
                                                          '',
                                                      style: bodyText1Style
                                                          .copyWith(
                                                          fontSize: 16),
                                                    ),
                                                    SizedBox(
                                                      height: 4,
                                                    ),
                                                    Text(
                                                      controller.answerModel
                                                          .value
                                                          .data![index].answer
                                                          .toString(),
                                                      style: smallTextStyle,
                                                    ),
                                                    controller.answerModel.value
                                                        .data![index].answer
                                                        .toString().contains(
                                                        "Https") ?
                                                    InkWell(
                                                      onTap: () {
                                                        _launchURL(controller
                                                            .answerModel.value
                                                            .data![index].answer
                                                            .toString());
                                                      },
                                                      child:
                                                      Row(
                                                        crossAxisAlignment: CrossAxisAlignment
                                                            .end,
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .end,
                                                        children: [
                                                          Text("Open",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .blue,

                                                              )
                                                          ),
                                                          Icon(
                                                            Icons
                                                                .arrow_forward_ios_rounded,
                                                            color: Colors.blue,
                                                            size: 18,
                                                          )

                                                        ],

                                                      ),
                                                    )
                                                        :
                                                    Container()
                                                  ],
                                                )),
                                            subtitle: Row(
                                              children:
                                              [
                                                Text(
                                                  controller.answerModel.value
                                                      .data![index].addDate
                                                      .toString(),
                                                  style: smallTextStyle,
                                                ),
                                                Expanded(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                      children: [
                                                        RawMaterialButton(
                                                          onPressed: () {
                                                            controller
                                                                .communityAnswerLikeDislikeNetworkApi(
                                                                controller
                                                                    .answerModel
                                                                    .value
                                                                    .data![index]
                                                                    .id!,
                                                                controller
                                                                    .answerModel
                                                                    .value
                                                                    .data![index]
                                                                    .aslike!,
                                                                id);
                                                          },
                                                          child: Image.asset(
                                                            "assets/images/like.png",
                                                            height: 20,
                                                            width: 20,
                                                            color: controller
                                                                .answerModel
                                                                .value
                                                                .data![index]
                                                                .aslike
                                                                .toString() ==
                                                                "1"
                                                                ? Colors.blue
                                                                : Colors.grey,
                                                          ),
                                                          constraints:
                                                          const BoxConstraints(
                                                              maxHeight: 20,
                                                              maxWidth: 20),
                                                          shape: const CircleBorder(),
                                                        ),
                                                        RawMaterialButton(
                                                          onPressed: () {
                                                            Share.share(
                                                                controller
                                                                    .answerModel
                                                                    .value
                                                                    .data![index]
                                                                    .answer
                                                                    .toString());
                                                          },
                                                          child: Image.asset(
                                                            "assets/images/share.png",
                                                            height: 20,
                                                            width: 20,
                                                          ),
                                                          constraints: BoxConstraints(
                                                              maxHeight: 20,
                                                              maxWidth: 20),
                                                          shape: CircleBorder(),
                                                        ),
                                                      ],
                                                    ))
                                              ],
                                            ));
                                      }
                                      {
                                        return ListTile(
                                            contentPadding: EdgeInsets.zero,
                                            leading: ClipOval(
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl: BASE_URL +
                                                    controller.answerModel.value
                                                        .data![index].addByPic
                                                        .toString(),
                                                height: 50,
                                                width: 50,
                                                placeholder: (context, url) =>
                                                    Center(
                                                        child:
                                                        const CircularProgressIndicator()),
                                                errorWidget:
                                                    (context, url, error) =>
                                                const Icon(Icons.error),
                                              ),
                                            ),

                                            title: Container(
                                                padding: EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 8,
                                                    bottom: 8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey
                                                            .withOpacity(0.7),
                                                        width: 0.5),
                                                    borderRadius:
                                                    BorderRadius.circular(8),
                                                    color: Colors.black
                                                        .withOpacity(0.1)),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      controller.answerModel
                                                          .value.data![index]
                                                          .addBy ??
                                                          '',
                                                      style: bodyText1Style
                                                          .copyWith(
                                                          fontSize: 16),
                                                    ),
                                                    SizedBox(
                                                      height: 4,
                                                    ),
                                                    Text(
                                                      controller.answerModel
                                                          .value
                                                          .data![index].answer
                                                          .toString(),
                                                      style: smallTextStyle,
                                                    ),
                                                    controller.answerModel.value
                                                        .data![index].answer
                                                        .toString().contains(
                                                        "Https") ?
                                                    InkWell(
                                                      onTap: () {
                                                        _launchURL(controller
                                                            .answerModel.value
                                                            .data![index].answer
                                                            .toString());
                                                      },
                                                      child:
                                                      Row(
                                                        crossAxisAlignment: CrossAxisAlignment
                                                            .end,
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .end,
                                                        children: [
                                                          Text("Open",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .blue,

                                                              )
                                                          ),
                                                          Icon(
                                                            Icons
                                                                .arrow_forward_ios_rounded,
                                                            color: Colors.blue,
                                                            size: 18,
                                                          )

                                                        ],

                                                      ),
                                                    )
                                                        :
                                                    Container()
                                                  ],
                                                )),
                                            subtitle: Row(
                                              children:
                                              [
                                                Text(
                                                  controller.answerModel.value
                                                      .data![index].addDate
                                                      .toString(),
                                                  style: smallTextStyle,
                                                ),
                                                Expanded(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                      children: [
                                                        RawMaterialButton(
                                                          onPressed: () {
                                                            controller
                                                                .communityAnswerLikeDislikeNetworkApi(
                                                                controller
                                                                    .answerModel
                                                                    .value
                                                                    .data![index]
                                                                    .id!,
                                                                controller
                                                                    .answerModel
                                                                    .value
                                                                    .data![index]
                                                                    .aslike!,
                                                                id);
                                                          },
                                                          child: Image.asset(
                                                            "assets/images/like.png",
                                                            height: 20,
                                                            width: 20,
                                                            color: controller
                                                                .answerModel
                                                                .value
                                                                .data![index]
                                                                .aslike
                                                                .toString() ==
                                                                "1"
                                                                ? Colors.blue
                                                                : Colors.grey,
                                                          ),
                                                          constraints:
                                                          const BoxConstraints(
                                                              maxHeight: 20,
                                                              maxWidth: 20),
                                                          shape: const CircleBorder(),
                                                        ),
                                                        RawMaterialButton(
                                                          onPressed: () {
                                                            Share.share(
                                                                controller
                                                                    .answerModel
                                                                    .value
                                                                    .data![index]
                                                                    .answer
                                                                    .toString());
                                                          },
                                                          child: Image.asset(
                                                            "assets/images/share.png",
                                                            height: 20,
                                                            width: 20,
                                                          ),
                                                          constraints: BoxConstraints(
                                                              maxHeight: 20,
                                                              maxWidth: 20),
                                                          shape: CircleBorder(),
                                                        ),
                                                      ],
                                                    ))
                                              ],
                                            ));
                                      }
                                    },
                                    itemCount: controller
                                        .answerModel.value.data!.length,
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    controller.rxMessaage.value,
                                    style: smallTextStyle,
                                  ),
                                ),
                        ),
                      ],
                    )),
                bottomSheet: Container(
                  padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                  width: double.infinity,
                  color: Colors.transparent,
                  height: 60,
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.top),
                    child: Container(
                      height: 60,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 6,
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 8, right: 8),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1.0, color: Colors.blue),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TextFormField(
                                controller: controller.etMessage,
                                decoration: InputDecoration(
                                    hintText: "Write message...",
                                    hintStyle: TextStyle(color: Colors.black),
                                    border: InputBorder.none),
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return "Please Enter mesaages....";
                                  }
                                },
                              ),
                            ),
                          ),
                          FloatingActionButton(
                            shape: CircleBorder(
                                side:
                                    BorderSide(width: 0.5, color: Colors.blue)),
                            onPressed: () {
                              controller
                                  .postCommunityAnswerNetworkApi(
                                      controller.etMessage.text, id)
                                  .then((value) {
                                controller.etMessage.clear();
                                controller.getAnswerNetworkApi(id);
                              });
                            },
                            child: Icon(
                              Icons.send,
                              color: Colors.blue,
                              size: 18,
                            ),
                            backgroundColor: Colors.white,
                            elevation: 0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showCommentSheet(BuildContext context, String id) {
    TextEditingController etmessage = TextEditingController();
    controller.rxMessaage.value = "";
    controller.rxMessaage.value = "";
    showModalBottomSheet(
      context: context,
      barrierColor: Colors.black.withOpacity(0.1),
      isScrollControlled: true,
      backgroundColor: Colors.white70,
      builder: (context) {
        return ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              width: double.infinity,
              height: Get.height - 150,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Container(
                    padding: EdgeInsets.all(10),
                    // height: h * 0.45,

                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: 40,
                          height: 7,
                          decoration: BoxDecoration(
                              border:
                              Border.all(width: 0.5, color: Colors.black38),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Obx(
                              () => controller.answerModel.value.data != null
                              ? Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (context, index)
                              {
                                String commmentReply=   controller.answerModel.value.data![index].addById.toString()    ;
                                if(
                                GetStorage().read(AppConstant.id).toString()==commmentReply)
                                {
                                  return ListTile(
                                      contentPadding: EdgeInsets.zero,

                                      trailing:ClipOval(
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: BASE_URL +
                                              controller.answerModel.value
                                                  .data![index].addByPic
                                                  .toString(),
                                          height: 50,
                                          width: 50,
                                          placeholder: (context, url) =>
                                              Center(
                                                  child:
                                                  const CircularProgressIndicator()),
                                          errorWidget:
                                              (context, url, error) =>
                                          const Icon(Icons.error),
                                        ),
                                      ),

                                      title: Container(
                                          padding: EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 8,
                                              bottom: 8),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey
                                                      .withOpacity(0.7),
                                                  width: 0.5),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                              color: Colors.black
                                                  .withOpacity(0.1)),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller.answerModel
                                                    .value.data![index]
                                                    .addBy ??
                                                    '',
                                                style: bodyText1Style
                                                    .copyWith(
                                                    fontSize: 16),
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                controller.answerModel
                                                    .value
                                                    .data![index].answer
                                                    .toString(),
                                                style: smallTextStyle,
                                              ),
                                              controller.answerModel.value
                                                  .data![index].answer
                                                  .toString().contains(
                                                  "Https") ?
                                              InkWell(
                                                onTap: () {
                                                  _launchURL(controller
                                                      .answerModel.value
                                                      .data![index].answer
                                                      .toString());
                                                },
                                                child:
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .end,
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .end,
                                                  children: [
                                                    Text("Open",
                                                        style: TextStyle(
                                                          color: Colors
                                                              .blue,

                                                        )
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .arrow_forward_ios_rounded,
                                                      color: Colors.blue,
                                                      size: 18,
                                                    )

                                                  ],

                                                ),
                                              )
                                                  :
                                              Container()
                                            ],
                                          )),
                                      subtitle: Row(
                                        children:
                                        [
                                          Text(
                                            controller.answerModel.value
                                                .data![index].addDate
                                                .toString(),
                                            style: smallTextStyle,
                                          ),
                                          Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.end,
                                                children: [
                                                  RawMaterialButton(
                                                    onPressed: () {
                                                      controller
                                                          .communityAnswerLikeDislikeNetworkApi(
                                                          controller
                                                              .answerModel
                                                              .value
                                                              .data![index]
                                                              .id!,
                                                          controller
                                                              .answerModel
                                                              .value
                                                              .data![index]
                                                              .aslike!,
                                                          id);
                                                    },
                                                    child: Image.asset(
                                                      "assets/images/like.png",
                                                      height: 20,
                                                      width: 20,
                                                      color: controller
                                                          .answerModel
                                                          .value
                                                          .data![index]
                                                          .aslike
                                                          .toString() ==
                                                          "1"
                                                          ? Colors.blue
                                                          : Colors.grey,
                                                    ),
                                                    constraints:
                                                    const BoxConstraints(
                                                        maxHeight: 20,
                                                        maxWidth: 20),
                                                    shape: const CircleBorder(),
                                                  ),
                                                  RawMaterialButton(
                                                    onPressed: () {
                                                      Share.share(
                                                          controller
                                                              .answerModel
                                                              .value
                                                              .data![index]
                                                              .answer
                                                              .toString());
                                                    },
                                                    child: Image.asset(
                                                      "assets/images/share.png",
                                                      height: 20,
                                                      width: 20,
                                                    ),
                                                    constraints: BoxConstraints(
                                                        maxHeight: 20,
                                                        maxWidth: 20),
                                                    shape: CircleBorder(),
                                                  ),
                                                ],
                                              ))
                                        ],
                                      ));
                                }
                                {
                                  return ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: ClipOval(
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: BASE_URL +
                                              controller.answerModel.value
                                                  .data![index].addByPic
                                                  .toString(),
                                          height: 50,
                                          width: 50,
                                          placeholder: (context, url) => Center(
                                              child:
                                              const CircularProgressIndicator()),
                                          errorWidget:
                                              (context, url, error) =>
                                          const Icon(Icons.error),
                                        ),
                                      ),
                                      // CircleAvatar(
                                      //   backgroundImage: NetworkImage(BASE_URL+data.addByPic.toString()),
                                      // ),
                                      title: Container(
                                          padding: EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 8,
                                              bottom: 8),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey
                                                      .withOpacity(0.7),
                                                  width: 0.5),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                              color: Colors.black
                                                  .withOpacity(0.1)),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller
                                                    .answerModel
                                                    .value
                                                    .data![index]
                                                    .addBy ??
                                                    '',
                                                style: bodyText1Style
                                                    .copyWith(fontSize: 16),
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                controller.answerModel.value
                                                    .data![index].answer
                                                    .toString(),
                                                style: smallTextStyle,
                                              ),
                                              controller.answerModel.value
                                                  .data![index].answer
                                                  .toString().contains("Https")?
                                              InkWell(
                                                onTap: ()
                                                {
                                                  _launchURL(controller.answerModel.value
                                                      .data![index].answer
                                                      .toString());
                                                },
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [

                                                    Text("Open",style: TextStyle(
                                                      color: Colors.blue,

                                                    )
                                                    ),
                                                    Icon(
                                                      Icons.arrow_forward_ios_rounded,
                                                      color: Colors.blue,
                                                      size: 18,
                                                    )

                                                  ],

                                                ),
                                              )
                                                  :
                                              Container()
                                            ],
                                          )),
                                      subtitle: Row(
                                        children: [
                                          Text(
                                            controller.answerModel.value
                                                .data![index].addDate
                                                .toString(),
                                            style: smallTextStyle,
                                          ),
                                          Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.end,
                                                children: [
                                                  RawMaterialButton(
                                                    onPressed: () {
                                                      controller.communityAnswerLikeDislikeNetworkApi(
                                                          controller.answerModel.value.data![index]
                                                              .id!,
                                                          controller
                                                              .answerModel
                                                              .value
                                                              .data![index]
                                                              .aslike!,
                                                          id);
                                                    },
                                                    child: Image.asset(
                                                      "assets/images/like.png",
                                                      height: 20,
                                                      width: 20,
                                                      color: controller
                                                          .answerModel
                                                          .value
                                                          .data![index]
                                                          .aslike
                                                          .toString() ==
                                                          "1"
                                                          ? Colors.blue
                                                          : Colors.grey,
                                                    ),
                                                    constraints:
                                                    const BoxConstraints(
                                                        maxHeight: 20,
                                                        maxWidth: 20),
                                                    shape: const CircleBorder(),
                                                  ),
                                                  RawMaterialButton(
                                                    onPressed: () {
                                                      Share.share(controller
                                                          .answerModel
                                                          .value
                                                          .data![index]
                                                          .answer
                                                          .toString());
                                                    },
                                                    child: Image.asset(
                                                      "assets/images/share.png",
                                                      height: 20,
                                                      width: 20,
                                                    ),
                                                    constraints: BoxConstraints(
                                                        maxHeight: 20,
                                                        maxWidth: 20),
                                                    shape: CircleBorder(),
                                                  ),
                                                ],
                                              ))
                                        ],
                                      ));
                                }




                              },
                              itemCount: controller
                                  .answerModel.value.data!.length,
                            ),
                          )
                              : Center(
                            child: Text(
                              controller.rxMessaage.value,
                              style: smallTextStyle,
                            ),
                          ),
                        ),
                      ],
                    )),

              ),
            ),
          ),
        );
      },
    );
  }
}
