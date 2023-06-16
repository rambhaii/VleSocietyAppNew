import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vlesociety/AppConstant/textStyle.dart';

import '../../../AppConstant/APIConstant.dart';
import '../../../AppConstant/AppConstant.dart';
import '../../../UtilsMethod/UtilsMethod.dart';
import '../../../Widget/CircularButton.dart';
import '../../../Widget/CustomAppBarWidget.dart';
import '../../controller/DashboardController.dart';
import '../profile.dart';
class RateUsApp extends StatefulWidget {
  RateUsApp({Key? key}) : super(key: key);

  @override
  State<RateUsApp> createState() => _RateUsAppState();
  }

class _RateUsAppState extends State<RateUsApp> {
  TextEditingController etmessage = TextEditingController();
  DashboardController controller = Get.find();
   String ratingvalue="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      PreferredSize(
          preferredSize: Size(
            double.infinity,
            60.0,
          ),
          child: CustomAppBar(
              title: GetStorage().read(AppConstant.userName),
              Points: controller.points,
              image:BASE_URL+GetStorage().read(AppConstant.profileImg)
          )
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children:
          [SizedBox(height: 20,),
            Container(child: Text("Like Using This App, Show some Love",
              style: titleStyle.copyWith(fontSize: 18,
              fontWeight: FontWeight.w900),),),
            SizedBox(height: 30,),
            RatingBar.builder(
          initialRating: 0,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 10.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating)
          {
            ratingvalue=rating.toString();
            print("safsffg"+rating.toString());
          },
        ),

            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(
                        top: 30,),
                    child: Container(
                        padding: EdgeInsets.all(5),
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
                                      CircularButton(
                                        onPress: ()
                                        async {
                                          if(etmessage.text.isEmpty)
                                          {
                                            Fluttertoast.showToast(msg: "Please Enter your comments",

                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.yellow  );
                                          }
                                          else if (ratingvalue.isEmpty)
                                          {
                                            Fluttertoast.showToast(msg: "please select rating",

                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.yellow  );
                                              }
                                            else {
                                            if (controller.userType ==
                                                "Guest") {
                                              UtilsMethod.PopupBox(
                                                  context, "rating");
                                            }
                                            else
                                            {
                                            /*  if(double.parse(ratingvalue) < 4.0)
                                              {

                                              }
                                              else
                                              {
                                               // await launch("https://play.google.com/store/search?q=vle+society+mobile+app&c=apps");
                                              }*/
                                              controller.postAppFeedbackNetworkApi(etmessage.text, ratingvalue);
                                              Get.back();
                                            }
                                          }




                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                        )
                    )
                ),
                    ],
            )

          ],
        ),
      ),
    );
  }




}
