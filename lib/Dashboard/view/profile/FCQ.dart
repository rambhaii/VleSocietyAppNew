import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vlesociety/Dashboard/controller/DashboardController.dart';

import '../../../AppConstant/APIConstant.dart';
import '../../../AppConstant/textStyle.dart';
import '../../model/FaqModel.dart';
class Faq extends StatefulWidget {
  const Faq({Key? key}) : super(key: key);

  @override
  State<Faq> createState() => _FaqState();
}

class _FaqState extends State<Faq> {
  DashboardController controller = Get.find();
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          title: Text("FAQs", style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      body:

      /**/

      controller.faqModel.value.data!.length!=null?
      ListView.builder(
          itemCount: controller.faqModel.value.data!.length,
          itemBuilder: (context, index)
          {
             final data= controller.faqModel.value.data![index];
             String d=data.title.toString();
            return
              Padding(
                padding: EdgeInsets.only(left: 10,top: 10),
                child: Column(
                  children: [
                     ExpansionTile(
                      title: Text(d,style: titleStyle.copyWith(fontSize: 20),),
                       children: <Widget>[
                        ListTile(title:
                        Column(
                          children:
                          [
                            data.image!=null?Card(
                              child:  Container(
                                height: 150,
                                width: Get.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                        image: NetworkImage(BASE_URL + data.image.toString()),
                                        fit: BoxFit.cover)
                                ),
                              ),
                            ):Container(),

                            Html(
                                data:data.description.toString(),
                                style: {
                                  "body": Style(
                                    fontSize: FontSize(16.0),
                                    textAlign: TextAlign.justify
                                  ),
                                  "body ol li, body ul li": Style(
                                    fontSize: FontSize(12.0),
                                  ),

                                },
                                onLinkTap: (String? url,  Map<String,
                                    String> attributes,
                                    element)
                                async{
                                  await launch(url!);
                                }
                            ),
                          ],

                        ),
                        ),
                      ],
                    ),


                  ],
                ),
              );

          }):Container(),
    );
  }
}
