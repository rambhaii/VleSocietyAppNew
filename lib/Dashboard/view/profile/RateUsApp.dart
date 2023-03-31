import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vlesociety/AppConstant/textStyle.dart';

import '../../../AppConstant/APIConstant.dart';
import '../../../UtilsMethod/UtilsMethod.dart';
import '../../../Widget/CircularButton.dart';
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
  late String ratingvalue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Stack(
          children: [
            Positioned(
                top: -80,
                right: 60,
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:   Color(0xffcdf55a),

                  ),
                )
            ),
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
                      backgroundImage: NetworkImage(BASE_URL+controller.image),
                    ),
                  ),
                  leadingWidth: 60,
                  title: Text(controller.userName.toString(), style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  elevation: 0.0,
                  actions: [

                    RawMaterialButton(
                      constraints: BoxConstraints(maxHeight: 40, minWidth: 40),
                      onPressed: () {
                        Get.to(()=>Profile());
                        //  controller.logout();
                      },
                      shape: CircleBorder(
                          side: BorderSide(width: 0.5, color: Colors.black)),
                      child: Image.asset("assets/images/menu.png",
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
          itemPadding: EdgeInsets.symmetric(horizontal: 17.0),
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
                                        {
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
                                            } else {
                                              controller
                                                  .postAppFeedbackNetworkApi(
                                                  etmessage.text, ratingvalue);
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
