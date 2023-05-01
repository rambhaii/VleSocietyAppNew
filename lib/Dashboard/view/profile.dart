import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vlesociety/AppConstant/AppConstant.dart';
import 'package:vlesociety/AppConstant/textStyle.dart';
import 'package:vlesociety/Dashboard/view/Services.dart';
import 'package:vlesociety/Dashboard/view/dashboard.dart';
import 'package:vlesociety/Dashboard/view/profile/AboutCSC.dart';
import 'package:vlesociety/Dashboard/view/profile/Awards.dart';
import 'package:vlesociety/Dashboard/view/profile/Certificates.dart';
import 'package:vlesociety/Dashboard/view/profile/RateUsApp.dart';
import 'package:vlesociety/Dashboard/view/profile/like.dart';
import 'package:vlesociety/Dashboard/view/profile/testimonials.dart';
import 'package:vlesociety/Dashboard/view/profile/transaction.dart';
import 'package:vlesociety/Dashboard/view/profile/youtube.dart';
import 'package:vlesociety/Widget/CircularTopButton.dart';
import 'package:whatsapp_share/whatsapp_share.dart';
import '../../AppConstant/APIConstant.dart';
import '../../Auth/controller/login_controller.dart';
import 'package:get_storage/get_storage.dart';
import '../../Auth/model/CityModel.dart';
import '../../Auth/model/StateModel.dart';
import '../../UtilsMethod/UtilsMethod.dart';
import '../../Widget/CircularButton.dart';
import '../../Widget/EditTextWidget.dart';
import '../controller/DashboardController.dart';
import 'Earning/ReferAndEarn.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'VleNews.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController etmessage = TextEditingController();
  LoginController loginController = Get.put(LoginController());
  final String toLaunch = 'https://youtube.com/@VLESOCIETY';
  String catId = "";
  String dropdownvalue = 'Item 1';
  bool isSelected = false;
  int? show;

  @override
  DashboardController controller = Get.find();

  void initState()
  {
    // TODO: implement initState
    controller.getPrivacyNetworkApi();

    super.initState();
  }

  Widget imageProfile() {
    return Container(
      height: 74,
      width: 74,
      child: Stack(
        children: [
          Obx(
            () => loginController.rxPath.value.isEmpty
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      border: Border.all(),
                      image: DecorationImage(
                          image: NetworkImage(BASE_URL + controller.image),
                          fit: BoxFit.fill),
                    ),
                    child: Container(),
                  )
                : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      border: Border.all(),
                      image: DecorationImage(
                          image: FileImage(File(loginController.rxPath.value)),
                          fit: BoxFit.fill),
                    ),
                  ),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                onTap: () {
                  showOptionDailog(context);
                },
                child: Icon(
                  Icons.camera_alt_rounded,
                  size: 20,
                  color: Colors.grey,
                ),
              )),
        ],
      ),
    );
  }
  Future<void> _launchInBrowser(String url) async {
    if (!await launch(
      url,
      forceSafariVC: true,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    )) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              right: 15,
              child: RawMaterialButton(
                constraints: BoxConstraints(maxHeight: 40, minWidth: 40),
                onPressed: () {
                  Navigator.pop(context, true);
                },
                shape: CircleBorder(),
                child: Image.asset(
                  "assets/images/back.png",
                  height: 40,
                  width: 40,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned.fill(
                top: 40,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    bottomSheet();
                                  },
                                  child: Container(
                                    height: 65,
                                    width: 65,
                                    decoration: BoxDecoration(
                                        color:
                                            Colors.greenAccent.withOpacity(0.2),
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: NetworkImage(BASE_URL +
                                                GetStorage()
                                                    .read(
                                                        AppConstant.profileImg)
                                                    .toString()),
                                            fit: BoxFit.fill),
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 10,
                                              spreadRadius: 0,
                                              color:
                                                  Colors.amber.withOpacity(0.3))
                                        ]),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.userName.toString(),
                                      style: titleStyle.copyWith(fontSize: 18),
                                      softWrap: false,
                                      maxLines: 1,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      controller.points.toString() + " Points",
                                      style: smallTextStyle.copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                          color: Colors.green),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 70,
                                alignment: Alignment.bottomRight,
                                child: TextButton(
                                  onPressed: ()
                                  {
                                    loginController.getStateNetworkApi();
                                    bottomSheet();
                                  },
                                  child: Text(
                                    "EDIT",
                                    style: titleStyle.copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Container(
                              height: 3,
                              width: MediaQuery.of(context).size.width / 1,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                    Colors.greenAccent,
                                    Colors.blue
                                  ]))),
                        ),
                        SizedBox(height: 5, width: 10),
                        ListTile(
                          onTap: () {
                            Get.to(() => HomeDashboard());
                          },
                          contentPadding: EdgeInsets.only(left: 20, right: 20),
                          title: Text("HOME",
                              style: titleStyle.copyWith(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 19,
                                  height: .5)),
                        ),
                        ListTile(
                          onTap: () {
                            Get.to(VleNews());
                          },
                          contentPadding: EdgeInsets.only(left: 20, right: 20),
                          title: Text("VLE NEWS",
                              style: titleStyle.copyWith(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 19,
                                  height: .3)),
                        ),
                        ListTile(
                          onTap: () {
                            //     Get.to(()=>youtube());
                            _launchInBrowser(toLaunch);
                          },
                          contentPadding: EdgeInsets.only(left: 20, right: 20),
                          title: Text("YOUTUBE",
                              style: titleStyle.copyWith(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 19,
                                  height: .3)),
                        ),
                        ListTile(
                          onTap: ()
                          {
                            controller.getReferalPointsDetailNetworkApi();
                          },
                          contentPadding: EdgeInsets.only(left: 20, right: 20),
                          title: Text("REFER & EARN ",
                              style: titleStyle.copyWith(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 19,
                                  height: .5)),
                        ),
                        ListTile(
                          onTap: () {
                            // Get.to(()=>transaction());
                            controller.gettransactionHistoryDetails("");
                          },
                          contentPadding: EdgeInsets.only(left: 20, right: 20),
                          title: Text("TRANSACTIONS",
                              style: titleStyle.copyWith(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 19,
                                  height: .3)),
                        ),
                        ListTile(
                          onTap: () {
                            Get.to(() => YourCertificates());
                          },
                          contentPadding: EdgeInsets.only(left: 20, right: 20),
                          title: Text("CERTIFICATES",
                              style: titleStyle.copyWith(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 19,
                                  height: .3)),
                        ),
                        ListTile(
                          onTap: () {
                            controller.getAboutCscNetworkApi();
                          },
                          contentPadding: EdgeInsets.only(left: 20, right: 20),
                          title: Text("ABOUT CSC",
                              style: titleStyle.copyWith(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 19,
                                  height: .3)),
                        ),
                        ListTile(
                          onTap: () {
                            Get.to(() => Awords());
                          },
                          contentPadding: EdgeInsets.only(left: 20, right: 20),
                          title: Text("AWARDS",
                              style: titleStyle.copyWith(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 19,
                                  height: .3)),
                        ),
                        ListTile(
                          onTap: () {
                            controller.getTestimonialsData();
                          },
                          contentPadding: EdgeInsets.only(left: 20, right: 20),
                          title: Text("TESTIMONIALS",
                              style: titleStyle.copyWith(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 19,
                                  height: .3)),
                        ),
                        ListTile(
                          onTap: () {
                            controller.getPressMediataListNetWorkApi();
                          },
                          contentPadding: EdgeInsets.only(left: 20, right: 20),
                          title: Text("PRESS MEDIA",
                              style: titleStyle.copyWith(
                                  fontWeight: FontWeight.w800, fontSize: 19)),
                        ),
                        Row(
                          children: [
                            Padding(
                                padding: EdgeInsets.only(
                              left: 60,
                            )),
                            InkWell(
                              onTap: () {
                                if (controller.userType == "Guest") {
                                  UtilsMethod.PopupBox(context, "feedback");
                                } else {
                                  bottomSheetFeedBack();
                                }
                              },
                              child: Column(
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          right: 10, left: 10, top: 20)),
                                  Image.asset(
                                    'assets/images/feedback.png',
                                    fit: BoxFit.cover,
                                    width: 40,
                                    height: 40,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "FEEDBACK",
                                    style: TextStyle(
                                        color: Colors.grey.withOpacity(0.4),
                                        fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(
                              children: [
                                Padding(padding: EdgeInsets.only(top: 20)),
                                InkWell(
                                  onTap: () {
                                    Get.to(RateUsApp());
                                  },
                                  child: Image.asset(
                                    'assets/images/ratus.png',
                                    fit: BoxFit.cover,
                                    width: 40,
                                    height: 40,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text("RATE US",
                                    style: TextStyle(
                                        color: Colors.grey.withOpacity(0.4),
                                        fontSize: 12))
                              ],
                            ),
                            SizedBox(width: 25),
                            Column(
                              children: [
                                Padding(padding: EdgeInsets.only(top: 20)),
                                InkWell(
                                  focusColor: Colors.white,
                                  hoverColor: Colors.cyanAccent,
                                  splashColor: Colors.white,
                                  highlightColor: Colors.white,
                                  onTap: () async {
                                    if (controller.userType == "Guest") {
                                      UtilsMethod.PopupBox(context, "share");
                                    } else {
                                      await WhatsappShare.share(
                                        text: "App Link",
                                        linkUrl:
                                            'https://www.animationmedia.org/',
                                        phone: '911234567890',
                                      );
                                    }
                                  },
                                  child: Image.asset(
                                    'assets/images/shar.png',
                                    fit: BoxFit.cover,
                                    width: 40,
                                    height: 40,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "SHARE",
                                  style: TextStyle(
                                      color: Colors.grey.withOpacity(0.4),
                                      fontSize: 12),
                                )
                              ],
                            ),
                            SizedBox(width: 25),
                            Column(
                              children: [
                                Padding(padding: EdgeInsets.only(top: 20)),
                                InkWell(
                                  highlightColor: Colors.white,
                                  onTap: () {
                                    controller.getFaQNetworkApi();
                                  },
                                  child: Image.asset(
                                    'assets/images/faq.png',
                                    fit: BoxFit.cover,
                                    width: 40,
                                    height: 40,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text("FaQ",
                                    style: TextStyle(
                                        color: Colors.grey.withOpacity(0.4),
                                        fontSize: 12))
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
            Positioned(
                right: 20,
                top: Get.height / 2,
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: ()
                          {
                            termsAndPolicey();
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "TERM OF USE\nPRIVACY & POLICY",
                                style: smallTextStyle.copyWith(
                                    color: Colors.cyan, height: 1.6),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        RawMaterialButton(
                            constraints:
                                BoxConstraints(maxHeight: 43, minWidth: 43),
                            onPressed: () {
                              showAlertBox();
                            },
                            shape: CircleBorder(),
                            child: CircleAvatar(
                              backgroundColor: Colors.red.withOpacity(0.05),
                              backgroundImage:
                                  AssetImage("assets/images/logoutlogo.png"),
                            )),
                        SizedBox(
                          height: 6,
                        ),
                        Text("SIGN OUT",
                            style: bodyText1Style.copyWith(
                                color: Colors.red, fontSize: 13)),
                      ],
                    ))),
            /* Positioned(
                      right: 20,
                      top: Get.height+50/2,
                      ch

                    )*/
          ],
          /*   children: [
                   ListTile(
                     contentPadding: EdgeInsets.only(left: 20,top: 20,right: 20),
                      leading: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.tealAccent.withOpacity(0.1),
                        ),
                        child: Icon(Icons.abc,color: Colors.transparent),
                      ),

                    title: Text("Rebecca Jaaz", style: titleStyle),
                    subtitle: Text("@Rcbecca jazz", style:subtitleStyle),
                    trailing: Text("EDIT" ,style: titleStyle,),
                  ),
                  SizedBox(height: 10),
                  Divider(
                    color: Colors.greenAccent, //color of divider
                    height: 1, //height spacing of divider
                    thickness: 1, //thickness of divier line
                    indent: 0, //spacing at the start of divider
                    endIndent: 20, //spacing at the end of divider
                  ),
                   SizedBox(height: 5,width: 10),
                   ListTile(
                     contentPadding: EdgeInsets.only(left: 20,top: 2,right: 20),
                     title: Text("HOME", style: titleStyle.copyWith(
                       fontWeight: FontWeight.bold,

                     )),

                   ),

                   ListTile(
                     contentPadding: EdgeInsets.only(left: 20,top: 1,right: 20),
                     title: Text("VLE NEWS", style: titleStyle),

                   ),
                   ListTile(
                     contentPadding: EdgeInsets.only(left: 20,top: 1,right: 20),
                     title: Text("YOUTUBE", style: titleStyle),

                   ),
                   ListTile(
                     contentPadding: EdgeInsets.only(left: 20,top: 1,right: 20),
                     title: Text("TRANSACTIONS", style: titleStyle),

                   ),
                   ListTile(
                     contentPadding: EdgeInsets.only(left: 20,top: 1,right: 20),
                     title: Text("LIKE", style: titleStyle),

                   ),
                   ListTile(
                     contentPadding: EdgeInsets.only(left: 20,top: 1,right: 20),
                     title: Text("ABOUT CSC", style: titleStyle),

                   ),
                   ListTile(
                     contentPadding: EdgeInsets.only(left: 20,top: 1,right: 20),
                     title: Text("AWARDS", style: titleStyle),

                   ),
                   ListTile(
                     contentPadding: EdgeInsets.only(left: 20,top: 1,right: 20),
                     title: Text("TESTIMONIALS", style: titleStyle),

                   ),
                   ListTile(
                     contentPadding: EdgeInsets.only(left: 20,top: 1,right: 20),
                     title: Text("PRESS MEDIA", style: titleStyle.copyWith()),
                   ),
                   Row(

                     children: [
                         Padding(padding: EdgeInsets.only(left: 60,)),
                       Column(
                              children: [
                                Padding(padding: EdgeInsets.only(right: 10,left: 10,top: 20)),
                                Image.asset('assets/images/feedback.png',
                                    fit: BoxFit.cover,width: 40,height: 40,),
                                   SizedBox(height: 10),
                                    Text("FEEDBACK",style:TextStyle(
                                      color: Colors.grey
                                    ),)
                              ],
                           ),
                       SizedBox(width: 10),
                       Column(
                         children: [
                           Padding(padding: EdgeInsets.only(top: 20)),
                           Image.asset('assets/images/ratus.png',
                             fit: BoxFit.cover,width: 40,height: 40,),
                           SizedBox(height: 10),
                           Text("RATE US",style:TextStyle(
                               color: Colors.grey
                           ))
                         ],
                       ),
                       SizedBox(width: 20),
                       Column(
                         children: [
                           Padding(padding: EdgeInsets.only(top: 20)),
                           Image.asset('assets/images/shar.png',
                             fit: BoxFit.cover,width: 40,height: 40,),
                           SizedBox(height: 10),
                           Text("SHARE",style:TextStyle(
                               color: Colors.grey
                           ),)
                         ],
                       ),
                       SizedBox(width: 20),
                       Column(
                         children: [
                           Padding(padding: EdgeInsets.only(top: 20)),
                           Image.asset('assets/images/faq.png',
                             fit: BoxFit.cover,width: 40,height: 40,),
                           SizedBox(height: 10),
                           Text("FoQ",style:TextStyle(
                            color: Colors.grey
                         ))
                         ],
                       ),
                     ],
                   ),

                 ],*/
        ),
      ),
    );
  }

  void showAlertBox() {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        alignment: Alignment.center,
        insetPadding: EdgeInsets.all(20),
        backgroundColor: Colors.transparent,
        child: Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  "Are you sure!",
                  style: bodyText1Style.copyWith(
                    color: Colors.red,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "if you want to logout please press Yes otherwise No",
                    style: bodyText1Style.copyWith(
                        color: Colors.red, fontSize: 15, height: 1.3),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        color: Colors.green.withOpacity(0.1),
                        child: Text("No",
                            style: bodyText1Style.copyWith(
                              color: Colors.black,
                              fontSize: 15,
                            )),
                      ),
                      Spacer(),
                      MaterialButton(
                        onPressed: () {
                          controller.logout();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        color: Colors.cyanAccent.withOpacity(0.1),
                        child: Text("Yes",
                            style: bodyText1Style.copyWith(
                              color: Colors.black,
                              fontSize: 15,
                            )),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void bottomSheetFeedBack() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(top: 30, left: 10, right: 10),
                      child: Container(
                          padding: EdgeInsets.all(10),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              padding: EdgeInsets.all(10),
                              child: Container(
                                padding: EdgeInsets.zero,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
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
                                      keyboardType: TextInputType.multiline,
                                      decoration: InputDecoration(
                                        alignLabelWithHint: true,
                                        border: InputBorder.none,
                                        hintText: "Write Here.....",
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        CircularButton(
                                          onPress: () {
                                            if (etmessage.text.isEmpty) {
                                              Fluttertoast.showToast(
                                                  msg: "Thank You");
                                            }

                                            controller
                                                .postAppFeedbackNetworkApi(
                                                    etmessage.text, "");
                                            Get.back();
                                            //Get.back();
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )))),
                ],
              ),
            ),
          );
        });
  }

  void bottomSheet() {
    loginController.setEtDataController();
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    showModalBottomSheet(
        context: context,
        barrierColor: Colors.black.withOpacity(0.1),
        isScrollControlled: true,
        backgroundColor: Colors.white70,
        builder: (context) {
          return Card(
            elevation: 10,
            child: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: ClipRRect(
                    child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                        child: Container(
                          height: Get.height / 1.3,
                          padding: EdgeInsets.all(10),
                          // height: h * 0.45,
                          width: double.infinity,
                          color: Colors.white70,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 40,
                                height: 6,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.5, color: Colors.black12),
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(padding: EdgeInsets.only(left: 60)),
                                  Text(
                                    "Profile",
                                    style: playfairDisplay.copyWith(
                                        fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  Padding(padding: EdgeInsets.only(left: 20)),
                                  imageProfile(),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(controller.userName.toString(),
                                            style: titleStyle.copyWith(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w800)),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          "",
                                          style: subtitleStyle,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Form(
                                key: loginController.formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 80),
                                        child: Center(
                                          child: EditTextWidget(
                                            controller: loginController.etName,
                                            hint: 'Name',
                                            validator: (value) {
                                              if (value.toString().isEmpty) {
                                                return "Please Enter Name";
                                              }
                                              return null;
                                            },
                                          ),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(left: 80),
                                        child: Center(
                                          child: EditTextWidget(
                                            controller: loginController.etEmail,
                                            hint: 'Email',
                                            validator: (value) {
                                              if (value.toString().isEmpty) {
                                                return "Please Enter Email";
                                              }
                                              if (!GetUtils.isEmail(value)) {
                                                return "Please Enter Valid Email";
                                              }
                                              return null;
                                            },
                                          ),
                                        )),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 80),
                                      child: Center(
                                        child: TextFormField(
                                            controller: loginController.dob,
                                            decoration: InputDecoration(
                                              prefixIconConstraints:
                                                  BoxConstraints(
                                                minWidth: 20,
                                              ),
                                              enabledBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black),
                                              ),
                                              focusedBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black),
                                              ),
                                              hintText: "Select Date Of Birth",
                                              isDense: true,
                                              counter: Offstage(),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 1.5,
                                                      vertical: 5),
                                            ),
                                            readOnly: true,
                                            onTap: () async {
                                              final Datet =
                                                  await showDatePicker(
                                                      context: context,
                                                      builder:
                                                          (context, child) {
                                                        return Theme(
                                                          data:
                                                              Theme.of(context)
                                                                  .copyWith(
                                                            colorScheme:
                                                                ColorScheme
                                                                    .light(
                                                              primary:
                                                                  Colors.white,
                                                              // <-- SEE HERE
                                                              onPrimary: Colors
                                                                  .redAccent,
                                                              // <-- SEE HERE
                                                              onSurface: Colors
                                                                  .black, // <-- SEE HERE
                                                            ),
                                                            textButtonTheme:
                                                                TextButtonThemeData(
                                                              style: TextButton
                                                                  .styleFrom(
                                                                primary: Colors
                                                                    .red, // button text color
                                                              ),
                                                            ),
                                                          ),
                                                          child: child!,
                                                        );
                                                      },
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime(1950),
                                                      lastDate: DateTime(2050));
                                              if (Datet != null) {
                                                String formattedDate =
                                                    DateFormat('dd/MM/yyyy')
                                                        .format(Datet);
                                                loginController.dob.text =
                                                    formattedDate;
                                              }
                                            },
                                            keyboardType: TextInputType.text,
                                            style: subtitleStyle),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(left: 80),
                                        child: Center(
                                          child: EditTextWidget(
                                            controller:
                                                loginController.etMobile,
                                            hint: 'Mobile',
                                            validator: (value) {
                                              if (value.toString().isEmpty) {
                                                return "Please enter mobile";
                                              }
                                              if (value.toString().length !=
                                                  10) {
                                                return "Please enter 10 digit Number";
                                              }
                                              return null;
                                            },
                                          ),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(left: 80),
                                        child: Center(
                                          child: Obx(() {
                                            int ind = loginController
                                                .stateData.value.data!
                                                .indexWhere((element) =>
                                                    element.stateId ==
                                                    GetStorage()
                                                        .read(
                                                            AppConstant.stateId)
                                                        .toString());
                                            if (ind != -1) {
                                              loginController.selectedState =
                                                  loginController.stateData
                                                      .value.data![ind];
                                              loginController.etSate.text =
                                                  loginController
                                                      .stateData
                                                      .value
                                                      .data![ind]
                                                      .stateId!;
                                              loginController.getCityNetworkApi(
                                                  loginController.stateData
                                                      .value.data![ind].stateId
                                                      .toString());
                                            }
                                            return loginController
                                                        .stateData.value.data !=
                                                    null
                                                ? DropdownButton(
                                                    value: loginController
                                                        .selectedState,
                                                    isExpanded: true,
                                                    underline: Container(
                                                      height: 5,
                                                      decoration:
                                                          const BoxDecoration(
                                                        border: Border(
                                                          bottom: BorderSide(
                                                            color: Colors.black,
                                                            width: 1.2,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    icon: const Icon(Icons
                                                        .keyboard_arrow_down),
                                                    items: loginController
                                                        .stateData.value.data!
                                                        .map(
                                                            (StateDatum items) {
                                                      return DropdownMenuItem(
                                                        value: items,
                                                        child: Text(
                                                            " " +
                                                                items.stateTitle
                                                                    .toString(),
                                                            style:
                                                                subtitleStyle),
                                                      );
                                                    }).toList(),
                                                    hint: Text(
                                                      " Select State",
                                                      style: subtitleStyle
                                                          .copyWith(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.7)),
                                                    ),
                                                    onChanged: (newValue) {
                                                      print("dbvbsdovb");
                                                      loginController
                                                              .selectedState =
                                                          newValue!;
                                                      loginController
                                                              .etSate.text =
                                                          loginController
                                                              .selectedState
                                                              .stateId!;
                                                      loginController.stateData
                                                          .refresh();
                                                      loginController.cityModel
                                                          .value.data = null;
                                                      loginController
                                                          .selectedCity = null;
                                                      loginController
                                                          .getCityNetworkApi(
                                                              loginController
                                                                  .selectedState
                                                                  .stateId!);
                                                    },
                                                  )
                                                : const Center();
                                          }),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(left: 80),
                                        child: Center(
                                          child: Obx(() {
                                            if (loginController
                                                    .cityModel.value.data !=
                                                null) {
                                              int ind = loginController
                                                  .cityModel.value.data!
                                                  .indexWhere((element) =>
                                                      element.id ==
                                                      GetStorage()
                                                          .read(AppConstant
                                                              .cityId)
                                                          .toString());

                                              if (ind != -1) {
                                                loginController.selectedCity =
                                                    loginController.cityModel
                                                        .value.data![ind];
                                                loginController.etCity.text =
                                                    loginController.cityModel
                                                        .value.data![ind].id!;
                                              }
                                            }

                                            return loginController
                                                        .cityModel.value.data !=
                                                    null
                                                ? DropdownButton(
                                                    value: loginController
                                                        .selectedCity,
                                                    isExpanded: true,
                                                    underline: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        border: Border(
                                                          bottom: BorderSide(
                                                            color: Colors.black,
                                                            width: 1.2,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    icon: const Icon(Icons
                                                        .keyboard_arrow_down),
                                                    items: loginController
                                                        .cityModel.value.data!
                                                        .map((CityDatum items) {
                                                      return DropdownMenuItem(
                                                        value: items,
                                                        child: Text(
                                                          " " +
                                                              items.name
                                                                  .toString(),
                                                          style: subtitleStyle,
                                                        ),
                                                      );
                                                    }).toList(),
                                                    hint: Text(" Select City",
                                                        style: subtitleStyle
                                                            .copyWith(
                                                          color: Colors.grey
                                                              .withOpacity(0.7),
                                                        )),
                                                    onChanged: (newValue) {
                                                      loginController
                                                              .selectedCity =
                                                          newValue;
                                                      loginController
                                                              .etCity.text =
                                                          loginController
                                                              .selectedCity.id;
                                                      loginController.cityModel
                                                          .refresh();
                                                    },
                                                  )
                                                : const Center();
                                          }),
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  /* MaterialButton(onPressed: ()
                                  {
                                    //editInterestBottomSheet();
                                  },
                                    color: Colors.transparent.withOpacity(0.0),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                    child: Text("Edit Interest",style:smallTextStyle.copyWith(fontWeight: FontWeight.w500) ,),),*/

                                  Spacer(),
                                  Container(child: CircularButton(onPress: () {
                                    if (loginController.formKey.currentState!
                                        .validate()) {
                                      loginController
                                          .signUpProfileImgNetworkApi();
                                      Get.back();
                                    }
                                  })),
                                  /*  CircleAvatar(
                             radius: 35,
                             child:  Image.asset('assets/images/profile.png',
                             ),),*/
                                ],
                              )
                            ],
                          ),
                        )),
                  )),
            ),
          );
        });
  }

  void termsAndPolicey() {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    showModalBottomSheet(
        context: context,
        barrierColor: Colors.transparent,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (context) {
          return Obx(() => controller.privacyModel.value.data != null
              ? SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: ClipRRect(
                          child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                        child: Container(
                            height: Get.height / 1.25,
                            padding: EdgeInsets.all(10),
                            // height: h * 0.45,
                            width: double.infinity,
                            color: Colors.white70,
                            child: SingleChildScrollView(
                              child: Column(children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 40,
                                  height: 6,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.5, color: Colors.black12),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                controller.privacyModel.value.data!
                                            .description !=
                                        null
                                    ? Html(
                                        data: controller.privacyModel.value
                                            .data!.description
                                            .toString(),
                                        style: {
                                          "body": Style(
                                            fontSize: FontSize(12.0),
                                          ),
                                        },
                                        onLinkTap: (String? url,
                                            RenderContext context,
                                            Map<String, String> attributes,
                                            element) async {
                                          await launch(url!);
                                        })
                                    : Center()
                              ]),
                            )),
                      ))),
                )
              : Center());
        });
  }

  void editInterestBottomSheet() {
    int optionSelect = 0;
    bool isSelected = false;

    void checkOption(int index) {
      setState(() {
        optionSelect = index;
        choices[index].isSelected != !choices[index].isSelected!;
      });
    }

    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    showModalBottomSheet(
        context: context,
        barrierColor: Colors.transparent,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: ClipRRect(
                    child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                      height: Get.height / 2,
                      padding: EdgeInsets.all(10),
                      // height: h * 0.45,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: -10,
                                blurRadius: 20,
                                color: Colors.black)
                          ]),
                      child: Column(children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 50,
                          height: 6,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 0.5, color: Colors.black12),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "Interest",
                              style: playfairDisplay.copyWith(
                                  fontSize: 33, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        GridView.count(
                            shrinkWrap: true,
                            primary: false,
                            padding: const EdgeInsets.all(8),
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 1,
                            crossAxisCount: 2,
                            childAspectRatio: (1 / 0.4),
                            children: List.generate(choices.length, (index) {
                              return GestureDetector(
                                onTap: () => checkOption(index),
                                child: Center(
                                  child: SelectCard(
                                    choice: choices[index],
                                    index: index,
                                  ),
                                ),
                              );
                            })),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(child: CircularTopButton(onPress: () {
                              Get.back();
                            })),
                          ],
                        )
                      ])),
                ))),
          );
        });
  }

  showOptionDailog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0))),
              backgroundColor:
                  Theme.of(context).dialogBackgroundColor.withOpacity(0.9),
              children: [
                SimpleDialogOption(
                  onPressed: () {
                    loginController.chooseImage(false);
                    Get.back();
                  },
                  child: Row(
                    children: [
                      Icon(Icons.image),
                      Text(
                        "   Gallery",
                        style: Theme.of(context).textTheme.bodyText1,
                      )
                    ],
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    loginController.chooseImage(true);

                    Get.back();
                  },
                  child: Row(
                    children: [
                      Icon(Icons.camera),
                      Text(
                        "   Camera",
                        style: Theme.of(context).textTheme.bodyText1,
                      )
                    ],
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () => Get.back(),
                  child: Row(
                    children: [
                      Icon(Icons.clear),
                      Text(
                        "  Cancel",
                        style: Theme.of(context).textTheme.bodyText1,
                      )
                    ],
                  ),
                ),
              ],
            ));
  }
}

