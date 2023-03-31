import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../AppConstant/textStyle.dart';
import '../Auth/view/LoginPage2.dart';

class UtilsMethod{
static  Future<void> launchUrls(String url)
async {
  final Uri _url = Uri.parse(url);
  if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

static Future<void> PopupBox(BuildContext context ,String message)
async {
  showDialog(
    context: context,
    builder: (_) =>
        Dialog(
          alignment: Alignment.center,
          insetPadding:EdgeInsets.all(20) ,
          backgroundColor: Colors.transparent,
          child:
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
            ),
            child:
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children:
                [
                  Text("Confirms !",style: bodyText1Style.copyWith(color: Colors.red,fontSize: 20,),),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Text("You are a guest user ! Please login \n Then ${message}",style: bodyText1Style.copyWith(color: Colors.red,fontSize: 15,
                      height: 1.3
                    ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    child: Row(
                      children:
                      [
                         MaterialButton(onPressed: ()
                         {
                         Navigator.pop(context);
                        },
                         shape:RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                         color: Colors.green.withOpacity(0.1),
                       child: Text("Cancle",style: bodyText1Style.copyWith(color: Colors.black,fontSize: 15,)),),
                        Spacer(),
                        MaterialButton(onPressed: ()
                        {
                          Future.delayed(Duration(seconds: 0)).then((value) =>
                              Get.to(()=>LogInPage1(),transition: Transition.fade,duration: Duration(milliseconds: 10))
                          );
                          Navigator.pop(context);
                        },
                          shape:RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                          color: Colors.cyanAccent.withOpacity(0.1),
                          child: Text("Ok",style: bodyText1Style.copyWith(color: Colors.black,fontSize: 15,)),)
                      ],
                    ),
                  )

                ],
              ),
            ),
          ),
        ),
  );

}

}