import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vlesociety/Dashboard/model/ArticalModel.dart';

import '../../AppConstant/APIConstant.dart';
import '../../AppConstant/textStyle.dart';
import '../../Dashboard/controller/DashboardController.dart';


class CscDetails extends StatelessWidget
{     final ArticleDatum datas;
     CscDetails( this.datas, {Key? key}) : super(key: key);
      DashboardController controller = Get.find();
  @override
  Widget build(BuildContext context)
  {

    return Scaffold(
          extendBodyBehindAppBar: false,
          extendBody: false,
          backgroundColor: Colors.white,
        appBar: PreferredSize(
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
                    leadingWidth: 60,
                    elevation: 0.0,
                    leading: new IconButton
                      (
                      icon: new Icon(Icons.arrow_back_ios, color: Colors.black),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          preferredSize: Size(
            double.infinity,
            60.0,
          ),
        ),


          body: SingleChildScrollView(
            child:
            Column(
              children: [
            ClipRRect(
            child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              padding: EdgeInsets.all(10),

              width: double.infinity,
              color: Colors.white70,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(

                      fit: BoxFit.cover,
                      imageUrl: BASE_URL + datas.image.toString(),
                      height: 200,
                      width: double.infinity,
                      placeholder: (context, url) =>
                          Center(child: const CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  Container(
                    width: double.infinity,
                    child: Column(
                      children:
                      [
                        Text(
                          datas.title.toString(),
                          style: bodyText1Style,
                        ),
                        Html(data: datas.description.toString(),
                          style: {
                            "body": Style(
                              fontSize: FontSize(11.0),
                            ),},
                            onLinkTap:
                                (String? url, Map<String,
                                String> attributes,
                                element)
                            async{
                              await launch(url!);
                            }


                        ),
                      ],
                    ),
                  ),
                  // ListView.separated(itemBuilder: itemBuilder, separatorBuilder: separatorBuilder, itemCount: itemCount)
                ],
              )),
      ),
    )
              ],

            ),
          )

      );
  }
}
