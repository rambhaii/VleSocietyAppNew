import 'dart:ui';

import 'package:adobe_xd/pinned.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vlesociety/Auth/controller/login_controller.dart';

import '../../AppConstant/textStyle.dart';
import '../../Dashboard/controller/DashboardController.dart';
import '../../Dashboard/view/dashboard.dart';
import '../../Notification/FirebaseNotification.dart';
import '../../Notification/FirebaseServices.dart';
import '../../Widget/CircularButton.dart';
import '../../Widget/EditTextWidget.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LogInPage1 extends StatefulWidget {
  LogInPage1({Key? key}) : super(key: key);

  @override
  State<LogInPage1> createState() => _LogInPage1State();
}

class _LogInPage1State extends State<LogInPage1> {
  LoginController _controller = Get.put(LoginController());
  NotificationServices notificationServices = NotificationServices();
   String deviceId="";
  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller.getPrivacyNetworkApi();
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value) {
      if (kDebugMode)
      {
        deviceId = value;
        print("deviceId"+deviceId);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: 20, right: 20, top: 20, bottom: 20),
                      height: 70,
                      width: 70,
                      child: Image.asset("assets/images/icons.png"),
                    ),
                    const Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontFamily: 'Josefin Sans',
                          fontSize: 28,
                          color: const Color(0xff051ba6),
                          letterSpacing: 1.25,
                          height: 0.04,
                        ),
                        children: [
                          TextSpan(
                            text: 'VLE ',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: 'Society',
                          ),
                        ],
                      ),
                      textHeightBehavior:
                          TextHeightBehavior(applyHeightToFirstAscent: false),
                      softWrap: false,
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    _controller.signUpUsAGestUserNetworkApi("");
                  },
                  child: Container(
                      margin: EdgeInsets.only(top: 20),
                      width: Get.width,
                      child: Text(
                        "BROWSE AS GUEST ",
                        style: titleStyle.copyWith(
                            fontSize: 16, decoration: TextDecoration.underline),
                        textAlign: TextAlign.end,
                      )),
                ),
                SizedBox(
                  height: 60,
                ),
                Text(
                  'Create an Account',
                  style: titleStyle,
                ),
                Container(
                    margin: EdgeInsets.only(top: 40),
                    width: Get.width,
                    child: Text(
                      "Enter your mobile number\nwith country code",
                      style: smallTextStyle,
                      textAlign: TextAlign.center,
                    )),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Spacer(
                      flex: 1,
                    ),
                    Expanded(
                        flex: 1,
                        child: TextFormField(
                            readOnly: true,
                            initialValue: "+91",
                            decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              isDense: true,
                            ),
                            style: titleStyle)),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        flex: 5,
                        child: Form(
                          key: _keyForm,
                          child: TextFormField(
                              controller: _controller.etMobile,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                counter: Offstage(),
                                hintText: "0000000000",
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 8),
                              ),
                              validator: (value) {
                                if (value.toString().isEmpty) {
                                  return "Please enter mobile No.";
                                }
                                if (value!.length != 10) {
                                  return "Please enter 10 digits mobile number";
                                }
                              },
                              maxLength: 10,
                              style: titleStyle),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 36,
                ),
                SizedBox(
                  width: 20,
                ),
                Row(
                  children:
                  [
                    Text(
                        'Next',
                        style: titleStyle.copyWith(fontSize: 20),
                        textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: CircularButton(
                        onPress: ()
                        {
                          if (_keyForm.currentState!.validate())
                          {
                              _controller.loginNetworkApi(deviceId);
                            }

                        }
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: Get.width,
                  child: Text(
                    'Sign In With',
                    style: titleStyle.copyWith(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            UserCredential userCredential =
                                await FirebaseServices()
                                    .signInWithGooglewithFirebase();
                            if (userCredential != null)
                            {
                              _controller.signUpwithSocialLoginNetworkApi(userCredential, deviceId);
                            }
                          },
                          child: Container(
                            child: Image.asset(
                              "assets/images/google_icon.png",
                              height: 40,
                              width: 40,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Google",
                          style: titleStyle.copyWith(fontSize: 15),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Column(
                      children:
                      [
                        InkWell(
                          onTap: () async {
                            await FirebaseServices().signInWithFacebook();
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/facebook.png"))),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text("Facebook",
                            style: titleStyle.copyWith(fontSize: 15))
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: () {
                    termsAndPolicey();
                  },
                  child:
                  Text.rich(
                    TextSpan(
                      style: smallTextStyle,
                      children: [
                        TextSpan(
                          text:
                              'By signing in or creating an account, you agree with our \n',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 12,
                              height: 2,
                              letterSpacing: 0.2),
                        ),
                        TextSpan(
                          text: 'Term and conditions',
                          style: TextStyle(
                            color: const Color(0xff006eff),
                            fontWeight: FontWeight.w300,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        TextSpan(
                          text: ' and ',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(
                            color: const Color(0xff006eff),
                            fontWeight: FontWeight.w300,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        TextSpan(
                          text: ' ',
                          style: TextStyle(
                            color: const Color(0xff006eff),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.center,
                    softWrap: false,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
          return Obx(() => _controller.privacyModel.value.data != null
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
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  child: Text(_controller.privacyModel.value.data!
                                      .title.toString(),style: heading3,),

                                ),
                                _controller.privacyModel.value.data!
                                            .description !=
                                        null
                                    ? Html(
                                        data: _controller.privacyModel.value
                                            .data!.description
                                            .toString(),
                                        style: {
                                          "body": Style(
                                              fontSize: FontSize(16.0),
                                              textAlign: TextAlign.justify,
                                              lineHeight: LineHeight(1.8)),
                                        },
                                        onLinkTap: (String? url, Map<String, String> attributes,
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
}
