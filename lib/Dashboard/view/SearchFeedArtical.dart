import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../AppConstant/APIConstant.dart';
import '../../AppConstant/textStyle.dart';
import '../controller/DashboardController.dart';
import '../model/ArticalModel.dart';
import '../model/FeedArticalModel.dart';

class FeedArticalSearch extends StatefulWidget {
   FeedArticalSearch({Key? key}) : super(key: key);

  @override
  State<FeedArticalSearch> createState() => _FeedArticalSearchState();
}

class _FeedArticalSearchState extends State<FeedArticalSearch> {
  late String keyMessage;

  DashboardController controller = Get.find();
  FocusNode inputNode = FocusNode();

  void openKeyboard()
  {
    FocusScope.of(context).requestFocus(inputNode);

  }

  @override
  Widget build(BuildContext context)
  {
    controller.getFeedArticalNetworkApi("");
    return Scaffold
      (
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
                  leading: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: CircleAvatar(radius: 10, backgroundColor: Colors.amber.withOpacity(0.1), backgroundImage: NetworkImage(BASE_URL+controller.image),),
                  ),
                  leadingWidth: 60,
                  title:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [ Text(controller.userName.toString(), style: TextStyle(color: Colors.black, fontSize: 16),),
                    ],
                  ),
                  elevation: 0.0,
                  actions: [
                    RawMaterialButton(
                      constraints: BoxConstraints(maxHeight: 40, minWidth: 40),
                      onPressed: ()
                      {
                        Navigator.pop(context, true);
                      },

                      shape: CircleBorder(

                      ),
                      child: Image.asset(
                        "assets/images/back.png",
                        height: 40,
                        width: 40,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    )

                  ],
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
          child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>
                    [
                      SizedBox(height: 5),
                      Container(
                        height: 50.h,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              onChanged: (value) {
                                keyMessage = value;
                              },
                              focusNode: inputNode,
                               autofocus:true,
                              decoration: InputDecoration(
                                  labelText: "Search By Artical",
                                  labelStyle: TextStyle(
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,

                                  ),


                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  hintText: "Search By Artical",
                                  hintStyle: TextStyle(
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                  suffixIcon: InkWell(
                                      onTap: () {
                                        if (keyMessage.isNotEmpty)
                                        {
                                          controller.getFeedArticalNetworkApi(keyMessage.toString());
                                          controller.feedArticalModel.value.data!.clear();
                                          controller.feedArticalModel.refresh();
                                        }
                                      },
                                      child: Icon(
                                        Icons.search,
                                        size: 30,
                                      )),
                                  border: OutlineInputBorder(
                                    /*  borderRadius: BorderRadius.all(Radius.circular(5.0)),*/
                                      borderSide: BorderSide(color: Colors.grey),
                                  )
                              ),
                            )),
                      ),
                      Container(
                        child: Obx(() => controller
                            .feedArticalModel.value.data !=
                            null
                            ? ListView.separated(
                          padding: EdgeInsets.all(15),
                          shrinkWrap: true,
                          reverse: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller
                              .feedArticalModel.value.data!.length,
                          separatorBuilder:
                              (BuildContext context, int index) =>
                              Divider(
                                height: 15,
                                thickness: 1.9,
                                color: Colors.grey.withOpacity(0.2),
                              ),
                          itemBuilder:
                              (BuildContext context, int index)
                          {
                            final datas = controller
                                .feedArticalModel
                                .value
                                .data![index];
                            print("" + datas.url.toString());
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: 6.0, bottom: 6.0),
                              child: InkWell(
                                onTap: () {
                                  _showBottomSheetFeedArtcal(
                                      context, datas);
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        datas.title.toString(),
                                        style: bodyText1Style,
                                        overflow:
                                        TextOverflow.ellipsis,
                                        maxLines: 3,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl:
                                        datas.url.toString(),
                                        height: 75,
                                        width: 75,
                                        placeholder: (context,
                                            url) =>
                                            Center(
                                                child:
                                                const CircularProgressIndicator()),
                                        errorWidget: (context, url,
                                            error) =>
                                        const Icon(Icons.error),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                            : Container()),
                        ),

                    ])),
        ),
        );
  }

  void _showBottomSheetFeedArtcal(BuildContext context, Datum1 datum)
  {
    String value= datum.description.toString();
    String result = value.replaceAll("[fusion_button", "");
    String result1 = result.replaceAll("/]", "");
    print("sdfh"+value);
    showModalBottomSheet(
      context: context,
      barrierColor: Colors.black.withOpacity(0.12),
      isScrollControlled: true,
      backgroundColor: Colors.white70,
      builder: (context) {
        return
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                  padding: EdgeInsets.only(right: 10,top: 10,left: 10),

                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 40,
                        height: 6,
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.5, color: Colors.black26),
                            borderRadius: BorderRadius.circular(10)),
                      ),

                      SizedBox(
                        height: 20,
                      ),

                        ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          //imageUrl: BASE_URL + datum.image.toString(),
                          imageUrl: datum.url.toString(),
                          height: 200,
                          width: double.infinity,
                          placeholder: (context, url) =>
                              Center(child: const CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height:Get.height/1.5,
                        width: double.infinity,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text(
                                datum.title.toString(),
                                style: bodyText1Style,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Divider(
                                height: 3,
                                thickness: 2,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Html(
                                  data: result1.toString(),
                                  onLinkTap:
                                      (String? url, Map<String,
                                      String> attributes,
                                      element)
                                  async
                                  {
                                    await launch(url!);
                                  }),


                            ],
                          ),
                        ),
                      ),

                      // ListView.separated(itemBuilder: itemBuilder, separatorBuilder: separatorBuilder, itemCount: itemCount)
                    ],
                  )),
            ),
          );
      },
    );
  }
}
