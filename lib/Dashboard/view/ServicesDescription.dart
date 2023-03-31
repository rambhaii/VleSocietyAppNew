import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../AppConstant/APIConstant.dart';
import '../../AppConstant/textStyle.dart';
import '../../UtilsMethod/BaseController.dart';
import '../../UtilsMethod/UtilsMethod.dart';
import 'WebViewPage.dart';

class ServicesDescription extends StatelessWidget
{  final String desc;
  final String url;
  final String title;
  final String image;
  const ServicesDescription( this.desc, this.url, this.title, this.image, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return
    Scaffold(
        extendBodyBehindAppBar: false,
        extendBody: false,
        backgroundColor: Colors.white,
        floatingActionButton:
        Padding(
          padding: const EdgeInsets.only(left: 10,right: 10,bottom: 0),
          child: Card(
            shadowColor: Colors.white,
            elevation: 2.0,
            surfaceTintColor: Colors.white,
            child: InkWell(
              highlightColor: Colors.yellow.withOpacity(0.3),
              splashColor: Colors.greenAccent.withOpacity(0.8),
              focusColor: Colors.green.withOpacity(0.0),
              hoverColor: Colors.blue.withOpacity(0.8),
              onTap: ()
              {
               /* if(url!=null)
                  {
                   // UtilsMethod.launchUrls(url.toString());
                    UtilsMethod.launchUrls("https://www.google.com/search?q=flutter+different+type+ui+design&rlz=1C1GIVA_enIN997IN997&oq=&aqs=chrome.0.35i39i362l8.3034932j0j7&sourceid=chrome&ie=UTF-8");
                  }
             */
                if(url.isNotEmpty)
                  {
                    Get.to(WebViewPage(url,title));}


              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: Center(child: Text("Go To Side",
                style: bodyText1Style.copyWith(color: Colors.grey),)),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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

                    title: title!=null?
                    Text(title, style: subtitleStyle.copyWith(fontWeight: FontWeight.w900,fontSize: 16)
                    ):Text("", style: TextStyle(color: Colors.black, fontSize: 16)
                    ),
                  )
                ),
              ),
            ]
          ),
          preferredSize: Size(
            double.infinity,
            60.0,
          ),
        ),
        body:SingleChildScrollView(
          child:desc!=null?
          Column
            (
            children: [
              Container(
                    padding: EdgeInsets.only(left: 10,right: 10),
                    width: double.infinity,
                    color: Colors.white70,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: double.infinity,
                          child: Column(
                            children:
                            [
                              SizedBox(
                                height: 20,
                              ),

                              image!=null?
                              Card(
                                elevation: 0.5,
                                shape:RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: BASE_URL + image.toString(),
                                    height: 200,
                                    width: double.infinity,
                                    placeholder: (context, url) =>
                                        Center(child: const CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                  ),
                                ),
                              ):Center(),


                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height:Get.height/2+20,
                                width: double.infinity,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 20,),
                                      title!=null?Text(
                                        title.toString(),
                                        style: bodyText1Style,
                                      ):Center(),

                                      Html(
                                          data:desc.toString(),
                                          style: {
                                            "body": Style(
                                              fontSize: FontSize(12.0),
                                            ),
                                          },
                                          onLinkTap: (String? url, RenderContext context, Map<String,
                                              String> attributes,
                                              element)
                                          async{
                                            await launch(url!);
                                          }
                                      ),


                                    ],
                                  ),
                                ),
                              ),




                              /* Text(
                                data.title.toString(),
                                style: bodyText1Style,
                              ),*/
                             /* Html(
                                data:desc.toString(),
                                style: {
                                  "body": Style(
                                    fontSize: FontSize(12.0),

                                  ),
                                },
*/



                            ],
                          ),
                        ),
                        // ListView.separated(itemBuilder: itemBuilder, separatorBuilder: separatorBuilder, itemCount: itemCount)
                      ],
                    )),


              ],
             ):Center(

         child:  Column
           (
           children: [
             Container(
                 padding: EdgeInsets.only(left: 10,right: 10),
                 width: double.infinity,
                 color: Colors.white70,
                 child: Icon(
                     Icons.error_outline
                 )
             ),


           ],
         ),

          )

        )


    );
  }
}
