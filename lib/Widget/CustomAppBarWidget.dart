import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vlesociety/Dashboard/view/profile.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final String image;
  const CustomAppBar({Key? key, required this.title, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
child: CircleAvatar(
radius: 10,
backgroundColor: Colors.amber.withOpacity(0.1),
  backgroundImage: NetworkImage(image),
),
),
leadingWidth: 60,
title: Text(title, style: TextStyle(color: Colors.black, fontSize: 16),
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
);
  }
}
