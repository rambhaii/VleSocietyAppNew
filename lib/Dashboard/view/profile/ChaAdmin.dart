import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tawk/flutter_tawk.dart';

import 'package:get/get.dart';
import 'package:vlesociety/Dashboard/view/profile.dart';

import '../../controller/DashboardController.dart';

class chats extends StatefulWidget {
  const chats({Key? key}) : super(key: key);

  @override
  State<chats> createState() => _chatsState();
}

class _chatsState extends State<chats> {
  DashboardController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/back1.png"),fit: BoxFit.fill
                  )
              ),
            ),
            Positioned(
                top: -80.h,
                right: 60.w,
                child: Container(
                  height: 150.h,
                  width: 150.w,
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
                  backgroundColor: Colors.white.withOpacity(.0),
                  leading: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: IconButton(onPressed: (){
                        Get.back();
                      },icon: Icon(Icons.turn_left,color: Colors.deepOrange.shade400,),)
                  ),
                  leadingWidth: 60,
                  elevation: 0,
                  actions: [
                    RawMaterialButton(
                      constraints: BoxConstraints(maxHeight: 40, minWidth: 40),
                      onPressed: () {
                        Get.to(()=>Profile());
                        //  controller.logout();
                      },
                      shape: CircleBorder(
                          side: BorderSide(width: 1, color: Colors.white)),
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
       body: Tawk(
        directChatLink: 'https://tawk.to/chat/64252d304247f20fefe8c9f6/1gsojh1qr',
        visitor: TawkVisitor(
          name: 'vlesociaty',
          email: 'ex.abc@gmail.com',
        ),
      ),
    );
  }
}
