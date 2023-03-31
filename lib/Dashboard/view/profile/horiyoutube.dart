import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:vlesociety/AppConstant/APIConstant.dart';
import 'package:vlesociety/Dashboard/controller/DashboardController.dart';
import 'package:vlesociety/Dashboard/view/profile.dart';
import 'package:vlesociety/UtilsMethod/UtilsMethod.dart';

class horyzantalyou extends StatelessWidget {
  horyzantalyou({super.key});

  DashboardController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.getServiceNetworkApi();
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
            // gradient: RadialGradient(
            //
            //   colors: [
            //     Color(0xffcdf55a),
            //     Color(0xffcdf55a),
            //
            //   ],
            //
            // ),
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
    child: Container(
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all()
      ),
      child: IconButton(onPressed: (){
        Get.back();
      },icon: Icon(Icons.arrow_back_ios_new,color: Colors.black,),),
    )

    ),
    leadingWidth: 60,
    elevation: 0.0,
    actions:[
    // RawMaterialButton(
    //   constraints: BoxConstraints(maxHeight: 45, minWidth: 45),
    //   onPressed: () {},
    //   shape: CircleBorder(),
    //   child: Image.asset(
    //     "assets/images/notification.png",
    //     height: 45,
    //     width: 45,
    //     fit: BoxFit.fill,
    //   ),
    // ),

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
      body: Column(),
    );
  }
}