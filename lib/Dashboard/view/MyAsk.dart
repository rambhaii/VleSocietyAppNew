import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vlesociety/Dashboard/controller/DashboardController.dart';
import '../../AppConstant/textStyle.dart';

class MyAsk extends StatelessWidget {
  MyAsk({super.key});
  DashboardController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: controller.myAskModel.value.data != null
            ? List.generate(
                controller.myAskModel.value.data!.length,
                (index) {
                  final data = controller.myAskModel.value.data![index];

                  return Container(
                    margin: EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.withOpacity(0.3)),
                    child: ListTile(
                      title: ReadMoreText(
                        data.description.toString(),
                        trimLines: 3,
                        colorClickableText: Colors.pink,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: '  Show less',
                        moreStyle: smallTextStyle,
                        lessStyle: smallTextStyle,
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("${data.ttlAnswer} answer",
                              style:
                                  smallTextStyle.copyWith(color: Colors.blue)),
                          SizedBox(
                            width: 12,
                          ),
                          Text("${data.ttlView}  view",
                              style:
                                  smallTextStyle.copyWith(color: Colors.blue)),
                        ],
                      ),
                    ),
                  );
                },
              )
            : [
                Center(
                  child: CupertinoActivityIndicator(),
                )
              ],
      ),
    );
  }
}
