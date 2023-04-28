import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 52,
      width: 52,
      decoration: BoxDecoration(
        color: Color(0x00A8FF).withOpacity(0.05),
        shape: BoxShape.circle,
        border: Border.all(width: 0.9, color: Color(0xff00A8FF)), ),
      child:Lottie.asset('assets/json/csc.json',
          frameRate: FrameRate.max, height: 40, width: 40, fit: BoxFit.fill,
        filterQuality: FilterQuality.high
           )
    );
  }
}
