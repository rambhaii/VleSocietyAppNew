import 'package:flutter/material.dart';

import '../AppConstant/textStyle.dart';
class EditTextWidget extends StatelessWidget {
  final TextEditingController ?controller;
  final String hint;
  final TextInputType ?type;
  final FormFieldValidator? validator;
  final int ?length;
  final bool ?isRead;
  const EditTextWidget({Key? key,  this.controller,required this.hint, this.validator, this.type=TextInputType.text, this.length=null, this.isRead=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller:controller,
        readOnly: isRead!,
        decoration:  InputDecoration(
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder:const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          hintText: hint,
          isDense: true,
         counter: Offstage(),
          contentPadding:const EdgeInsets.symmetric(horizontal: 6, vertical: 8),

        ),

        keyboardType: type,
        validator:validator ,
        maxLength: length,
        style: subtitleStyle);
  }
}