class Choice {
  const Choice({
    this.title,
    this.icon,
    this.isSelected,
    this.onTap,
  });

  final String? title;
  final IconData? icon;
  final bool? isSelected;
  final VoidCallback? onTap;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Home', icon: Icons.home, isSelected: false),
  const Choice(title: 'Contact', icon: Icons.contacts, isSelected: false),
  const Choice(title: 'Map', icon: Icons.map, isSelected: false),
  const Choice(title: 'Phone', icon: Icons.phone, isSelected: false),
  const Choice(title: 'Camera', icon: Icons.camera_alt, isSelected: false),
  const Choice(title: 'Camera', icon: Icons.camera_alt, isSelected: false),
];

class SelectCard extends StatefulWidget {
  SelectCard({Key? key, this.choice, required this.index}) : super(key: key);
  final Choice? choice;
  final index;

  @override
  State<SelectCard> createState() => _SelectCardState();
}

class _SelectCardState extends State<SelectCard> {
  int show2 = 0;
  List addList = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: InkWell(
        onTap: () {
          // setState(() {
          //   widget.choice?.onTap;
          //   if(widget.choice!.isSelected==false){
          //     print("fytyrt");
          //     choices[widget.index].isSelected=true;
          //     print(choices[widget.index].isSelected);
          //   }else{
          //     widget.choice!.isSelected!=true;
          //  }
          //
          // });
        },
        child: Container(
          color: Colors.white10,
          child: Column(children: <Widget>[
            Row(
              children: [
                Padding(padding: EdgeInsets.only(left: 10)),
                // Text(choice!.isSelected as String),

                Stack(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      child: Image.asset(
                        'assets/images/profile.png',
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 5,
                      child: widget.choice!.isSelected == true
                          ? Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(50),
                              ),
                            )
                          : SizedBox(),
                    )
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(widget.choice!.title!,
                        style: titleStyle.copyWith(
                            fontSize: 10, fontWeight: FontWeight.w800)),
                  ],
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
