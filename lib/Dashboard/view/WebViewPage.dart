import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../AppConstant/textStyle.dart';
import '../../UtilsMethod/BaseController.dart';





 class WebViewPage extends StatelessWidget
 {
   String url;
   String title;
   WebViewPage( this.url, this.title, {super.key});

  late final WebViewController controller;

 /* @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse('https://flutter.dev'),
      );
  }*/
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar:PreferredSize(
    child: Stack(
    children: [
    Positioned(
        top: -80,
        right: 60,
        child: Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:   Color(0xffcdf55a),

          ),
        )
    ),
    ClipRRect(
    child: BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
    child: AppBar(
    backgroundColor: Colors.white.withOpacity(0.5),
    leading: Container(
    height: 8,
    width: 8,
    decoration: BoxDecoration(

    ),
    child: IconButton(
    onPressed:()=> Navigator.of(context).pop(),
    icon: Icon(Icons.arrow_back_ios_new,color: Colors.black,),),
    ),
    elevation: 0.0,
    leadingWidth: 60,
       //title: Text("Website ", style: subtitleStyle.copyWith(fontWeight: FontWeight.w900,fontSize: 16))
    title: title!=null?
    Text(title, style: subtitleStyle.copyWith(fontWeight: FontWeight.w900,fontSize: 16)
    ):Text("", style: TextStyle(color: Colors.black, fontSize: 16)
    ),
    )
    )
    )

    ]
    ),
    preferredSize: Size(
    double.infinity,
    60.0,
    ),
    ),
     /* body:url!=null?
      WebViewWidget(
       // controller: controller,
          controller:
          controller = WebViewController()
            ..loadRequest
              (
              Uri.parse(url.toString()),
            )

      ):Center(
        child: BaseController().errorSnack("404 Not Found "),

      )*/

    );
  }
  }