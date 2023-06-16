
import 'dart:io';
import 'dart:ui';


import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vlesociety/Dashboard/controller/DashboardController.dart';
import 'package:vlesociety/Dashboard/view/Artical.dart';
import 'package:vlesociety/Dashboard/view/Home.dart';
import 'package:vlesociety/Dashboard/view/Services.dart';
import 'package:vlesociety/Dashboard/view/notification.dart';
import 'package:vlesociety/Dashboard/view/profile.dart';
import 'package:vlesociety/Dashboard/view/profile/ChaAdmin.dart';
import 'package:vlesociety/Dashboard/view/quize.dart';
import 'package:vlesociety/UtilsMethod/UtilsMethod.dart';
import '../../AppConstant/APIConstant.dart';
import '../../AppConstant/AppConstant.dart';
import '../../AppConstant/textStyle.dart';
import '../../CSC/CSCHome.dart';

import '../../Notification/FirebaseNotification.dart';
import '../../Widget/CircularButton.dart';
import '../../Widget/CustomIcon.dart';

import 'ArticalSearch.dart';
import 'SearchFeedArtical.dart';
import 'SearchScreen.dart';

import 'package:badges/badges.dart' as badges;
import 'package:http/http.dart' as http;

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard>
{
  DashboardController controller = Get.put(DashboardController());
  DateTime? currentBackPressTime;
  NotificationServices notificationServices = NotificationServices();



  @override
  void initState()
  {

    if (controller.isDob == true) {
      Future.delayed(
          Duration.zero,
          () =>
              UtilsMethod.dateOfBirth(context, controller.userName.toString()));
    }
    super.initState();
    controller.getgetUserDetailsNetworkApi();
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value) {
      if (kDebugMode) {
        print(value);
      }
    });
  }



  _launchURL() async
  {
    const url = 'https://hellokart.com/';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }


  @override
  Widget build(BuildContext context) {


    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent)
    );
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar:
        PreferredSize(
          child: Stack(
            children: [
              Positioned(
                  top: -80.h,
                  right: 60.w,
                  child: Container(
                    height: 150.h,
                    width: 150.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffcdf55a),
                    ),
                  )),

          Obx(() =>
              ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: AppBar(
                    backgroundColor: Colors.white.withOpacity(0.5),
                    leading: InkWell(
                      onTap: () {
                        Get.to(Profile());
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.amber.withOpacity(0.1),
                          backgroundImage: NetworkImage(BASE_URL +
                              GetStorage()
                                  .read(AppConstant.profileImg)
                                  .toString()),
                        ),
                      ),
                    ),
                    leadingWidth: 60,
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          GetStorage().read(AppConstant.userName).toString(),
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        Text(
                          "${GetStorage().read(AppConstant.points)==null?"0":GetStorage().read(AppConstant.points)
                              .toString()} Points",
                          style: smallTextStyle.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 11,
                              color: Colors.green),
                        ),
                      ],
                    ),
                    elevation: 0.0,
                    actions:
                    [

                      controller.selectedIndex.value <= 1 ?
                      RawMaterialButton(
                              constraints: BoxConstraints(
                                  maxHeight: 30.h, minWidth: 30.w),
                              onPressed: ()
                              {
                                if (controller.selectedIndex.value == 0)
                                {
                                  print("sdfdfgdgfgh");
                                  Get.to(SearchScreen());
                                } else if (controller.selectedIndex.value == 1)
                                {
                                  if (controller.selectedIndexOfArtical.value == 1)
                                  {
                                    Get.to(ArticalSearch());
                                  }
                                  else
                                  {
                                    Get.to(FeedArticalSearch());
                                  }
                                }
                              },
                              shape: CircleBorder(),
                              child: Image.asset(
                                "assets/images/search.png",
                                height: 23,
                                width: 23,
                                fit: BoxFit.fill,
                              ),
                            ) : RawMaterialButton(
                        constraints: BoxConstraints(
                            maxHeight: 30.h, minWidth: 30.w),
                        onPressed: ()
                        {
                          _launchURL();
                        },
                        shape: CircleBorder(),
                        child: Image.asset
                          (
                          "assets/images/shoppingcart.png",
                          height: 25.h,
                          width: 25.w,
                          fit: BoxFit.fill,
                        ),
                      ),
                      RawMaterialButton(
                        constraints:
                            BoxConstraints(maxHeight: 40.h, minWidth: 40.w),
                        onPressed: () {
                          //controllerNotification.getNotificationListNetworkApi();
                          Get.to(() => chats());
                        },
                        shape: CircleBorder(),
                        child: Image.asset(
                          "assets/images/chat.png",
                          height: 35,
                          width: 35,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Obx(() => Padding(
                            padding: const EdgeInsets.only(top: 5.0, right: 15),
                            child: badges.Badge(
                              position:
                                  badges.BadgePosition.topEnd(top: -8, end: -5),
                              badgeContent:
                                  Text(controller.countvalue.value.toString()),
                              child: Icon(Icons.notifications,
                                  size: 30, color: Colors.orange[300]),
                              showBadge: controller.countvalue.value != 0
                                  ? true
                                  : false,
                              ignorePointer: false,
                              onTap: () async
                              {
                                controller.countvalue.value = 0;
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setInt("count", 0);
                                Get.to(() => notification());
                              },
                              badgeStyle: badges.BadgeStyle(
                                shape: badges.BadgeShape.circle,
                                badgeColor: Colors.red,
                                padding: EdgeInsets.all(5),
                                borderRadius: BorderRadius.circular(50),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1),
                              ),
                              badgeAnimation: badges.BadgeAnimation.rotation(
                                animationDuration: Duration(seconds: 1),
                                colorChangeAnimationDuration:
                                    Duration(seconds: 1),
                                loopAnimation: false,
                                curve: Curves.fastOutSlowIn,
                                colorChangeAnimationCurve: Curves.easeInCubic,
                              ),
                            ),
                          )),

                      /*   RawMaterialButton(
                        constraints:
                                   BoxConstraints(maxHeight: 40.h, minWidth: 40.w),
                        onPressed: ()
                        {
                          //controllerNotification.getNotificationListNetworkApi();
                          Get.to(()=>notification());
                        },
                        shape: CircleBorder(),
                        child: Image.asset(
                          "assets/images/Notification.png",
                          height: 45,
                          width: 45,
                          fit: BoxFit.fill,
                        ),
                      ),*/

                      RawMaterialButton(
                        constraints:
                            BoxConstraints(maxHeight: 40.h, minWidth: 40.w),
                        onPressed: () {
                          Get.to(() => Profile());
                          //  controller.logout();
                        },
                        shape: CircleBorder(
                            side: BorderSide(width: 0.5, color: Colors.black)),
                        child: Image.asset(
                          "assets/images/menu.png",
                          height: 15,
                          width: 20,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      )
                    ],
                  ),
                ),
              )),
            ],
          ),
          preferredSize: Size(
            double.infinity,
            60.0,
          ),
        ),
        body:
        RefreshIndicator(
          onRefresh: ()
          {
            if (controller.selectedIndex.value == 0)
            {
              return controller.getCommunityNetworkApi();
            } else {
              return Future(() => true);
            }
          },
          child: SingleChildScrollView(
              controller: controller.scrollController,
              physics: const BouncingScrollPhysics(),
              child: SafeArea(
                child: Obx(() =>
                    _widgetOptions.elementAt(controller.selectedIndex.value)),
              )),
        ),
        bottomNavigationBar:

        PreferredSize(
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Obx(
                () => BottomNavigationBar(
                  elevation: 0,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.white54,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/images/community.png",
                        height: 35.h,
                        width: 35.w,
                        fit: BoxFit.fill,
                      ),
                      label: 'Community',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/images/article.png",
                        height: 36.h,
                        width: 35.w,
                        fit: BoxFit.fill,
                      ),
                      label: 'Articles',
                    ),
                    BottomNavigationBarItem(
                      icon: CustomIcon(),
                      label: "",
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/images/quiz.png",
                        height: 36.h,
                        width: 35.w,
                        fit: BoxFit.fill,
                      ),
                      label: 'Quiz',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/images/services.png",
                        height: 36.h,
                        width: 35.w,
                        fit: BoxFit.fill,
                      ),
                      label: 'Services',
                    ),
                  ],
                  currentIndex: controller.selectedIndex.value,
                  selectedLabelStyle: bodyText1Style.copyWith(fontSize: 12),
                  unselectedLabelStyle: bodyText1Style.copyWith(fontSize: 12),
                  selectedItemColor: Colors.red[800],
                  unselectedItemColor: Colors.black,
                  showUnselectedLabels: true,
                  onTap: (int index) {
                    /* setState(()
                    {

                    });*/
                    switch (index)
                    {
                      case 0:
                        controller.selectedIndex.value = 0;
                        break;
                      case 1:
                        controller.selectedIndex.value = 1;
                        break;
                      case 2:
                        controller.selectedIndex.value = 2;
                        break;
                      case 3:
                        controller.selectedIndex.value = 3;
                        break;
                      case 4:
                        controller.selectedIndex.value = 4;
                        break;
                    }
                  },
                ),
              ),
            ),
          ),
          preferredSize: Size(
            double.infinity,
            55.0,
          ),
        ),
        floatingActionButton: controller.selectedIndex.value <= 2
            ? FloatingActionButton(
                onPressed: () {
                  if (controller.userType == "Guest") {
                    UtilsMethod.PopupBox(context, "Post");
                  } else {
                    controller.getCommmunityCategoryNetworkApi();
                    _showBottomSheet();
                  }
                },
                backgroundColor: Colors.transparent,
                elevation: 0,
                tooltip: 'Go Live Modal',
                child: Container(
                  alignment: Alignment.center,
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff1200FF).withOpacity(0.1),
                    border: Border.all(
                        width: 1, color: Color(0xff1200FF).withOpacity(0.1)),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(255, 255, 255, 0.7),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.add,
                    size: 28,
                    color: Color(0xff1200FF),
                  ),
                ),
              )
            : Container(),
      ),
    );
  }

  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text("hi"),
            ));
  }

  Future<void> _loadData() async {
    controller.getCommunityNetworkApi();
  }

  final List<Widget> _widgetOptions = [
    HomePage(),
    ArticalPage(),
    CSCHome(),
    QuizPage(),
    ServicePage(),
  ];

  void _showBottomSheet() {
    TextEditingController etmessage = TextEditingController();
    String catId = "";
    controller.imagesList!.clear();
    controller.fileLength.value = 0;
    controller.isCategorySelected.value = false;
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    showModalBottomSheet(
      context: context,
      barrierColor: Colors.black.withOpacity(0.1),
      isScrollControlled: true,
      backgroundColor: Colors.white70,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                  padding: EdgeInsets.all(10),
                  // height: h * 0.45,
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 40,
                        height: 7,
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 0.5, color: Colors.black38),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      Obx(
                        () => controller.isCategorySelected.value == false
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: h * 0.04,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Text(
                                      "Category",
                                      style: titleStyle,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Center(
                                    child: Text(
                                      "Select a category",
                                      style: smallTextStyle,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Obx(
                                    () => controller.communityCategoryModel
                                                .value.data !=
                                            null
                                        ? GridView.count(
                                            shrinkWrap: true,
                                            primary: false,
                                            padding: const EdgeInsets.all(8),
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10,
                                            crossAxisCount: 4,
                                            childAspectRatio: (1 / 1.35),
                                            children: List.generate(
                                              controller.communityCategoryModel
                                                  .value.data!.length,
                                              (index) => GestureDetector(
                                                onTap: () {
                                                  catId = controller
                                                      .communityCategoryModel
                                                      .value
                                                      .data![index]
                                                      .id
                                                      .toString();
                                                  controller.isCategorySelected
                                                      .value = true;
                                                },
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: 55,
                                                      width: 55,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
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
                                                                  controller
                                                                      .communityCategoryModel
                                                                      .value
                                                                      .data![
                                                                          index]
                                                                      .image
                                                                      .toString()))),
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text(
                                                      controller
                                                          .communityCategoryModel
                                                          .value
                                                          .data![index]
                                                          .title
                                                          .toString(),
                                                      style: smallTextStyle
                                                          .copyWith(
                                                              fontSize: 11),
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
                                        : const Center(
                                            child: CupertinoActivityIndicator(),
                                          ),
                                  ),
                                ],
                              )
                            : Container(
                                padding: EdgeInsets.only(
                                    top: 30, left: 10, right: 10),
                                child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12))),
                                        padding: EdgeInsets.all(10),
                                        child: Container(
                                          padding: EdgeInsets.zero,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.white,
                                                    blurRadius: 10,
                                                    spreadRadius: 10)
                                              ]),
                                          width: double.infinity,
                                          child:
                                        Obx(() =>   Column(
                                          children: [
                                            TextFormField(
                                              onChanged: (value)
                                              {
                                                value.toString().contains("https")?
                                                controller.urlvalue.value=value
                                                    :Container()  ;

                                              },
                                              minLines: 5,
                                              maxLines: null,
                                              controller: etmessage,
                                              keyboardType:
                                              TextInputType.multiline,
                                              decoration: InputDecoration(
                                                alignLabelWithHint: true,
                                                border: InputBorder.none,
                                                hintText: "Write Here.....",
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
                                              children: [
                                                Expanded(
                                                    child: Obx(() =>
                                                        Column(

                                                          mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children:
                                                          [
                                                            Container(
                                                              height: 200,
                                                              child:AnyLinkPreview(
                                                                link: controller.urlvalue.value,
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
                                                                onTap: (){}, // This disables tap event
                                                              ) ,
                                                            ),


                                                            Text(controller.fileLength != 0 ? "${controller.fileLength}  Upload file" : "",style: subtitleStyle),
                                                            controller.imagesList!=null?
                                                            Container(
                                                              height:50.h,
                                                              width: MediaQuery.of(context).size.width,
                                                              child: ListView.builder(
                                                                  scrollDirection: Axis.horizontal,
                                                                  itemCount: controller.imagesList!.length,
                                                                  shrinkWrap: true,
                                                                  physics: BouncingScrollPhysics(),
                                                                  itemBuilder: (context,int index)
                                                                  {

                                                                    final data=controller.imagesList![index].path;
                                                                    print("jkgh"+data);
                                                                    return Container(
                                                                        height: 50.h,
                                                                        width: 50.w,
                                                                        child:Container(
                                                                          decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(60),
                                                                            border: Border.all(),
                                                                            image: DecorationImage(
                                                                                image: FileImage(File(data)),
                                                                                fit: BoxFit.fill),
                                                                          ),
                                                                        )


                                                                    );
                                                                  }),
                                                            ):Center()
                                                          ],
                                                        )
                                                    )
                                                ),
                                                IconButton(
                                                    onPressed: ()
                                                    {
                                                      controller
                                                          .selectMultipleImage();
                                                    },
                                                    icon: Icon(
                                                        Icons.attach_file)),
                                                CircularButton(
                                                  onPress: () {
                                                    if (etmessage
                                                        .text.isEmpty) {
                                                      Fluttertoast.showToast(
                                                          msg: "Thank You");
                                                    }
                                                    controller
                                                        .postCommunityNetworkApi(
                                                        catId,
                                                        etmessage.text);
                                                    Get.back();
                                                  },
                                                ),
                                              ],
                                            )
                                          ],
                                        )),
                                        )))),
                      ),
                    ],
                  )),
            ),
          ),
        );
      },
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      final snackBar = const SnackBar(
        content: const Text('Press again to exit'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return Future.value(false);
    }
    return Future.value(true);
  }
}

// Settings Tab
