import 'dart:ui';

import 'package:adobe_xd/pinned.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../AppConstant/textStyle.dart';
import '../../Notification/FirebaseNotification.dart';
import '../../Widget/CircularButton.dart';
import '../../Widget/EditTextWidget.dart';
import '../controller/login_controller.dart';
import '../model/CityModel.dart';
import '../model/StateModel.dart';

class Registration extends StatefulWidget {
  Registration({
    Key? key
  }) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  LoginController controller=Get.put(LoginController());
  NotificationServices notificationServices = NotificationServices();
  String deviceId="";





  @override
  void initState() {
    // TODO: implement initState
    controller.getStateNetworkApi();
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value){
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
            margin: EdgeInsets.only(left: 15,right: 0,top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
                      height: 90.h,
                      width: 90.w,
                      child: Lottie.asset('assets/json/csc.json',frameRate: FrameRate.max
                          ,fit:BoxFit.fill),),

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
                SizedBox(height: 60,),
                Text(
                  'Create an Account',
                  style: titleStyle,

                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0,right: 15),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      children:
                      [
                        SizedBox(height: 25,),
                        EditTextWidget(
                          controller: controller.etName, hint: 'Name',
                          validator: (value){
                          if(value.toString().isEmpty)
                            {
                              return "Please Enter Name";
                            }
                          return null;
                        },
                        ),
                        SizedBox(height: 15,),
                        EditTextWidget(controller: controller.etEmail, hint: 'Email',
                          type: TextInputType.emailAddress,
                          validator: (value){
                            if(value.toString().isEmpty)
                            {
                              return "Please Enter Email";
                            }
                            if(!GetUtils.isEmail(value))
                            {
                              return "Please Enter Valid Email";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15,),
                        EditTextWidget(controller: controller.etMobile, hint: 'Mobile',
                          isRead: true,
                          type: TextInputType.phone,

                          validator: (value){
                            if(value.toString().isEmpty)
                            {
                              return "Please enter mobile";
                            }
                            if(value.toString().length!=10)
                            {
                              return "Please enter 10 digit Number";
                            }
                            return null;
                          },
                          length: 10,
                        ),
                        SizedBox(height: 15,),
                        EditTextWidget(controller: controller.etblock, hint: 'Block',
                          type: TextInputType.text,
                          validator: (value){
                            if(value.toString().isEmpty)
                            {
                              return "Please enter block";
                            }
                            return null;
                          },


                        ),
                        SizedBox(height: 15,),
                        EditTextWidget(controller: controller.etZip, hint: 'Pincode',
                          type: TextInputType.number,
                          validator: (value){
                            if(value.toString().isEmpty)
                            {
                              return "Please Enter Pincode";
                            }
                            if(value.toString().length!=6)
                            {
                              return "Please enter 6 digit Pincode";
                            }
                            return null;
                          },
                          length: 6,
                        ),
                        SizedBox(height: 5,),

                       /* Obx(()=>controller.stateData.value.data!=null?DropdownButton(
                            value: controller.selectedState,
                            isExpanded: true,
                            underline: Container(
                              height: 5,
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.black,
                                    width: 1.2,
                                  ),
                                ),
                              ),
                            ),

                            icon: const Icon(Icons.keyboard_arrow_down),
                            items:
                             controller.stateData.value.data!.map((StateDatum items)
                            {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(" "+items.stateTitle.toString(),style:subtitleStyle),
                              );
                            }).toList(),
                            hint: Text(" Select State",style: subtitleStyle.copyWith(color: Colors.grey.withOpacity(0.7)),),
                            onChanged: (newValue)
                            {
                              print("dbvbsdovb");
                              controller.selectedState=newValue;
                              controller.etSate.text=controller.selectedState.stateId;
                              controller.stateData.refresh();
                              controller.cityModel.value.data=null;
                              controller.selectedCity=null;
                              controller.getCityNetworkApi(controller.selectedState.stateId);
                            },
                          ):const Center(),
                        ),*/
                    Obx(()=>controller.stateData.value.data!=null?Container(

                        alignment: Alignment.topRight,
                        child: Column(
                          children: [
                            TypeAheadField(

                              animationStart: 0,
                              animationDuration: Duration.zero,
                              textFieldConfiguration: TextFieldConfiguration(

                                controller:controller.etSateName,
                                  onChanged: (value)
                                  {
                                    print("dbvbsdovb"+value);
                                    controller.selectedState=value;
                                    controller.etSate.text=controller.selectedState.stateId;
                                    controller.stateData.refresh();
                                    controller.cityModel.value.data=null;
                                    controller.selectedCity=null;

                                  },


                                  autofocus: true,
                                  style: subtitleStyle,
                                  decoration: InputDecoration(
                                    hintText: "Select State",
                                      hintStyle:subtitleStyle ,
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black),
                                      )
                                  )

                              ),
                              suggestionsBoxDecoration: SuggestionsBoxDecoration(

                                  color: Colors.lightBlue[50]
                              ),
                              suggestionsCallback: (pattern)
                              {
                                List<StateDatum> matches = <StateDatum>[];
                                matches.addAll(controller.stateData.value.data!);
                                matches.retainWhere((StateDatum s){
                                  return s.stateTitle!.toLowerCase().contains(pattern.toLowerCase());
                                });
                                return matches;
                              },

                              itemBuilder: (context, StateDatum s)
                              {
                                return Card(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child:Text(s.stateTitle.toString()),
                                    )
                                );
                              },

                              onSuggestionSelected: (StateDatum s)
                              {
                                controller.selectedState = s;
                                controller.getCityNetworkApi(s.stateId.toString());
                                controller.etSate.text=s.stateId.toString();
                                controller.etSateName.text = s.stateTitle.toString();
                                controller.cityModel.value.data=null;
                                controller.selectedCity=null;
                              },


                            )
                          ],
                        ),
                      ):Center()),

                        SizedBox(height: 5,),
                       /* Obx(()=>controller.cityModel.value.data!=null?DropdownButton(
                          value: controller.selectedCity,
                          isExpanded: true,
                          underline: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 1.2,
                                ),
                              ),
                            ),
                          ),

                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: controller.cityModel.value.data!.map((CityDatum items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(" "+items.name.toString(),style: subtitleStyle,),
                            );
                          }).toList(),
                          hint: Text(" Select City",style: subtitleStyle.copyWith(color: Colors.grey.withOpacity(0.7),)),
                          onChanged: (newValue) {
                            controller.selectedCity=newValue;
                            controller.etCity.text=controller.selectedCity.id;
                            controller.cityModel.refresh();
                          },
                        ):const Center(),
                        ),*/
                        Obx(()=>controller.cityModel.value.data!=null?Container(

                          alignment: Alignment.topRight,
                          child: Column(
                            children: [
                              TypeAheadField(

                                animationStart: 0,
                                animationDuration: Duration.zero,
                                textFieldConfiguration: TextFieldConfiguration(

                                    controller:controller.etNameCity,
                                    onChanged: (value)
                                    {
                                      print("dbvbsdovb"+value);



                                      controller.selectedCity=value;
                                      controller.etCity.text=controller.selectedCity.id;
                                      controller.cityModel.refresh();


                                    },


                                    autofocus: true,
                                    style: subtitleStyle,
                                    decoration: InputDecoration(
                                        hintText: " Select City",
                                        hintStyle:subtitleStyle ,
                                        enabledBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.black),
                                        )
                                    )

                                ),
                                suggestionsBoxDecoration: SuggestionsBoxDecoration(

                                    color: Colors.lightBlue[50]
                                ),
                                suggestionsCallback: (pattern)
                                {
                                  List<CityDatum> matches = <CityDatum>[];
                                  matches.addAll(controller.cityModel.value.data!);
                                  matches.retainWhere((CityDatum s){
                                    return s.name!.toLowerCase().contains(pattern.toLowerCase());
                                  });
                                  return matches;
                                },

                                itemBuilder: (context, CityDatum s)
                                {
                                  return Card(
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        child:Text(s.name.toString()),
                                      )
                                  );
                                },

                                onSuggestionSelected: (CityDatum s)
                                {
                                  controller.selectedCity = s;
                                  controller.etCity.text=s.id.toString();
                                  controller.etNameCity.text = s.name.toString();

                                },


                              )
                            ],
                          ),
                        ):Center()),



                        SizedBox(height: 25,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,

                          children: [
                            Text(
                              'Next',
                              style: titleStyle.copyWith(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: CircularButton(
                                onPress: ()
                                {
                                  if(controller.formKey.currentState!.validate())
                                  {
                                  if(deviceId!=null)
                                  { print("hfgh"+deviceId);
                                    controller.signUpNetworkApi(deviceId);
                                  }
                                  }
                                },
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),


                 SizedBox(height: 35,),
                InkWell(
                  onTap: ()
                  {
                    termsAndPolicey();
                  },
                  child: Text.rich(
                    TextSpan(
                      style: smallTextStyle,
                      children: [
                        TextSpan(
                          text: 'By signing in or creating an account, you agree with our \n',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 12,
                              height: 2,
                              letterSpacing: 0.2
                          ),
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

  void termsAndPolicey()
  {
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

                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                child: Text(controller.privacyModel.value.data!
                                    .title.toString(),style: heading3,),

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
                                      fontSize: FontSize(16.0),
                                      textAlign: TextAlign.justify,
                                      lineHeight: LineHeight(1.8),),
                                  },
                                  onLinkTap: (String? url,

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


}

