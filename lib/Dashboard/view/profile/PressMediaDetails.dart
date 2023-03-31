import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vlesociety/Dashboard/view/profile.dart';

import '../../../AppConstant/APIConstant.dart';
import '../../../AppConstant/textStyle.dart';
import '../../controller/DashboardController.dart';
import '../GallaryCommunity.dart';
import 'PressMediaGallary.dart';

class PressMediaDetails extends StatelessWidget {
  PressMediaDetails({Key? key}) : super(key: key);
  DashboardController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      color: Color(0xffcdf55a),
                    ),
                  )),
              ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: AppBar(
                    backgroundColor: Colors.white.withOpacity(0.5),
                    leading: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.amber.withOpacity(0.1),
                        backgroundImage:
                            NetworkImage(BASE_URL + controller.image),
                      ),
                    ),
                    leadingWidth: 60,
                    title: Text(
                      controller.userName.toString(),
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    elevation: 0.0,
                    actions: [
                      RawMaterialButton(
                        constraints:
                            BoxConstraints(maxHeight: 40, minWidth: 40),
                        onPressed: () {
                          Get.to(() => Profile());
                          //  controller.logout();
                        },
                        shape: CircleBorder(
                            side: BorderSide(width: 0.5, color: Colors.black)),
                        child: Image.asset(
                          "assets/images/menu.png",
                          height: 15,
                          width: 20,
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
        body: Obx(
          () => controller.pressMediaDetailsModel.value.data != null
              ? Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (controller.pressMediaDetailsModel.value.data!
                            .imageList!.isNotEmpty)
                          controller.pressMediaDetailsModel.value.data!
                                      .imageList!.length >=
                                  3
                              ? Card(
                            elevation: 2,
                                margin: EdgeInsets.only(left: 10,right: 10,top: 5),

                                child: Container(
                                    decoration: BoxDecoration(),
                                    width: double.infinity,
                                    height: 200.h,
                                    child: StaggeredGrid.count(
                                      crossAxisCount: 4,
                                      mainAxisSpacing: 4,
                                      crossAxisSpacing: 4,
                                      children: [
                                        StaggeredGridTile.count(
                                          crossAxisCellCount: 3,
                                          mainAxisCellCount: 3,
                                          child:

                                          CachedNetworkImage(
                                            fit: BoxFit.fill,
                                            imageUrl: BASE_URL +
                                                controller
                                                    .pressMediaDetailsModel
                                                    .value
                                                    .data!
                                                    .imageList![0]
                                                    .image!,
                                            placeholder: (context, url) => Center(
                                                child:
                                                    const CircularProgressIndicator()),
                                            errorWidget: (context, url, error) =>
                                                const Icon(Icons.error),
                                          ),
                                        ),
                                        StaggeredGridTile.count(
                                          crossAxisCellCount: 1,
                                          mainAxisCellCount: 1.2,
                                          child: CachedNetworkImage(
                                            fit: BoxFit.fill,
                                            imageUrl: BASE_URL +
                                                controller
                                                    .pressMediaDetailsModel
                                                    .value
                                                    .data!
                                                    .imageList![1]
                                                    .image!,
                                            placeholder: (context, url) => Center(
                                                child:
                                                    const CircularProgressIndicator()),
                                            errorWidget: (context, url, error) =>
                                                const Icon(Icons.error),
                                          ),
                                        ),
                                        Stack(children:
                                        [
                                          StaggeredGridTile.count(
                                            crossAxisCellCount: 1,
                                            mainAxisCellCount: 1.2,
                                            child: CachedNetworkImage(
                                              fit: BoxFit.fill,
                                              imageUrl: BASE_URL +
                                                  controller
                                                      .pressMediaDetailsModel
                                                      .value
                                                      .data!
                                                      .imageList![2]
                                                      .image!,
                                              placeholder: (context, url) => Center(
                                                  child:
                                                      const CircularProgressIndicator()),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 28.0),
                                            child: Center(
                                                child: TextButton(
                                              onPressed: () {
                                                final data =controller
                                                    .pressMediaDetailsModel
                                                    .value
                                                    .data!
                                                    .imageList;
                                                 Get.to(PressMediaGallary(data));
                                              },
                                              child: Text(
                                                  ((controller
                                                      .pressMediaDetailsModel
                                                                  .value
                                                                  .data!
                                                                  .imageList!
                                                                  .length) -
                                                              2)
                                                          .toString() +
                                                      "+",
                                                  style: TextStyle(
                                                      fontSize: 30.sp,
                                                      fontWeight: FontWeight.w900,
                                                      color: Colors.black)),
                                            )),
                                          )
                                        ]),
                                      ],
                                    )),
                              )
                              : Card(
                                child: Container(
                                    decoration: BoxDecoration(),
                                    height: Get.height / 4,
                                    width: Get.width,
                                    child: InkWell(
                                      onTap: ()
                                      {
                                        final data =controller
                                            .pressMediaDetailsModel
                                            .value
                                            .data!
                                            .imageList;
                                        Get.to(PressMediaGallary(data));
                                        },
                                      child: CachedNetworkImage(
                                        fit: BoxFit.fill,
                                        imageUrl: BASE_URL +
                                            controller.pressMediaDetailsModel
                                                .value.data!.imageList![0].image!,
                                        placeholder: (context, url) => Center(
                                            child:
                                                const CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                              ),
                        Container(
                          width: double.infinity,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Html(
                                    data: controller.pressMediaDetailsModel
                                        .value.data!.description
                                        .toString(),
                                    style: {
                                      "body": Style(
                                        fontSize: FontSize(12.0),
                                      ),
                                    },
                                    onLinkTap: (String? url,
                                        RenderContext context,
                                        Map<String, String> attributes,
                                        element) async {
                                      await launch(url!);
                                    }),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ))
              : Center(
                  child: const CupertinoActivityIndicator(),
                ),
        ));
  }
}
