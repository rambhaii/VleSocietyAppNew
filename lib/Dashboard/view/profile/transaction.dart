import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vlesociety/Dashboard/view/profile.dart';
import 'package:vlesociety/Dashboard/view/profile/PointRedeem.dart';

import '../../../AppConstant/APIConstant.dart';
import '../../../AppConstant/textStyle.dart';
import '../../../Widget/loading_widget.dart';
import '../../controller/DashboardController.dart';
import 'package:timeago/timeago.dart' as timeago;
class transaction extends StatefulWidget {
  transaction({super.key});

  @override
  State<transaction> createState() => _transactionState();
}

class _transactionState extends State<transaction> {
  DashboardController controller = Get.find();
  int filter=0;

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
                  leading: InkWell(
                    onTap: (){
                      Get.off(Profile());
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: CircleAvatar(radius: 10, backgroundColor: Colors.amber.withOpacity(0.1),
                        backgroundImage: NetworkImage(BASE_URL+controller.image),),
                    ),
                  ),
                  leadingWidth: 60,
                  title:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [ Text(controller.userName.toString(), style: TextStyle(color: Colors.black, fontSize: 16),),
                      Text( controller.points.toString()+" Points", style: TextStyle(color: Colors.green, fontSize: 12),),
                    ],
                  ),
                  elevation: 0.0,
                  actions: [
                    RawMaterialButton(
                      constraints: BoxConstraints(maxHeight: 40, minWidth: 40),
                      onPressed: () {Get.off(()=>Profile());},
                      shape: CircleBorder(
                          side: BorderSide(width: 0.5, color: Colors.black)),
                      child: Image.asset("assets/images/menu.png", height: 15, width: 20, fit: BoxFit.fill,),
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
      body:
      SingleChildScrollView(
        controller: controller.scrollControllerTrasaction,
        child:
     Obx(() => Column(
  children:
  [
    Obx(() => controller.transactionsModel.value.data!=null?
    Column(
      children: [
        Container(
          height: 100.h,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.black26
              )
          ),

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100.h,
                width: 120.w,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Points Earned"),
                      SizedBox(height: 10.h,),
                      InkWell(
                        onTap: (){
                          setState(() {
                            controller.gettransactionHistoryDetails("0");
                            filter=0;
                          });
                        },
                        child: Container(
                          height: 40.h,
                          width: 90.w,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black26
                              )
                          ),
                          child: Center(child: Text(controller.transactionsModel.value.totalPoints.toString(),style: subtitleStyle.copyWith(color: Colors.green,fontSize: 14))),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              VerticalDivider(width: 2,color: Colors.black26,),
              Container(
                height: 100.h,
                width: 120.w,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Points Balanced"),
                      SizedBox(height: 10,),
                      InkWell(
                        onTap: (){
                          setState(()
                          {
                            controller.gettransactionHistoryDetails("1");
                            filter=1;
                          });
                        },
                        child: Container(
                          height: 40.h,
                          width: 90.w,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black26
                              )
                          ),
                          child: Center(child: Text(controller.transactionsModel.value.avlPoint.toString()!=null?controller.transactionsModel.value.avlPoint.toString():"0",style: subtitleStyle.copyWith(color: Colors.green,fontSize: 14))),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              VerticalDivider(width: 2,color: Colors.black26,),
              Container(
                height: 100,
                width: 100.w,
                child: Center
                  (
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Point Redeem"),
                      SizedBox(height: 10.h,),
                      InkWell(
                        onTap: (){
                          setState(()
                          {
                            controller.getRedeemListNetworkApi();
                            filter=2;
                          });
                        },
                        child: Container(
                          height: 40.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black26
                            ),

                          ),
                          child: Center(child: Text(controller.transactionsModel.value.totalRedeem!=null?
                          controller.transactionsModel.value.totalRedeem.toString():"0",
                              style: subtitleStyle.copyWith(color: Colors.green,fontSize: 14))),
                        ),
                      )
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
        filter==0?
        ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.transactionsModel.value.data?.length,
            itemBuilder: (context,index)
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
                          children:
                          [
                            Container(
                              width: 180.h,
                              child: Text(data.title.toString(),style: bodyText1Style.copyWith(fontSize: 17),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis
                              ),
                            ),


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
            }):filter==1?
        ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.transactionsModel.value.data?.length,
            itemBuilder: (context,index)
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
                          children:
                          [
                            Container(
                              width: 180.h,
                              child: Text(data.title.toString(),style: bodyText1Style.copyWith(fontSize: 17),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis
                              ),
                            ),


                            Text(data.addDate.toString(),style: bodyText1Style.copyWith(fontSize: 13,color: Colors.black87)),
                          ],
                        ),
                        Spacer(),
                        Container(
                            padding: EdgeInsets.only(right: 80),
                            height: 40,
                            width: 10,
                            child:data.status.toString()=="1"?Icon(Icons.add,size: 15,color: Colors.green,):Container()
                        ),
                        SizedBox(width: 6,),
                        data.status.toString()=="1"?
                        Text("₹"+data.points.toString(),style: subtitleStyle.copyWith(color: Colors.green,fontSize: 14),)
                            :Text("₹ "+data.points.toString(),style: subtitleStyle.copyWith(color: Colors.red,fontSize: 14),),
                        SizedBox(width: 20,),
                      ],
                    ),
                  ),
                ),
              );
            }) :
        controller.redeemPointsModel.value.data!=null ?
        ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.redeemPointsModel.value.data?.length,
            itemBuilder: (context,index)
            {
              final data = controller.redeemPointsModel.value.data![index];;
              return data.redeemType.toString()=="2"?
              Padding(
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
                            child:Image.asset("assets/images/points.png")) ,
                        SizedBox(width: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            Container(
                              width: 180.h,
                              child: Text(data.branch.toString(),style: bodyText1Style.copyWith(fontSize: 17),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis
                              ),
                            ),
                            Row(
                              children:
                              [
                                Text("status: ",style: bodyText1Style.copyWith(fontSize: 13,color: Colors.black87)),
                                Text(convert(data.status.toString()),style: bodyText1Style.copyWith(fontSize: 11,color: Colors.green)),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Text( timeago.format(
                                DateTime.parse(data.addDate.toString())
                            ),style: bodyText1Style.copyWith(fontSize: 13,color: Colors.black87)),
                          ],
                        ),
                        Spacer(),

                        data.status.toString()=="3"?
                        Container(
                            padding: EdgeInsets.only(right: 80),
                            height: 30,
                            width: 30,
                            child:Icon(Icons.error_outline_outlined,size: 15,color: Colors.red,)
                        )
                            :Text("₹ "+data.amount.toString(),style: subtitleStyle.copyWith(color: Colors.red,fontSize: 14),),

                        SizedBox(width: 20,),
                      ],
                    ),
                  ),
                ),
              ):
              Padding(
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
                            child:Image.asset("assets/images/points.png")) ,
                        SizedBox(width: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            Container(
                              width: 180.h,
                              child: Text(data.upiId.toString(),style: bodyText1Style.copyWith(fontSize: 17),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis
                              ),
                            ),
                            Row(
                              children:
                              [
                                Text("status: ",style: bodyText1Style.copyWith(fontSize: 13,color: Colors.black87)),
                                Text(convert(data.status.toString()),style: bodyText1Style.copyWith(fontSize: 11,color: Colors.green)),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Text( timeago.format(
                                DateTime.parse(data.addDate.toString())
                            ),style: bodyText1Style.copyWith(fontSize: 13,color: Colors.black87)),
                          ],
                        ),
                        Spacer(),
                        data.status.toString()=="3"?
                        Container(
                            padding: EdgeInsets.only(right: 80),
                            height: 30,
                            width: 30,
                            child:Icon(Icons.error_outline_outlined,size: 15,color: Colors.red,)
                        )
                            :Text("₹ "+data.amount.toString(),style: subtitleStyle.copyWith(color: Colors.red,fontSize: 14),)

                        ,


                        SizedBox(width: 20,),
                      ],
                    ),
                  ),
                ),
              );
            }):Center()
      ],
    ):Container()),
    controller.isLoadingTransactionPage.value?const LoadingWidget():Container()
  ],
)),
      )




    );
  }
  String convert(String value)
  {  String data="";
    if(value=="1")
      {
        data="pending";
      }
    else if(value=="2")
      {
        data="completed";
      }
    else if(value=="3")
    {
      data="failed";
    }

    return data;
  }

}