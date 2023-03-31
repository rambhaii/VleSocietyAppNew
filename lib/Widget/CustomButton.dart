import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../AppConstant/textStyle.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPress;
  final String title;
  const CustomButton({Key? key, required this.onPress, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPress,
      child: Text(title.toUpperCase(),style:GoogleFonts.josefinSans(
        textStyle:const TextStyle(
          color:  Colors.white,
          fontWeight: FontWeight.w600,
        ),
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),textAlign: TextAlign.center,),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: StadiumBorder(),
          padding: EdgeInsets.only(left: 21,right: 21,top: 13,bottom: 10)
        ),
    );
  }
}
