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
class EditTextWidgetAmount extends StatelessWidget {
  final TextEditingController ?controller;
  final String hint;
  final TextInputType ?type;
  final FormFieldValidator? validator;
  final int ?length;
  final bool ?isRead;
  const EditTextWidgetAmount({Key? key,  this.controller,required this.hint, this.validator, this.type=TextInputType.text, this.length=null, this.isRead=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller:controller,
        readOnly: isRead!,
        decoration:  InputDecoration(
         /* suffixText: '*',
          suffixStyle: TextStyle(
            color: Colors.red,
          ),*/
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder:const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey),
         /* labelText: hint,
          labelStyle: TextStyle(color: Colors.grey),*/
          isDense: true,
          counter: Offstage(),
          contentPadding:const EdgeInsets.symmetric(horizontal: 3, vertical: 8),

        ),

        keyboardType: type,
        validator:validator ,
        maxLength: length,
        style: subtitleStyle);
  }
}