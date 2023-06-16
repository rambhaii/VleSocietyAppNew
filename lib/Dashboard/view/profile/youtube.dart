import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vlesociety/AppConstant/APIConstant.dart';
import 'package:vlesociety/Dashboard/controller/DashboardController.dart';
import 'package:vlesociety/Dashboard/view/profile/horiyoutube.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../profile.dart';
class youtube extends StatelessWidget
{
  youtube({super.key});
  DashboardController controller = Get.find();
  late final WebViewController webcontroller;
  String url="https://www.youtube.com/watch?v=rSYDs079p8o&ab_channel=LazyTechNo";
   String toLaunch = 'https://youtube.com/@VLESOCIETY';
  @override
  Widget build(BuildContext context)
  {
    print("bhufuftdv");
    return Scaffold(
        extendBodyBehindAppBar: false,
        extendBody: false,
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
                          //controller.logout();
                               },
                        shape:
                        CircleBorder(
                            side: BorderSide(width: 0.5, color: Colors.black)
                                  ),
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
         body:Container(
           child: ElevatedButton(
             onPressed: ()
               {
                 _launchInBrowser(toLaunch);
               },
               child: Text("Press"),

    ),
    ),
    );


  }


  Future<void> _launchInBrowser(String url) async {
    if (!await launch(url,
      forceSafariVC: true,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    )
    )
    {
      throw 'Could not launch $url';
    }
  }

}