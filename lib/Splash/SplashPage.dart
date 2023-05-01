import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:vlesociety/Splash/SplashPage1.dart';

import '../AppConstant/textStyle.dart';



class SplashPage extends StatefulWidget {
 const SplashPage({
    Key? key
  }) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  @override
  void initState()
  {

    Future.delayed(Duration(seconds: 5)).then((value) =>
        Get.off(()=>SplashPage1(),transition: Transition.fadeIn,duration: Duration(milliseconds: 1000))
    );
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return
      Scaffold(
      backgroundColor: const Color(0xffffffff),
      body:
      Stack(
        children: <Widget>[
         //  Positioned(child: Image.asset("assets/images/team.png"),height: 400,width: Get.width,),

          Positioned(
            top: -150.h,
            child:  RotationTransition(
              alignment: Alignment.center,
              turns: AlwaysStoppedAnimation(-60 / 360),
              child: Lottie.asset('assets/json/blackline.json',
                  frameRate: FrameRate.max
                  ,fit:BoxFit.fill),),height: 700.h,width: Get.width,),
          Center(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
               children:
               [
                 SizedBox(height: 150.h,),
                 Text('Become A Member of \nIndia\'s Largest', style: heading3,),
                 SizedBox(height: 10,),
                 Text('Village Level Entrepreneur \nVLE Society', style: heading3,),
               ],
             ),
           ),
          Positioned(
            top: 250.h,
            child: Lottie.asset('assets/json/splashanimation.json',
              frameRate: FrameRate.max,
              height: 600.h,
            )
            ,height: 500.h,width: Get.width,),

        ],
      ),

    );
  }
}
// padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),