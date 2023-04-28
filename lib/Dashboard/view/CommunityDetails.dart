import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vlesociety/AppConstant/AppConstant.dart';
import 'package:vlesociety/Dashboard/view/profile/testimonials.dart';

import '../../AppConstant/APIConstant.dart';
import '../../AppConstant/textStyle.dart';
import '../../Widget/CustomAppBarWidget.dart';
import '../controller/CommunityDetails.dart';
import '../controller/DashboardController.dart';
import 'GallaryCommunity.dart';

class CommunityDetails extends StatefulWidget {
  final String cid;
  const CommunityDetails({Key? key, required this.cid}) : super(key: key);

  @override
  State<CommunityDetails> createState() => _CommunityDetailsState();
}

class _CommunityDetailsState extends State<CommunityDetails>
{
  late  CommunityDetailsController controller;
  DashboardController controller1 = Get.put(DashboardController());
  @override
  void initState() {
    controller=Get.put(CommunityDetailsController(cid: widget.cid));
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context){
    int count;
    return  Scaffold(
      appBar: PreferredSize(
        child: Stack(
          children: [
            Positioned(
                top: -80.h,
                right: 60.w,
                child: Container(
                  height: 150.h,
                  width: 150.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffcdf55a),
                  ),
                )),
            ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: AppBar(
                  backgroundColor: Colors.white.withOpacity(0.5),
                  leading: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.amber.withOpacity(0.1),
                      backgroundImage:
                      NetworkImage(BASE_URL + controller1.image),
                    ),
                  ),
                  leadingWidth: 60,
                  title:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller1.userName.toString(),
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      Text(
                        controller1.points.toString()+" Points",
                        style: smallTextStyle.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 11,
                            color: Colors.green),
                      ),
                    ],
                  )
                  ,

                  elevation: 0.0,

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
    /*  PreferredSize(
          preferredSize: Size(
            double.infinity,
            60.0,
          ),
          child: CustomAppBar(title: GetStorage().read(AppConstant.userName),
              image:BASE_URL+GetStorage().read(AppConstant.profileImg))
      ),*/

          body:Obx(()=> controller.communityModel.value.data!=null?Container
            (
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children:
              [

                if (controller.communityModel.value.data!.imageList!.isNotEmpty)

                  controller.communityModel.value.data!.imageList!.length>=3?
                     Container(
                         decoration: BoxDecoration(),
                      width: double.infinity,
                      height: 200,
                      child:
                      StaggeredGrid.count(crossAxisCount: 4,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        children: [
                          StaggeredGridTile.count(
                              crossAxisCellCount: 3,
                              mainAxisCellCount: 3,
                              child: CachedNetworkImage(

                                fit: BoxFit.fill,
                                imageUrl: BASE_URL +controller.communityModel.value.data!.imageList![0].image!,
                                placeholder: (context, url) =>Center(child: const CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                              ),
                          ),
                          StaggeredGridTile.count(
                              crossAxisCellCount: 1,
                              mainAxisCellCount: 1.2,
                              child:  CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl: BASE_URL +controller.communityModel.value.data!.imageList![1].image!,
                                placeholder: (context, url) =>Center(child: const CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                              ),
                          ),
                          Stack(
                              children:[
                                StaggeredGridTile.count(
                                  crossAxisCellCount: 1,
                                  mainAxisCellCount: 1.2,
                                  child:
                                  CachedNetworkImage
                                    (
                                    fit: BoxFit.fill,
                                    imageUrl: BASE_URL +controller.communityModel.value.data!.imageList![2].image!,
                                    placeholder: (context, url) =>Center(child: const CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                    ),
                                   )
                                ,Padding(
                                  padding: const EdgeInsets.only(top: 28.0),
                                  child: Center(child: TextButton(onPressed: ()
                                      {final data= controller.communityModel.value.data!;
                                           Get.to(GalleryPage(cid:data.id.toString(),));
                                       },
                                    child:
                                    Text(
                                        ((controller.communityModel.value.data!.imageList!.length)-2).toString()+"+"
                                        ,style: TextStyle(fontSize: 30,fontWeight: FontWeight.w900,
                                    color: Colors.black)
                                    )
                                    ,)
                                  ),
                                )]
                          ),],)

                  ):
      Container(
        decoration: BoxDecoration(),
        height: 170,
        width: Get.width,
        child:InkWell(
          onTap: (){
            final data= controller.communityModel.value.data!;
            Get.to(GalleryPage(cid:data.id.toString(),));
          },
          child: Container(
            child:
            CachedNetworkImage
              (
              fit: BoxFit.fill,
              imageUrl: BASE_URL + controller.communityModel.value.data!.imageList![0].image.toString(),
              placeholder: (context, url) =>Center(child: const CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
              const Icon(Icons.error),
            ),
          ),
        ),

      ),



                const SizedBox(
                  height: 10,
                ),
                Container(
                  height:Get.height/2+20,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.communityModel.value.data!.postCategory.toString(),
                          style: bodyText1Style,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              controller.communityModel.value.data!.addDate.toString().split(" ").first,
                              style: smallTextStyle,
                            ), Text("By "+
                                controller.communityModel.value.data!.addBy.toString(),
                              style: bodyText1Style.copyWith(color: Colors.deepPurple),
                            ),
                          ],
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
                            data:controller.communityModel.value.data!.description.toString(),
                            style: {
                              "body": Style(
                                fontSize: FontSize(12.0),
                              ),
                              "body ol li, body ul li": Style(
                                fontSize: FontSize(10.0),
                              ),

                            },
                            onLinkTap: (String? url, RenderContext context, Map<String,
                                String> attributes,
                                element)
                            async{
                              await launch(url!);
                            }
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                      ],
                    ),
                  ),
                ),

                // ListView.separated(itemBuilder: itemBuilder, separatorBuilder: separatorBuilder, itemCount: itemCount)
              ],
            ),
          )):Center(
        child: const CupertinoActivityIndicator(),
      ),
      ),
    );
  }
  imageContainer(imgPath){
    return Image.asset(imgPath,fit: BoxFit.fill,);
  }
}