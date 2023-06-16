import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vlesociety/AppConstant/APIConstant.dart';
import 'package:vlesociety/Dashboard/controller/DashboardController.dart';
import 'package:vlesociety/Dashboard/view/dashboard.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../AppConstant/AppConstant.dart';
import '../../AppConstant/textStyle.dart';
import '../../Widget/loading_widget.dart';
import '../controller/NotificationController.dart';
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
  NotificationController controllerNotification = Get.put(NotificationController());
  @override
  void initState() {
    // TODO: implement initState
    controllerNotification.getNotificationListNetworkApi();
    super.initState();
  }
  @override
  Widget build(BuildContext context)
  {
    controllerNotification.getNotificationListNetworkApi();
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
                      backgroundImage: NetworkImage(BASE_URL+GetStorage()
                          .read(AppConstant.profileImg)
                          .toString()),
                    ),
                  ),
                  leadingWidth: 60,
                  title:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.userName.toString(),
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      Text(
                        controller.points.toString()+" Points",
                        style: smallTextStyle.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 11,
                            color: Colors.green),
                      ),
                    ],
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
        controller: controllerNotification.scrollController1,
        child:
    Obx(
    () =>
      Column(
          children:
          [
                 Obx(() =>controllerNotification.notificationModel.value.data!=null? ListView.builder(
                     itemCount:controllerNotification.notificationModel.value.data!.length ,
                     physics: ScrollPhysics(),
                     shrinkWrap: true,
                     itemBuilder: (context,index)
                     {
                       final data=controllerNotification.notificationModel.value.data![index];
                   /*  for(int i=0;i<=index;i++)
                     {
                       if(controllerNotification.notificationModel.value.data![i].isSeen==false)
                       {
                        // AppConstant.countNotification=AppConstant.countNotification+i;
                       }
                     }*/
                       String result=data.title.toString();
                       print("object"+result);
                       result = result.substring(0, 1);
                       return Container(
                         height:60.h,
                         decoration: BoxDecoration(
                         ),
                         child: InkWell(
                           onTap: ()
                           {
                             /*controllerNotification.notificationModel.value.data![index].isSeen==true;
                             controllerNotification.notificationModel.refresh();*/
                             if(int.parse(data.type.toString())<=3)
                             {
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
                                   decoration: BoxDecoration(
                                       shape: BoxShape.circle,
                                       color: Colors.primaries[Random().nextInt(Colors.primaries.length)].withOpacity(0.1)
                                   ),
                                   child: Center(child: Text(result.toString(),style: heading3.copyWith(
                                       fontSize: 20,
                                       fontWeight: FontWeight.w500
                                       ,  color:Colors.primaries[Random().nextInt(Colors.primaries.length)] ) ,)),

                                   /*  CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl:"${result}",
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
                          ) ,*/
                                 ),
                                 SizedBox(width: 8.w,),
                                 Expanded(
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: [
                                       Text(data.title.toString(),style:smallTextStyle ,maxLines: 2,overflow: TextOverflow.ellipsis,),

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
                     }):Container()
                   ,),
            controllerNotification.isLoadingNotificationPage.value?const LoadingWidget():Container(),
          ],
        ),
      ),
      )
    );
  }
}
