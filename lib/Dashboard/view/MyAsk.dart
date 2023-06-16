import 'dart:ui';

import 'package:any_link_preview/any_link_preview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vlesociety/Dashboard/controller/DashboardController.dart';
import 'package:vlesociety/Dashboard/view/profile/tawk_widget.dart';
import '../../AppConstant/APIConstant.dart';
import '../../AppConstant/AppConstant.dart';
import '../../AppConstant/textStyle.dart';
import '../../Notification/FirebaseDynamicLink.dart';
import '../../UtilsMethod/UtilsMethod.dart';
import '../../Widget/loading_widget.dart';
import '../AddMobAds.dart';
import 'CommunityDetails.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'SingleImageView.dart';

class MyAsk extends StatefulWidget {
  MyAsk({super.key});

  @override
  State<MyAsk> createState() => _MyAskState();
}

class _MyAskState extends State<MyAsk> {
  DashboardController controller = Get.find();
  int count = 0;
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
  Widget build(BuildContext context) {
    return
      Obx(
      () => Column(
        children: [
          Column(
            children: controller.myAskModel.value.data != null
                ? List.generate(
                    controller.myAskModel.value.data!.length,
                    (index) {
                      final data = controller.myAskModel.value.data![index];

                      String desc=data.description.toString();
                      String dataUrlValue=desc;
                      dataUrlValue = dataUrlValue.replaceFirst(RegExp('H'), 'h');


                      return
                        Card(
                          color: Colors.white,

                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: GestureDetector(
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
                               /*   ListTile(
                                    contentPadding: EdgeInsets.zero,
                                   *//* leading:
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
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children:
                                                      [
                                                        data.addByPic.toString().isNotEmpty?
                                                        CachedNetworkImage(
                                                          fit: BoxFit.cover,
                                                          imageUrl: BASE_URL +  GetStorage()
                                                              .read(AppConstant.profileImg)
                                                              .toString(),
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
                                                        ): Center(child: LoadingWidget())

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
                                          imageUrl:  BASE_URL +
                                              GetStorage()
                                                  .read(AppConstant.profileImg)
                                                  .toString(),
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
                                    ),*//*
                                   *//* title: Row(children:[
                                      Text(
                                      GetStorage().read(AppConstant.userName).toString(),
                                      style: bodyText1Style.copyWith(fontSize: 12),
                                    ),
                                      SizedBox(width: 10,),
                                    ],),
                                    subtitle: Text(
                                      timeago.format(
                                          DateTime.parse(data.addDate.toString())
                                      ),
                                      style: smallTextStyle.copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10,
                                          color: Colors.black.withOpacity(0.5)),
                                    ),*//*


                                  ),*/

                                  Padding(
                                    padding: const EdgeInsets.only(left: 5, right: 0,top: 5),
                                    child: Column(
                                      children:
                                      [

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
                                      height: 180,
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
                                  data.description.toString().contains("Https")|| data.description.toString().contains("https")?
                                  Container
                                    (
                                    height: 230,
                                    width: Get.width.w,
                                    child:
                                    AnyLinkPreview(
                                        link:dataUrlValue,
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
                                                ),));
                                        }
                                    ),



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
                                                String generateDeeplink =
                                                await FirebaseDynamicLinkService
                                                    .buildDynamicLinks(
                                                    data.description.toString(),
                                                    BASE_URL +
                                                        data.image.toString(),
                                                    data.id.toString(),
                                                    false,1,"");
                                                print("djfhgjk " + generateDeeplink);
                                                if (generateDeeplink.isNotEmpty) {
                                                  controller.getcommunityShareNetworkApi(
                                                      data.id.toString());
                                                  controller.getCommunityNetworkApi();
                                                }
                                              }
                                            },

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
                                              style: TextStyle(
                                                  fontSize: 10, color: Colors.black54))
                                        ],
                                      ),
                                      RawMaterialButton
                                        (
                                        onPressed: () async
                                        {

                                          if (controller.userType == "Guest")
                                          {
                                            UtilsMethod.PopupBox(context, "share");
                                          }
                                          else
                                          {

                                            String generateDeeplink =
                                            await FirebaseDynamicLinkService
                                                .buildDynamicLinks(
                                                data.description.toString(),
                                                BASE_URL +
                                                    data.image.toString(),
                                                data.id.toString(),
                                                false,2,"");





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
                                            /*  TextButton(
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

                                ],
                              ),
                            ),
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
          controller.isLoadingMyAsk.value?const LoadingWidget():Container(),

        ],
      ),
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

              ),
            ),
          ),
        );
      },
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
                              itemBuilder: (context, index) {
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
}
