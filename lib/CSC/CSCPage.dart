import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vlesociety/Dashboard/controller/DashboardController.dart';

import '../../AppConstant/APIConstant.dart';
import '../../AppConstant/textStyle.dart';
import '../Dashboard/model/ArticalModel.dart';

class CSCPage extends StatelessWidget {
  CSCPage({super.key});
  DashboardController controller = Get.find();

  @override
  Widget build(BuildContext context)
  {
    controller.getArticleNetworkApi();
    return Obx(
      () => controller.cscModel.value.data != null
          ? ListView.separated(
            padding: EdgeInsets.all(10),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.cscModel.value.data!.length,
            separatorBuilder: (BuildContext context, int index) => Divider(
              height: 5,
              thickness: 1.6,
              color: Colors.grey.withOpacity(0.2),
            ),
            itemBuilder: (BuildContext context, int index)
            {
              final datas = controller.cscModel.value.data![index];
              return  Padding(
                padding: const EdgeInsets.only(top: 6.0,bottom: 6.0),
                child: InkWell(
                  onTap: (){
                    _showBottomSheet(context, datas);
                  },
                  child: Row(

                    children: [
                      Expanded(child: Text(
                      datas.title.toString(),
                      style: bodyText1Style,overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                    ),),
                      SizedBox(width: 10,),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: BASE_URL + datas.image.toString(),
                          height: 75.h,
                          width: 75.w,
                          placeholder: (context, url) =>
                              Center(child: const CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                        ),
                      )
                    ],
                  ),
                ),
              );
              //   ListTile(
              //   contentPadding: EdgeInsets.all(8),
              //   onTap: () {
              //     _showBottomSheet(context, datas);
              //   },
              //   autofocus: true,
              //   title: Text(
              //     datas.title.toString(),
              //     style: bodyText1Style,
              //   ),
              //   trailing: ,
              // );
            },
          )
          : Center(
              child: CupertinoActivityIndicator(),
            ),
    );
  }
  void _showBottomSheet(BuildContext context, ArticleDatum datum) {
    showModalBottomSheet(
      context: context,
      barrierColor: Colors.black.withOpacity(0.12),
      isScrollControlled: true,
      backgroundColor: Colors.white70,
      builder: (context) {
        return ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
                padding: EdgeInsets.all(10),
                height: Get.height - 90,
                width: double.infinity,
                color: Colors.white70,
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
                        imageUrl: BASE_URL + datum.image.toString(),
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
                      height: Get.height / 2 + 20,
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
                            Html(data: datum.description.toString()),
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
