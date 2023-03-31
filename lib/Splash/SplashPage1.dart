import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../AppConstant/textStyle.dart';
import '../Auth/view/LoginPage2.dart';


class SplashPage1 extends StatefulWidget {
  SplashPage1({
    Key? key
  }) : super(key: key);

  @override
  State<SplashPage1> createState() => _SplashPage1State();
}

class _SplashPage1State extends State<SplashPage1> {
  @override
  void initState() {
    login1Route();
    super.initState();
  }
  login1Route(){
    Future.delayed(Duration(seconds: 5)).then((value) =>
        Get.to(()=>LogInPage1(),transition: Transition.fade,duration: Duration(milliseconds: 1000))
    );
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Positioned(child:  Lottie.asset('assets/json/hello.json'),height: 400,width: Get.width,),
          Center(
            child: SizedBox(
              width: 94.0,
              height: 86.0,
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: 14.0,
                      height: 14.0,
                      child: SvgPicture.string(
                        _svg_q82u2h,
                        allowDrawingOutsideViewBox: true,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      width: 17.0,
                      height: 17.0,
                      child: SvgPicture.string(
                        _svg_eenepy,
                        allowDrawingOutsideViewBox: true,
                      ),
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(size: 13.0, middle: 0.5309),
                    Pin(size: 13.0, start: 2.0),
                    child: SvgPicture.string(
                      _svg_rksti6,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(size: 18.6, start: 14.0),
                    Pin(size: 18.6, end: 0.5),
                    child: SvgPicture.string(
                      _svg_k85fp9,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(size: 37.8, end: 9.5),
                    Pin(size: 38.0, end: 5.5),
                    child: SvgPicture.string(
                      _svg_a6uno0,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(size: 33.3, end: 14.0),
                    Pin(size: 29.3, middle: 0.248),
                    child: SvgPicture.string(
                      _svg_f1b0qd,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(size: 34.4, start: 13.5),
                    Pin(size: 1.0, middle: 0.5),
                    child: SvgPicture.string(
                      _svg_vzh86l,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Align(
                    alignment: Alignment(-0.032, -0.037),
                    child: SizedBox(
                      width: 32.0,
                      height: 32.0,
                      child: SvgPicture.string(
                        _svg_k3cvq,
                        allowDrawingOutsideViewBox: true,
                      ),
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(size: 7.0, end: 4.0),
                    Pin(size: 7.0, end: 0.0),
                    child: SvgPicture.string(
                      _svg_x8ouoh,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Align(
                    alignment: Alignment(-0.026, -0.029),
                    child: SizedBox(
                      width: 18.0,
                      height: 18.0,
                      child: SvgPicture.string(
                        _svg_sp35b4,
                        allowDrawingOutsideViewBox: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 400,),
                Text(
                  'Welcome To VLE\nSociety',
                  style: heading3.copyWith(fontSize: 30),textAlign: TextAlign.center,
                ),
                SizedBox(height: 40,),
                Text(
                  ' help each other',
                  style: heading3.copyWith(fontSize: 25,fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),

          // Align(
          //   alignment: Alignment(0.143, 0.486),
          //   child: SizedBox(
          //     width: 178.0,
          //     height: 33.0,
          //     child: Text(
          //       'help each other',
          //       style: TextStyle(
          //         fontFamily: 'Playfair Display',
          //         fontSize: 25,
          //         color: const Color(0xff000000),
          //         letterSpacing: 0.25,
          //         height: 1.2,
          //       ),
          //       textHeightBehavior:
          //       TextHeightBehavior(applyHeightToFirstAscent: false),
          //       textAlign: TextAlign.center,
          //       softWrap: false,
          //     ),
          //   ),
          // ),
          // Pinned.fromPins(
          //   Pin(size: 280.0, start: 24.0),
          //   Pin(size: 47.0, middle: 0.6648),
          //   child: Text(
          //     'Welcome To VLE Society',
          //     style: TextStyle(
          //       fontFamily: 'Playfair Display',
          //       fontSize: 35,
          //       color: const Color(0xff000000),
          //       letterSpacing: 3.5,
          //       fontWeight: FontWeight.w700,
          //       height: 0.8571428571428571,
          //     ),
          //     textHeightBehavior:
          //     TextHeightBehavior(applyHeightToFirstAscent: false),
          //     textAlign: TextAlign.center,
          //     softWrap: false,
          //   ),
          // ),
        ],
      ),
    );
  }
}
const String _svg_q82u2h =
    '<svg viewBox="50.0 137.0 14.0 14.0" ><defs><linearGradient id="gradient" x1="0.5" y1="0.0" x2="0.5" y2="1.0"><stop offset="0.0" stop-color="#fbbc05" /><stop offset="1.0" stop-color="#000000" /></linearGradient></defs><path transform="translate(50.0, 136.98)" d="M 7.021568298339844 0 C 10.8994722366333 0 14.04313659667969 3.143663644790649 14.04313659667969 7.021568298339844 C 14.04313659667969 10.8994722366333 10.8994722366333 14.04313659667969 7.021568298339844 14.04313659667969 C 3.143663644790649 14.04313659667969 0 10.8994722366333 0 7.021568298339844 C 0 3.143663644790649 3.143663644790649 0 7.021568298339844 0 Z" fill="url(#gradient)" stroke="none" stroke-width="0.5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_eenepy =
    '<svg viewBox="126.9 101.0 17.1 17.1" ><path transform="translate(126.95, 101.0)" d="M 8.526189804077148 0 C 13.23507404327393 0 17.0523796081543 3.817305564880371 17.0523796081543 8.526189804077148 C 17.0523796081543 13.23507404327393 13.23507404327393 17.0523796081543 8.526189804077148 17.0523796081543 C 3.817305564880371 17.0523796081543 0 13.23507404327393 0 8.526189804077148 C 0 3.817305564880371 3.817305564880371 0 8.526189804077148 0 Z" fill="none" stroke="#000000" stroke-width="2" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_rksti6 =
    '<svg viewBox="93.0 103.0 13.0 13.0" ><defs><linearGradient id="gradient" x1="0.5" y1="0.0" x2="0.5" y2="1.0"><stop offset="0.0" stop-color="#fbbc05" /><stop offset="1.0" stop-color="#000000" /></linearGradient></defs><path transform="translate(92.98, 103.01)" d="M 6.520027637481689 0 C 10.12093925476074 0 13.04005527496338 2.919115781784058 13.04005527496338 6.520027637481689 C 13.04005527496338 10.12093925476074 10.12093925476074 13.04005527496338 6.520027637481689 13.04005527496338 C 2.919115781784058 13.04005527496338 0 10.12093925476074 0 6.520027637481689 C 0 2.919115781784058 2.919115781784058 0 6.520027637481689 0 Z" fill="url(#gradient)" stroke="none" stroke-width="2" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_k85fp9 =
    '<svg viewBox="64.0 167.9 18.6 18.6" ><path transform="translate(64.04, 167.94)" d="M 9.278500556945801 0 C 14.40287494659424 0 18.5570011138916 4.154126644134521 18.5570011138916 9.278500556945801 C 18.5570011138916 14.40287494659424 14.40287494659424 18.5570011138916 9.278500556945801 18.5570011138916 C 4.154126644134521 18.5570011138916 0 14.40287494659424 0 9.278500556945801 C 0 4.154126644134521 4.154126644134521 0 9.278500556945801 0 Z" fill="none" stroke="#000000" stroke-width="2" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_a6uno0 =
    '<svg viewBox="96.7 143.5 37.8 38.0" ><defs><linearGradient id="gradient" x1="0.5" y1="0.0" x2="0.5" y2="1.0"><stop offset="0.0" stop-color="#fbbc05" /><stop offset="1.0" stop-color="#000000" /></linearGradient></defs><path transform="translate(96.65, 143.46)" d="M 0 0 L 37.81929779052734 38.01833343505859" fill="url(#gradient)" stroke="#000000" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_f1b0qd =
    '<svg viewBox="96.7 115.1 33.3 29.3" ><defs><linearGradient id="gradient" x1="0.5" y1="0.0" x2="0.5" y2="1.0"><stop offset="0.0" stop-color="#fbbc05" /><stop offset="1.0" stop-color="#000000" /></linearGradient></defs><path transform="translate(57.42, 108.48)" d="M 39.23462295532227 35.86648178100586 L 72.53816223144531 6.58953857421875" fill="url(#gradient)" stroke="#000000" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_vzh86l =
    '<svg viewBox="63.5 143.5 34.4 1.0" ><defs><linearGradient id="gradient" x1="0.5" y1="0.0" x2="0.5" y2="1.0"><stop offset="0.0" stop-color="#fbbc05" /><stop offset="1.0" stop-color="#000000" /></linearGradient></defs><path transform="translate(63.54, 143.5)" d="M 0 0 L 34.40585708618164 0" fill="url(#gradient)" stroke="#000000" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_k3cvq =
    '<svg viewBox="80.0 127.0 32.1 32.1" ><defs><linearGradient id="gradient" x1="0.5" y1="0.0" x2="0.5" y2="1.0"><stop offset="0.0" stop-color="#fbbc05" /><stop offset="1.0" stop-color="#000000" /></linearGradient></defs><path transform="translate(79.95, 126.95)" d="M 16.0492992401123 0 C 24.91308212280273 0 32.09859848022461 7.185517311096191 32.09859848022461 16.0492992401123 C 32.09859848022461 24.91308212280273 24.91308212280273 32.09859848022461 16.0492992401123 32.09859848022461 C 7.185517311096191 32.09859848022461 0 24.91308212280273 0 16.0492992401123 C 0 7.185517311096191 7.185517311096191 0 16.0492992401123 0 Z" fill="url(#gradient)" stroke="none" stroke-width="0.5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_x8ouoh =
    '<svg viewBox="133.0 180.0 7.0 7.0" ><defs><linearGradient id="gradient" x1="0.5" y1="0.0" x2="0.5" y2="1.0"><stop offset="0.0" stop-color="#fbbc05" /><stop offset="1.0" stop-color="#000000" /></linearGradient></defs><path transform="translate(132.97, 179.98)" d="M 3.510784149169922 0 C 5.44973611831665 0 7.021568298339844 1.571831822395325 7.021568298339844 3.510784149169922 C 7.021568298339844 5.44973611831665 5.44973611831665 7.021568298339844 3.510784149169922 7.021568298339844 C 1.571831822395325 7.021568298339844 0 5.44973611831665 0 3.510784149169922 C 0 1.571831822395325 1.571831822395325 0 3.510784149169922 0 Z" fill="url(#gradient)" stroke="none" stroke-width="0.5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_sp35b4 =
    '<svg viewBox="87.0 134.0 18.1 18.1" ><defs><linearGradient id="gradient" x1="0.5" y1="0.0" x2="0.5" y2="1.0"><stop offset="0.0" stop-color="#fbbc05" /><stop offset="1.0" stop-color="#000000" /></linearGradient></defs><path transform="translate(86.97, 133.97)" d="M 9.027730941772461 0 C 14.0136079788208 0 18.05546188354492 4.041852951049805 18.05546188354492 9.027730941772461 C 18.05546188354492 14.0136079788208 14.0136079788208 18.05546188354492 9.027730941772461 18.05546188354492 C 4.041852951049805 18.05546188354492 0 14.0136079788208 0 9.027730941772461 C 0 4.041852951049805 4.041852951049805 0 9.027730941772461 0 Z" fill="url(#gradient)" stroke="#ffffff" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
