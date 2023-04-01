import 'dart:ui';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:vlesociety/Dashboard/controller/DashboardController.dart';
import 'package:vlesociety/Dashboard/view/Artical.dart';
import 'package:vlesociety/Dashboard/view/Home.dart';
import 'package:vlesociety/Dashboard/view/Services.dart';
import 'package:vlesociety/Dashboard/view/notification.dart';
import 'package:vlesociety/Dashboard/view/profile.dart';
import 'package:vlesociety/Dashboard/view/quize.dart';
import 'package:vlesociety/UtilsMethod/UtilsMethod.dart';
import '../../AppConstant/APIConstant.dart';
import '../../AppConstant/textStyle.dart';
import '../../CSC/CSCHome.dart';
import '../../Notification/FirebaseDynamicLink.dart';
import '../../Notification/FirebaseNotification.dart';
import '../../Widget/CircularButton.dart';
import '../../Widget/CustomIcon.dart';
import 'SearchFeedArtical.dart';
import 'SearchScreen.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  DashboardController controller = Get.put(DashboardController());
  DateTime? currentBackPressTime;
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    // TODO: implement initState


    super.initState();
    FirebaseDynamicLinkService.initDynamicLinks(context);
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

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: PreferredSize(
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
              ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: AppBar(
                    backgroundColor: Colors.white.withOpacity(0.5),
                    leading: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.amber.withOpacity(0.1),
                        backgroundImage:
                            NetworkImage(BASE_URL + controller.image),
                      ),
                    ),
                    leadingWidth: 60,
                    title: Text(
                      controller.userName.toString(),
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    elevation: 0.0,
                    actions: [
                      controller.selectedIndex.value <= 1
                          ? RawMaterialButton(
                              constraints: BoxConstraints(
                                  maxHeight: 30.h, minWidth: 30.w),
                              onPressed: () {
                                if (controller.selectedIndex.value == 0) {
                                  controller.getSearchListNetworkApi("", "");
                                } else if (controller.selectedIndex.value ==
                                    1) {
                                  print("sddgdfgfgg" +
                                      controller.selectedIndexOfArtical.value
                                          .toString());
                                  if (controller.selectedIndexOfArtical.value ==
                                      1) {
                                    Get.to(FeedArticalSearch());
                                  } else {
                                    controller.getArticleBySearchKeyNetworkApi(
                                        "", "", "");
                                    print("dhfggdjffddh" +
                                        controller.selectedIndex.value
                                            .toString());
                                  }
                                }
                                // Get.to(SearchScreen());
                                //controller.getNotificationListNetworkApi();
                              },
                              shape: CircleBorder(),
                              child: Image.asset(
                                "assets/images/search.png",
                                height: 23,
                                width: 23,
                                fit: BoxFit.fill,
                              ),
                            )
                          : Container(),
                  /*    RawMaterialButton(
                        constraints:
                            BoxConstraints(maxHeight: 30.h, minWidth: 30.w),
                        onPressed: () {
                          controller.getNotificationListNetworkApi();
                        },
                        shape: CircleBorder(),
                        child: Image.asset(
                          "assets/images/chat.png",
                          height: 30,
                          width: 30,
                          fit: BoxFit.fill,
                        ),
                      ),*/
                      RawMaterialButton(
                        constraints:
                            BoxConstraints(maxHeight: 40.h, minWidth: 40.w),
                        onPressed: () {
                          controller.getNotificationListNetworkApi();
                        },
                        shape: CircleBorder(),
                        child: Image.asset(
                          "assets/images/Notification.png",
                          height: 45,
                          width: 45,
                          fit: BoxFit.fill,
                        ),
                      ),
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
              ),
            ],
          ),
          preferredSize: Size(
            double.infinity,
            60.0,
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () {
            if(controller.selectedIndex.value==0)
              {
                return controller.getCommunityNetworkApi();
              }
            else{
              return Future(() => true);
            }

          },
          child: SingleChildScrollView(
               controller: controller.scrollController,
              physics: const BouncingScrollPhysics(),
              child: SafeArea(
            child: Obx(
                () => _widgetOptions.elementAt(controller.selectedIndex.value)),
          )),
        ),
        bottomNavigationBar: PreferredSize(
          child:  ClipRRect(
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
                    setState(() {
                      print(
                          controller.selectedIndex.value.toString() + "hello");
                    });
                    switch (index) {
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
                onPressed: ()
                {
                  if(controller.userType=="Guest")
                     {UtilsMethod.PopupBox(context,"Post");}
                   else
                      {
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

  Future<void> _loadData() async {
    controller.getCommunityNetworkApi();
  }

  final List<Widget> _widgetOptions =  [
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
                                          child: Column(
                                            children: [
                                              TextFormField(
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
                                                      child: Obx(() => Text(
                                                            controller.fileLength !=
                                                                    0
                                                                ? controller
                                                                        .fileLength
                                                                        .toString() +
                                                                    "  file Selected"
                                                                : "",
                                                            style:
                                                                subtitleStyle,
                                                          ))),
                                                  IconButton(
                                                      onPressed: () {
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
                                          ),
                                        )))),
                      ),

                      // Container(
                      //     padding: EdgeInsets.only(top: 30, left: 10, right: 10),
                      //     child: Container(
                      //         padding: EdgeInsets.all(10),
                      //         child: Container(
                      //             decoration: BoxDecoration(
                      //                 color: Colors.grey,
                      //                 borderRadius: BorderRadius.all(Radius.circular(12))),
                      //             padding: EdgeInsets.all(10),
                      //             child: Container(
                      //               padding: EdgeInsets.zero,
                      //               decoration: BoxDecoration(
                      //                   color: Colors.white,
                      //                   borderRadius: BorderRadius.all(Radius.circular(8)),
                      //                   boxShadow: [
                      //                     BoxShadow(
                      //                         color: Colors.white,
                      //                         blurRadius: 10,
                      //                         spreadRadius: 10)
                      //                   ]),
                      //               width: double.infinity,
                      //               height: 150,
                      //               child: Stack(
                      //                 children: [
                      //                   Positioned(
                      //                       bottom: 0,
                      //                       right: 0,
                      //                       child: Row(
                      //                         mainAxisAlignment: MainAxisAlignment.end,
                      //                         children: [
                      //                           IconButton(onPressed: (){}, icon: Icon(Icons.attach_file)),
                      //                           CircularButton(onPress: (){
                      //
                      //                   },),
                      //                         ],
                      //                       ))
                      //                 ],
                      //               ),
                      //             )))),

                      // ListView.separated(itemBuilder: itemBuilder, separatorBuilder: separatorBuilder, itemCount: itemCount)
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