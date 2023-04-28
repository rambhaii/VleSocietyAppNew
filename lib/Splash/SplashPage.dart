import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
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
        Get.to(()=>SplashPage1(),transition: Transition.fadeIn,duration: Duration(milliseconds: 1000))
    );
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return
      Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
         //  Positioned(child: Image.asset("assets/images/team.png"),height: 400,width: Get.width,),
          Positioned(child:
          Lottie.asset('assets/json/splashanimation.json',
              frameRate: FrameRate.max)
             ,height: 450,width: Get.width,),
          Positioned(
            bottom: -120,
            child:  RotationTransition(
             turns: AlwaysStoppedAnimation(-40 / 360),
              child: Lottie.asset('assets/json/blackline.json',
                  frameRate: FrameRate.max
                  ,fit:BoxFit.fill),),height: 700,width: Get.width,),

           Center(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 SizedBox(height: 200,),
                 Text(
                    'Become A Member of \n    India\'s Largest',
                    style: heading3,
                 ),
                 SizedBox(height: 20,),
                 Text(
                   ' Village Level Entrepreneur \n           Society',
                   style: heading3,
                 ),
               ],
             ),
           ),

        ],
      ),

    );
  }
}
// padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),