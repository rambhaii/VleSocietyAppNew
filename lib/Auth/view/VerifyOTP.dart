import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:vlesociety/AppConstant/textStyle.dart';

import '../../Widget/ArrowTitleAppBar.dart';
import '../../Widget/CustomButton.dart';
import '../controller/login_controller.dart';
class OtypVerifyPage extends StatelessWidget {
  final String id;
  final String otp;
  OtypVerifyPage({Key? key, required this.id, required this.otp}) : super(key: key);
  LoginController _controller=Get.find();
 String etotp="";
  @override
  Widget build(BuildContext context) {
    _controller.startTimer();
    return Scaffold(
     body: SafeArea(
       child: Container(
         child: Column(
           children: [
           const  SizedBox(height: 40,),
            const ArrowTitleBar(title: "Verify",),
           const  SizedBox(height: 40,),
           Text("Enter the verification code we just sent\nyou on your ${_controller.etMobile.text}",style: smallTextStyle,textAlign: TextAlign.center,),
             const  SizedBox(height: 50,),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 Padding(
                   padding: const EdgeInsets.only(top: 20.0),
                   child: Text("Code ",style: titleStyle.copyWith(fontSize: 18,color: Colors.black38),textAlign: TextAlign.center,),
                 ),
                 Container(
                   width: 150,
                   height: 40,
                   child: OTPTextField(
                     length: 4,

                     width: MediaQuery.of(context).size.width,
                     fieldWidth: 30,
                     style:const TextStyle(
                         fontSize: 17,fontWeight: FontWeight.bold
                     ),
                     textFieldAlignment: MainAxisAlignment.spaceAround,
                     fieldStyle: FieldStyle.underline,
                     onCompleted: (pin) {
                         etotp=pin;
                       _controller.verifyNetworkApi(id, pin);
                       },

                   ),
                 ),

               ],
             ),
             Container(
                 margin: EdgeInsets.only(top:50,right: 15,bottom: 50),
                 width:Get.width,
                 child: Obx(() =>  Row(
                   mainAxisAlignment: MainAxisAlignment.end,
                     children: [
                       Text(_controller.start.value.toString(),style: titleStyle.copyWith(fontSize: 16,color: _controller.start.value!=0? Colors.blue:Colors.grey.withOpacity(0.4)),textAlign: TextAlign.end,),
                       TextButton(child:Text("Resend Code?",style: titleStyle.copyWith(fontSize: 16,decoration: TextDecoration.underline,color: _controller.start.value==0?Colors.blue:Colors.grey.withOpacity(0.4)),textAlign: TextAlign.end,),
                       onPressed:_controller.start.value==0? (){
                         _controller.start.value=120;
                         _controller.startTimer();
                       }:null,
                       ),
                     ],
                   ),
                 )),

             CustomButton(onPress: (){
               _controller.verifyNetworkApi(id, etotp);
             },title: "Verify Code",)
           ],
         ),
       ),
     ),
    );
  }
}
