import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:whatsapp_share/whatsapp_share.dart';

import '../../AppConstant/APIConstant.dart';
import '../../AppConstant/textStyle.dart';
import '../../Notification/FirebaseDynamicLink.dart';
import '../../UtilsMethod/UtilsMethod.dart';
import '../controller/DashboardController.dart';
import '../model/CommunityModel.dart';
import 'CommunityDetails.dart';
import 'package:timeago/timeago.dart' as timeago;

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DashboardController controller = Get.find();
  final followContrller modelfollow = Get.put(followContrller());
  int show3 = 0;
  late bool dd;
  late String va;
  int count = 0;
  int cuntnumber = 0;
  late String keyMessage;
  FocusNode inputNode = FocusNode();
// to open keyboard call this function;
  void openKeyboard(){
    FocusScope.of(context).requestFocus(inputNode);
  }


  @override
  Widget build(BuildContext context)
  {
    controller.getSearchListNetworkApi("", "");
    return new Scaffold(
      body: Container(
        child: Column(
          children: <Widget>
          [
            SizedBox(height: 50),
            Container(
              height: 50.h,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (value)
                    {
                      keyMessage = value;
                    },
                    focusNode: inputNode,
                    autofocus:true,
                    controller: controller.searchkey,
                    decoration: InputDecoration(
                        labelText: "Search post",
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),

                        labelStyle: TextStyle(
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                        hintText: "Search post",
                        hintStyle: TextStyle(
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                        suffixIcon: InkWell(
                            onTap: ()
                            {
                              if (keyMessage.isNotEmpty)
                              {
                                controller.getSearchListNetworkApi(
                                    keyMessage, "");
                              }
                            },
                            child: Icon(
                              Icons.search,
                              size: 30,
                            )),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(5.0)))),
                  )),
            ),
            Expanded(
                child:
                Obx(
              () => SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: controller.communityModelBySerachKey.value.data != null
                        ? List.generate(
                            controller
                                .communityModelBySerachKey.value.data!.length,
                            (index) {
                              final data = controller
                                  .communityModelBySerachKey.value.data![index];

                              count = int.parse(data.ttlLike.toString());

                              return GestureDetector(
                                onTap: () {
                                  Get.to(() => CommunityDetails(
                                        cid: data.id.toString(),
                                      ));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: ClipOval(
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: BASE_URL +
                                              data.addByPic.toString(),
                                          height: 50,
                                          width: 50,
                                          placeholder: (context, url) => Center(
                                              child:
                                                  const CupertinoActivityIndicator()),
                                          errorWidget: (context, url, error) =>
                                              CircleAvatar(
                                                  backgroundColor: Colors.amber
                                                      .withOpacity(0.1),
                                                  child: const Icon(
                                                    Icons
                                                        .image_not_supported_outlined,
                                                    color: Colors.black26,
                                                  )),
                                        ),
                                      ),
                                      // CircleAvatar(
                                      //   backgroundImage: NetworkImage(BASE_URL+data.addByPic.toString()),
                                      // ),
                                      title: Text(
                                        data.addBy ?? '',
                                        style: bodyText1Style.copyWith(
                                            fontSize: 12),
                                      ),
                                      subtitle: Text(
                                        timeago.format(DateTime.parse(
                                            data.addDate.toString())),
                                        style: smallTextStyle.copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10,
                                            color:
                                                Colors.black.withOpacity(0.5)),
                                      ),

                                      trailing: Container(
                                        width: 90,
                                        child: Row(
                                          children: [
                                            GetBuilder<followContrller>(
                                              builder: (modelfollow) =>
                                                  IconButton(
                                                      onPressed: () {
                                                        if (controller
                                                                .userType ==
                                                            "Guest") {
                                                          UtilsMethod.PopupBox(
                                                              context,
                                                              "follow");
                                                        } else {
                                                          data.followStatus !=
                                                                  "Following"
                                                              ? controller
                                                                  .getfollowNetworkApi(
                                                                      data.addById
                                                                          .toString(),
                                                                      '1')
                                                              : controller
                                                                  .getfollowNetworkApi(
                                                                      data.addById
                                                                          .toString(),
                                                                      '2');
                                                          data.isSlected =
                                                              data.isSlected ==
                                                                      true
                                                                  ? false
                                                                  : true;
                                                          controller
                                                                  .communityModelBySerachKey
                                                                  .value =
                                                              controller
                                                                  .communityModelBySerachKey
                                                                  .value;
                                                          controller
                                                              .communityModelBySerachKey
                                                              .refresh();
                                                        }
                                                      },
                                                      icon: data.isSlected!
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(2.0),
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                height: 40,
                                                                width: 40,
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border: Border.all(
                                                                        width:
                                                                            .5,
                                                                        color: Colors
                                                                            .black)),
                                                                child:
                                                                    Image.asset(
                                                                  "assets/images/addf.png",
                                                                  color: Colors
                                                                      .black,
                                                                  width: 10,
                                                                  filterQuality:
                                                                      FilterQuality
                                                                          .high,
                                                                ),
                                                              ),
                                                            )
                                                          : Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(2.0),
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                height: 40,
                                                                width: 40,
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border: Border.all(
                                                                        width:
                                                                            .5,
                                                                        color: Colors
                                                                            .blue)),
                                                                child:
                                                                    Image.asset(
                                                                  "assets/images/removef.png",
                                                                  color: Colors
                                                                      .blue,
                                                                  width: 10,
                                                                  filterQuality:
                                                                      FilterQuality
                                                                          .high,
                                                                ),
                                                              ),
                                                            )),
                                            ),
                                            Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  border: Border.all(
                                                      width: 0.7,
                                                      color: Colors.grey)),
                                              child: PopupMenuButton<int>(
                                                padding: EdgeInsets.zero,
                                                icon: Icon(
                                                  Icons.adaptive.more,
                                                  color: Colors.grey,
                                                ),
                                                itemBuilder: (context) =>
                                                    List.generate(
                                                  controller.reportPostApi.value
                                                      .data!.length,
                                                  (index) => PopupMenuItem(
                                                    height: 30,
                                                    child: Text(
                                                      controller
                                                          .reportPostApi
                                                          .value
                                                          .data![index]
                                                          .title
                                                          .toString(),
                                                      style: smallTextStyle,
                                                    ),
                                                    onTap: () {
                                                      if (controller.userType ==
                                                          "Guest") {
                                                        UtilsMethod.PopupBox(
                                                            context,
                                                            controller
                                                                .reportPostApi
                                                                .value
                                                                .data![index]
                                                                .title
                                                                .toString());
                                                      } else {
                                                        controller
                                                            .postReportNetworkApi(
                                                                controller
                                                                    .reportPostApi
                                                                    .value
                                                                    .data![
                                                                        index]
                                                                    .id
                                                                    .toString(),
                                                                data.id
                                                                    .toString());
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
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 0),
                                      child: Column(
                                        children: [
                                          ReadMoreText(
                                            data.description.toString(),
                                            style: TextStyle(
                                                fontSize: 11, letterSpacing: 1),
                                            textAlign: TextAlign.justify,
                                            trimLines: 2,
                                            colorClickableText: Colors.pink,
                                            trimMode: TrimMode.Line,
                                            trimCollapsedText: 'Show more',
                                            trimExpandedText: '  Show less',
                                            moreStyle: smallTextStyle,
                                            lessStyle: smallTextStyle,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    if (data.image.toString().isNotEmpty)
                                      Container(
                                        height: 150,
                                        width: Get.width,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            image: DecorationImage(
                                                image: NetworkImage(BASE_URL +
                                                    data.image.toString()),
                                                fit: BoxFit.cover)),
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
                                                  controller.communityModelBySerachKey.value =
                                                      controller.communityModelBySerachKey.value;
                                                  controller.communityModelBySerachKey.refresh();
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
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.black54),
                                            )
                                                : Text(
                                              "${count} like",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.black54),
                                            ),
                                          ],
                                        ),
                                        RawMaterialButton(
                                          onPressed: () {
                                            if (controller.userType == "Guest") {
                                              UtilsMethod.PopupBox(context, "comment");
                                            } else {
                                              controller
                                                  .getAnswerNetworkApi(data.id.toString());
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
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 15,
                                            ),
                                            RawMaterialButton(
                                              onPressed: () async {
                                                if (controller.userType == "Guest") {
                                                  UtilsMethod.PopupBox(context, "share");
                                                } else {
                                                  //buildDynamicLinks(data.description.toString(),BASE_URL+data.image.toString(),data.id.toString());
                                                  String generateDeeplink =
                                                  await FirebaseDynamicLinkService
                                                      .buildDynamicLinks(
                                                      data.description.toString(),
                                                      BASE_URL +
                                                          data.image.toString(),
                                                      data.id.toString(),
                                                      false,2,"");
                                                  print("djfhgjk " + generateDeeplink);
                                                  if (generateDeeplink.isNotEmpty) {
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
                                                style: TextStyle(
                                                    fontSize: 10, color: Colors.black54))
                                          ],
                                        ),
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
                                                TextButton(
                                                    onPressed: () {},
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
                                                ),
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
                                      padding: const EdgeInsets.only(
                                          left: 4.0, right: 4.0),
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
                ),
              ),
            )),
          ],
        ),
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
                                    itemBuilder: (context, index) {
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
                                                      if (controller.userType ==
                                                          "Guest") {
                                                        UtilsMethod.PopupBox(
                                                            context, "like");
                                                      } else {
                                                        controller
                                                            .communityAnswerLikeDislikeNetworkApi(
                                                                controller
                                                                    .answerModel
                                                                    .value
                                                                    .data![
                                                                        index]
                                                                    .id!,
                                                                controller
                                                                    .answerModel
                                                                    .value
                                                                    .data![
                                                                        index]
                                                                    .aslike!,
                                                                id);
                                                      }
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
                                                      if (controller.userType ==
                                                          "Guest") {
                                                        UtilsMethod.PopupBox(
                                                            context, "like");
                                                      } else {
                                                        Share.share(controller
                                                            .answerModel
                                                            .value
                                                            .data![index]
                                                            .answer
                                                            .toString());
                                                      }
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
