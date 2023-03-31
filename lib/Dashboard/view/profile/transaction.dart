import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vlesociety/Dashboard/view/profile.dart';

import '../../../AppConstant/APIConstant.dart';
import '../../../AppConstant/textStyle.dart';
import '../../controller/DashboardController.dart';
class transaction extends StatelessWidget {
  transaction({super.key});

  DashboardController controller = Get.find();
  @override
  Widget build(BuildContext context)
  {
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
                  title:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      Text(controller.userName.toString(), style: TextStyle(color: Colors.black, fontSize: 16),),
                      Text(controller.transactionsModel.value.totalPoints.toString()+"+  Earn points", style: TextStyle(color: Colors.green, fontSize: 12),),

                    ],
                  ),


                  elevation: 0.0,
                  actions: [

                    RawMaterialButton(
                      constraints: BoxConstraints(maxHeight: 40, minWidth: 40),
                      onPressed: () {
                        Get.to(()=>Profile());

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
      body:Obx(() => controller.transactionsModel.value.data!=null?
      ListView.builder(itemCount: controller.transactionsModel.value.data?.length, itemBuilder: (context,index)
      {
        final data = controller.transactionsModel.value.data![index];;
        return Padding(
          padding: const EdgeInsets.only(left: 8.0,right: 8),
          child: Container(
            height:60.h,
            decoration: BoxDecoration(
            ),
            child: InkWell(
              onTap: (){
              },
              child: Row(
                children: [
                  Container(
                      height: 40,
                      width: 40,
                      child:Image.asset("assets/images/points.png")
                  ) ,

                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(data.title.toString(),style: bodyText1Style.copyWith(fontSize: 17),),
                      Text(data.addDate.toString(),style: bodyText1Style.copyWith(fontSize: 13,color: Colors.black87)),
                    ],
                  ),
                  Spacer(),
                  Container(
                      padding: EdgeInsets.only(right: 80),
                      height: 40,
                      width: 10,
                      child:data.status.toString()=="1"?Icon(Icons.add,size: 15,color: Colors.green,):Container()),
                  SizedBox(width: 6,),
                  data.status.toString()=="1"?
                  Text("₹"+data.points.toString(),style: subtitleStyle.copyWith(color: Colors.green,fontSize: 14),)
                      :Text("₹"+data.points.toString(),style: subtitleStyle.copyWith(color: Colors.red,fontSize: 14),),
                  SizedBox(width: 20,),
                ],
              ),
            ),
          ),
        );
      }):Container())




    );
  }
}