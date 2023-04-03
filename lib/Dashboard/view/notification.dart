import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vlesociety/AppConstant/APIConstant.dart';
import 'package:vlesociety/Dashboard/controller/DashboardController.dart';
import 'package:vlesociety/Dashboard/view/dashboard.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../AppConstant/textStyle.dart';
import 'CommunityDetails.dart';
import 'profile.dart';
class notification extends StatefulWidget {
  const notification({Key? key}) : super(key: key);

  @override
  State<notification> createState() => _notificationState();
}

class _notificationState extends State<notification>
{
  DashboardController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.amber.withOpacity(0.1),
                      backgroundImage: NetworkImage(BASE_URL+controller.image),
                    ),
                  ),
                  leadingWidth: 60,
                  title: Text(controller.userName.toString(), style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  elevation: 0.0,
                  actions: [
                    RawMaterialButton(
                      constraints: BoxConstraints(maxHeight: 40, minWidth: 40),
                      onPressed: () {
                        Get.to(()=>Profile());
                        //  controller.logout();
                      },
                      shape: CircleBorder(
                          side: BorderSide(width: 0.5, color: Colors.black)),
                      child: Image.asset("assets/images/menu.png",
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                    itemCount:controller.notificationModel.value.data!.length ,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                      final data=controller.notificationModel.value.data![index];
              return Container(
                height:60.h,
                decoration: BoxDecoration(
                ),
                child: InkWell(
                  onTap: ()
                  {
                    if(data.type.toString()=="1")
                      {
                        print("76sndfbdsbf"+data.typeId.toString());
                        Get.to(()=>CommunityDetails(cid:data.typeId.toString() ,));
                      }
                    },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8,right: 10),
                    child: Row(
                      children: [
                        Container(
                          height: 50.h,
                          width: 50.w,

                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl:"https://image.shutterstock.com/image-photo/"
                                "mountains-under-mist-morning-amazing-260nw-1725825019.jpg",
                            imageBuilder: (context, imageProvider) => Container(
                              height: 50.h,
                              width: 50.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              )),
                            placeholder: (context, url) => Center(
                                child:
                                const CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                          ) ,
                        ),
                        SizedBox(width: 8.w,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(data.title.toString(),style: TextStyle(),maxLines: 2,overflow: TextOverflow.ellipsis,),

                            ],
                          ),
                        ),
                       Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          // mainAxisAlignment: MainAxisAlignment.end,
                          children:
                          [
                            Text( timeago.format(DateTime.parse(
                                data.addDate.toString()))
                              ,
                              style: smallTextStyle.copyWith(fontWeight: FontWeight.w500,fontSize: 10,
                                  color: Colors.black.withOpacity(0.5)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
