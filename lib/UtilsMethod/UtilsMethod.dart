import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../AppConstant/textStyle.dart';
import '../Auth/view/LoginPage2.dart';
import '../Dashboard/controller/DashboardController.dart';
import '../Splash/SplashPage1.dart';

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
                          DashboardController controller = Get.find();
                          controller.logout();

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

static Future<void> PopupBoxBirthday(BuildContext context ,String message)
async {


}

static dateOfBirth(BuildContext context,String name)
{
  print("dfjghjfd");
  DashboardController controller = Get.find();
  DateTime current_date = DateTime.now();
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  final DateFormat formatter2 = DateFormat('dd/MM');
  final DateFormat formatter3 = DateFormat('yyyy');

  final String currentdate = formatter.format(current_date);
  final String currentdate1 = formatter2.format(current_date);
  final String currentdate3 = formatter3.format(current_date);

  final String dob =controller.dob.toString();
  String str1 = dob;
  List<String> str2 = str1.split('/');
  String day = str2.isNotEmpty ? str2[0] : '';
  String  month= str2.length > 1 ? str2[1] : '';
  String year = str2.length > 2 ? str2[2] : '';
  String dataofbirth=day+"/"+month;
  int data=int. parse(currentdate3)-int.parse(year);
  if(currentdate1==dataofbirth)
    {
      showDialog(
        context: context,
        builder: (_) =>
            Dialog(
              alignment: Alignment.center,
              insetPadding:EdgeInsets.all(20) ,
              backgroundColor: Colors.transparent,
              child:
              Container(
                height: 500,
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
                      Text("${data}th BIRTHDAY  ${name}",style: bodyText1Style.copyWith(color: Colors.red,fontSize: 20,),),
                      SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Lottie.asset('assets/json/birthday.json'),height: 350,width: Get.width,),
                      SizedBox(height: 10,),
                      Padding(
                        padding: EdgeInsets.only(left: 20,right: 20),

                        child: Row(
                          children:
                          [
                     /*       MaterialButton(onPressed: ()
                            {
                               controller.isDob.value=false;
                               Navigator.pop(context);
                            },
                              shape:RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                              color: Colors.green.withOpacity(0.1),
                              child: Text("Hide",style: bodyText1Style.copyWith(color: Colors.black,fontSize: 15,)),),*/
                            Spacer(),
                            MaterialButton(onPressed: ()
                            {
                              Navigator.pop(context);

                            },
                              shape:RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                              color: Colors.cyanAccent.withOpacity(0.1),
                              child: Text("Thank You",style: bodyText1Style.copyWith(color: Colors.black,fontSize: 15,)),)
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
    else
    {
      print("object");
    }
}

}