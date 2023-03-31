import 'package:blinking_text/blinking_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart' show parse;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vlesociety/AppConstant/APIConstant.dart';
import 'package:vlesociety/Dashboard/controller/DashboardController.dart';
import 'package:vlesociety/Dashboard/view/quizeQA/question.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../AppConstant/textStyle.dart';
import '../../UtilsMethod/UtilsMethod.dart';
import 'QuizeDetails.dart';

class QuizPage extends StatelessWidget {
  QuizPage({super.key});
  DashboardController controller = Get.find();
  @override
  Widget build(BuildContext context)
  {
    controller.getQuizNetworkApi();
    controller.getQuizContestNetworkApi();
    controller.getQuizAwardListNetworkApi();

    return
      SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          SizedBox(height: 5,),
          Padding(
            padding: EdgeInsets.only(left: 5,right: 5,bottom: 5),
            child: Container(
              padding: EdgeInsets.only(top: 10,bottom: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  boxShadow: [
                    BoxShadow(
                        color:Colors.grey.withOpacity(0.1),
                        offset: Offset(5,5),
                        blurRadius: 10,
                        spreadRadius: 2
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(0,0),
                      blurRadius: 0,
                      spreadRadius: 0,
                    )
                  ]),
              child: Obx(
                    () => controller.contestQuize.value.data != null
                    ? CarouselSlider(
                  options: CarouselOptions(
                    height: 90,
                    viewportFraction: 1,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),

                  ),
                  items: controller.contestQuize.value.data!.map((i) {
                    var desc = parse(i.description);
                    String parsedString = parse(desc.body!.text).documentElement!.text;
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(

                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(left: 5.0, right: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0,right: 3),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: BASE_URL + i.image.toString(),
                                    height: 84,
                                    width: 100,
                                    placeholder: (context, url) =>
                                        Center(child: const CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12.0,right: 8,top: 5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(i.title.toString(),maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: bodyText1Style),SizedBox(height: 3,),

                                      Text(parsedString
                                        ,maxLines: 3,overflow: TextOverflow.ellipsis,
                                        style: bodyText2Style.copyWith(color: Colors.black.withOpacity(0.6)),),

                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }).toList(),
                )
                    : Container(
                  height: 130.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Obx(() => controller.quizModelContest.value.data != null? Container(
            padding: EdgeInsets.only(left: 1,right: 1),
            width: MediaQuery.of(context).size.width,
            child: Card(
                elevation: 0.0,
                shadowColor: Colors.grey,

                child: Padding(
                  padding: EdgeInsets.only(left: 2,top: 5,bottom: 5,right: 5),
                  child: Text(
                    "Today's Contest",
                    style: titleStyle.copyWith(color: Colors.black.withOpacity(0.6),
                        fontSize: 15,fontWeight: FontWeight.w600),),
                )
            ),
          ):Center(),),


          SizedBox(height: 4,),
          Container(

              child:Obx(() => controller.quizModelContest.value.data != null
                  ? ListView.builder(
                  shrinkWrap: true,
                  itemCount:controller.quizModelContest.value.data!.length,
                  physics: ScrollPhysics(),
                  itemBuilder: (context,index)
                  {
                    final datass = controller.quizModelContest.value.data![index];
                    var desc = parse(datass.description);
                    String parsedString = parse(desc.body!.text).documentElement!.text;
                    return InkWell(
                      onTap: () {Get.to(QuizeDetails(datass));},
                      child: Container(  height: 85.h ,
                        margin: EdgeInsets.only(top: 2.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0,right: 3),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: BASE_URL + datass.image.toString(),
                                  height: 76,
                                  width: 76,
                                  placeholder: (context, url) =>
                                      Center(child: const CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12.0,right: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(datass.title.toString(),maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: bodyText1Style),SizedBox(height: 3,),
                                    // Html(data: datass.description.toString()),
                                    Text(parsedString
                                      ,maxLines: 2,overflow: TextOverflow.ellipsis,
                                      style: bodyText2Style.copyWith(color: Colors.black.withOpacity(0.6)),),
                                    Flexible(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex:2,
                                            child: Text(timeago.format(DateTime.parse
                                              (controller.quizModelContest.value.data!
                                            [index].addDate.toString())),
                                              style: smallTextStyle.copyWith(color: Colors.grey),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(datass.totalPoints.toString()+" Points",
                                              style: smallTextStyle.copyWith(color: Colors.blue),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                          ),Spacer(),
                                          Expanded(
                                            flex: 3,
                                            child: TextButton(onPressed: ()
                                            {
                                            if (controller.userType == "Guest")
                                            {
                                            UtilsMethod.PopupBox(context, "Attempt quiz");
                                            } else {
                                              Get.to(() =>
                                                  question(quizeId: controller
                                                      .quizModelContest.value
                                                      .data!
                                                  [index].id.toString(),),
                                                  fullscreenDialog: true,
                                                  transition: Transition
                                                      .rightToLeft);
                                            }  }, child:
                                            Text("ATTEMPT",style:bodyText2Style.copyWith(color: Colors.blue),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }):Container())

          ),
        //  Divider( height: 5, thickness: 1.6, color: Colors.grey.withOpacity(0.4),),
         // SizedBox(height: 4,),
          Obx(() => controller.quizModel.value.data != null? Container(
            padding: EdgeInsets.only(left: 1,right: 1),
            width: MediaQuery.of(context).size.width,
            child: Card(
                elevation: 0.0,
                shadowColor: Colors.grey,

                child: Padding(
                  padding: EdgeInsets.only(left: 2,top: 5,bottom: 5,right: 5),
                  child: Text(
                    "Quizzes",
                    style: titleStyle.copyWith(color: Colors.black.withOpacity(0.6),
                        fontSize: 15,fontWeight: FontWeight.w600),),
                )
            ),
          ):Center(),),
          Obx(() => controller.quizModel.value.data != null
              ? Container(
              child: ListView.builder(
                  controller: controller.scrollController,
                  shrinkWrap: true,
                  itemCount:controller.quizModel.value.data!.length,
                  physics: ScrollPhysics(),
                  itemBuilder: (context,index)
                  {
                    final datass = controller.quizModel.value.data![index];
                    var desc = parse(datass.description);
                    String parsedString = parse(desc.body!.text).documentElement!.text;

                    return InkWell(
                      onTap: (){
                        Get.to(QuizeDetails(datass));
                      },
                      child: Container(
                        height: 96.h ,
                        margin: EdgeInsets.only(top: 2.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(left: 8.0.w,right: 3.w),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: BASE_URL + datass.image.toString(),
                                  height: 76.h,
                                  width: 76.w,
                                  placeholder: (context, url) =>
                                      Center(child: const CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding:  EdgeInsets.only(left: 12.0.w,right: 8.w,top: 8.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(datass.title.toString(),maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: bodyText1Style),SizedBox(height: 3.h,),
                                    // Html(data: datass.description.toString()),
                                    Text(parsedString
                                      ,maxLines: 2,overflow: TextOverflow.ellipsis,
                                      style: bodyText2Style.copyWith(color: Colors.black.withOpacity(0.6)),),
                                    Flexible(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex:2,
                                            child: Text(timeago.format(DateTime.parse
                                              (controller.quizModel.value.data!
                                            [index].addDate.toString())),
                                              style: smallTextStyle.copyWith(color: Colors.grey),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                          ),

                                          Expanded(
                                            flex: 2,
                                            child: Text(datass.totalPoints.toString()+" Points",
                                              style: smallTextStyle.copyWith(color: Colors.blue),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                          ),Spacer(),
                                          Expanded(
                                            flex: 3,
                                            child: TextButton(onPressed: (){
                                              Get.to(()=>question(quizeId: controller.quizModel.value.data!
                                              [index].id.toString(),),fullscreenDialog: true,transition:Transition.rightToLeft);
                                            }, child:
                                            Text("ATTEMPT",style:bodyText2Style.copyWith(color: Colors.blue),
                                              maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
          ):Container())

        ],
      ),
    );

  }
}
