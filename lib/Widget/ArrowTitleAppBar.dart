import 'package:flutter/material.dart';
import 'package:vlesociety/AppConstant/textStyle.dart';

class ArrowTitleBar extends StatelessWidget {
  final String title;
  const ArrowTitleBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       SizedBox(width: 15,),
        RawMaterialButton(onPressed: (){},
          child: Icon(Icons.arrow_back_ios_new,color: Colors.black,size: 20,),
          fillColor: Colors.transparent,
          elevation: 0,
          padding: EdgeInsets.all(8),
          shape: CircleBorder(side: BorderSide(color: Colors.black,width: 0.8)),
          constraints: BoxConstraints(maxHeight: 40,maxWidth: 40),
        ),
        SizedBox(width: 8,),
        Expanded( flex:6,child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Text(title,style: titleStyle,),
        ))
      ],
    );
  }
}
