import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../Ads/AdHelper.dart';
import '../../../AppConstant/APIConstant.dart';
import '../../../AppConstant/textStyle.dart';
import '../../../UtilsMethod/UtilsMethod.dart';
import '../../../Widget/EditTextWidget.dart';
import '../../controller/DashboardController.dart';
import '../../model/BankModel.dart';
import '../Community.dart';
import '../MyAsk.dart';
import '../dashboard.dart';
import '../profile.dart';
import 'package:timeago/timeago.dart' as timeago;

class PointTable extends StatefulWidget
{
  const PointTable({Key? key}) : super(key: key);

  @override
  State<PointTable> createState() => _PointTableState();
}

class _PointTableState extends State<PointTable> with TickerProviderStateMixin
{
  DashboardController controller = Get.find();
  late TabController tabController,tabController1;
  AnimationController? _controller;
  Animation<double>? _animation;
  @override
  void initState()
  {
    super.initState();
    controller.getBankListNetworkApi();
    controller.getPointsMaster_listNetworkApi();
    tabController1 = TabController(length: 2, vsync: this);
    tabController = TabController(length: 2, vsync: this);

    _controller = AnimationController(
        duration: const Duration(seconds: 1),
        vsync: this,
        value: 0,
        lowerBound: 0,
        upperBound: 1);
    _animation =
        CurvedAnimation(parent: _controller!, curve: Curves.fastOutSlowIn);
    _controller!.forward();

  }
  Widget getAd()
  {
    BannerAdListener bannerAdListener=BannerAdListener(onAdWillDismissScreen: (ad)
    {
      ad.dispose();
    },onAdClicked: (ad){
      print("Ad got closed");
    });
    BannerAd bannerAd=BannerAd(
        size:  AdSize.banner,
        adUnitId: AdHelper.bannerAdUnitId,
        request:  const AdRequest(),

        listener: BannerAdListener(
          // Called when an ad is successfully received.
          onAdLoaded: (ad)
          {
            debugPrint('$ad loaded.');

          },
          // Called when an ad request failed.
          onAdFailedToLoad: (ad, err)
          {
            debugPrint('BannerAd failed to load: $err');
            // Dispose the ad here to free resources.
            ad.dispose();
          },

          onAdOpened: (Ad ad) {},
          // Called when an ad removes an overlay that covers the screen.
          onAdClosed: (Ad ad) {

          },
          // Called when an impression occurs on the ad.
          onAdImpression: (Ad ad) {},

        )
    );

    bannerAd.load();
    return SizedBox(
      height: 100,

      child: AdWidget(ad: bannerAd),

    );
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      bottomNavigationBar: getAd(),
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
        child: Column(
          children: [
            Container(

              height: 35,
              child: TabBar(
                  onTap: (value)
                  {
                    controller.selectedTabRedeemIndex.value = value;
                    if (value == 1)
                    {
                      controller.getAskApi();
                    }
                  },

                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.black.withOpacity(0.56),
                  isScrollable: true,
                  controller: tabController1,
                  labelStyle: heading3.copyWith(fontSize: 16),
                  unselectedLabelStyle: heading3.copyWith(fontSize: 16),
                  indicatorPadding: EdgeInsets.all(10),
                  indicatorColor: Colors.transparent,

                  padding: EdgeInsets.zero,
                  tabs: [
                    const Tab(
                      child: Text("Earn Points"),
                    ),
                    const Tab(
                      child: Text("Redeem Points"),
                    ),
                  ]),
            ),
            Obx(
                  () => Container(
                child: controller.selectedTabRedeemIndex.value == 0
                    ? FadeTransition(opacity: _animation!, child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(

                        child:



                                  Obx(() =>controller.pointsModelDetails.value.data!=null?
                                  ListView.builder(
                                      itemCount:controller.pointsModelDetails.value.data!.length ,
                                      physics: ScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context,index)
                                      {
                                        final data=controller.pointsModelDetails.value.data![index];
                                        return Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Card(
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                             // height:80.h,
                                              decoration: BoxDecoration(
                                              ),
                                              child: InkWell(
                                                onTap: ()
                                                {

                                                  print(index.toString());
                                                  if(index.toString()=="0")
                                                    {
                                                      print("djkhfhj");
                                                      controller.getReferalPointsDetailNetworkApi();
                                                    }
                                                  else if(index.toString()=="1")
                                                    {
                                                      Get.off(HomeDashboard());
                                                    }
                                                  else if(index.toString()=="2")
                                                  {
                                                    Get.off(HomeDashboard());
                                                  }
                                                  else if(index.toString()=="3")
                                                  {
                                                    Get.off(HomeDashboard());
                                                  }
                                                  else if(index.toString()=="4")
                                                  {

                                                  }
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 8,right: 10),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: 60.h,
                                                        width: 60.w,
                                                        decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            color: Colors.primaries[Random().nextInt(Colors.primaries.length)].withOpacity(0.02)
                                                        ),
                                                        child: Center(child:
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children:
                                                          [
                                                            Text(data.points.toString()+"",
                                                              style: heading3.copyWith
                                                              (
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w200) ,
                                                            ),
                                                            Text("Points",
                                                              style: heading3.copyWith
                                                                (
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.w200) ,
                                                            ),


                                                          ],
                                                        )
                                                        ),


                                                      ),
                                                      SizedBox(width: 20.w,),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children:
                                                          [
                                                             Row(
                                                              children:
                                                              [
                                                                Container(
                                                                  height: 30.h,
                                                                  width: 30.w,
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: Colors.primaries[Random().nextInt(Colors.primaries.length)].withOpacity(0.1)
                                                                  ),
                                                                  child: Center(child: Image(
                                                                    image: NetworkImage(BASE_URL+data.icon.toString()),
                                                                  )
                                                                  ),

                                                                ),
                                                                Text("  "+data.title.toString(),style:smallTextStyle.copyWith(fontWeight: FontWeight.w900) ,maxLines: 1,overflow: TextOverflow.ellipsis,),
                                                              ],
                                                            ),
                                                            Text(data.description.toString(),style:smallTextStyle.copyWith(fontSize: 14) ,maxLines: 2,overflow: TextOverflow.ellipsis,),



                                                          ],
                                                        ),
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      })
                                      :Container()
                                    ,),




                      ),
                    ))
                    : controller.selectedTabRedeemIndex.value == 1
                    ?   SingleChildScrollView(
          child:
          Padding(
            padding: const EdgeInsets.only(left: 10.0,right: 10,top: 30),
            child:
            Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  Container(
                    height: 150.h,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Colors.grey)
                    ),

                    child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:
                      [
                        Container(
                          color: Colors.orangeAccent.withOpacity(0.1),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 8.0),
                            child: Row(
                              children:
                              [
                                Column(
                                  crossAxisAlignment:CrossAxisAlignment.start,
                                  children:
                                  [
                                    Text(controller.transactionsModel.value.avlPoint.toString()!=null?"₹ "+controller.transactionsModel.value.avlPoint.toString():"₹ 0",style: heading3.copyWith(fontSize: 18,fontWeight: FontWeight.w200, ),),
                                    SizedBox(height: 5,),
                                    Text("Withdrawable Balance",style:subtitleStyle ,)
                                  ],
                                ),
                                Spacer(),
                                //Text("History",style:subtitleStyle.copyWith(color: Colors.green))

                              ],
                            ),
                          ),
                        ),
                        Divider(height: 0.8,color: Colors.grey,thickness: 1,),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column
                            (
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                            [
                              Row(
                                children:
                                [
                                  Text("₹",style: titleStyle,),
                                  Container(
                                    width: 200.w,
                                    child: Column(
                                      children: [
                                        EditTextWidgetAmount(
                                          controller: controller.etAmount,
                                          hint: 'Enter Amount to withdraw',
                                          type: TextInputType.number,
                                          validator: (value)
                                          {
                                            if(value.toString().isEmpty)
                                            {
                                              return "Please Enter Amount to withdraw";
                                            }
                                            if(int.parse(value.toString())<=9999)
                                            {

                                              return "Your amount less then 1000";
                                            }

                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  int.parse(controller.transactionsModel.value.avlPoint.toString())>=1000?
                                  InkWell(
                                    onTap: ()
                                    async {  print("dsjdfgh  "+controller.selectedComunityIndex.value.toString());
                                    if(controller.selectedComunityIndex.value.toString() == "0")
                                    {
                                      if(controller.formKey.currentState!.validate())
                                      {
                                        bool? status=await controller.postRedeemNetworkApi("1");
                                        if(status)
                                        {
                                          controller.etAmount.clear();
                                          controller.etupiId.clear();
                                          controller.getgetUserDetailsNetworkApi();


                                        }
                                      }
                                    }
                                    else if(controller.selectedComunityIndex.value.toString() == "1")
                                    {
                                      if(controller.formKey.currentState!.validate())
                                      {
                                        bool? status=await  controller.postRedeemNetworkApi("2");
                                        if(status)
                                        {
                                          controller.getgetUserDetailsNetworkApi();
                                          controller.etAmount.clear();
                                          controller.etSignature.clear();
                                          controller.etAccountNumber.clear();
                                          controller.etBranchName.clear();
                                          controller.etIFSCECODE.clear();
                                          controller.etAddress.clear();
                                          controller.etIFSCECODE.clear();

                                        }
                                      }
                                    }


                                    },
                                    child:
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10.0),
                                      child: Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(5)),
                                              border: Border.all(color: Colors.grey)
                                          ),
                                          child: Text("Withdraw",style:subtitleStyle.copyWith(fontSize: 20,color: Colors.orangeAccent.withOpacity(0.6)),)),
                                    ),
                                  )
                                      : InkWell(
                                    onTap: ()
                                    async {



                                    },
                                    child:
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10.0),
                                      child: Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(5)),
                                              border: Border.all(color: Colors.grey)
                                          ),
                                          child: Text("Withdraw",style:subtitleStyle.copyWith(fontSize: 20,color: Colors.grey.withOpacity(0.6)),)),
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Withdrawal amount greater then 1000 ",style: subtitleStyle.copyWith(fontSize: 14),),
                              )
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 35,
                    child: TabBar(
                        onTap: (value)
                        {
                          controller.selectedComunityIndex.value = value;
                          if (value == 1)
                          {

                          }
                        },
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.black.withOpacity(0.56),
                        isScrollable: true,
                        controller: tabController,
                        labelStyle: bodyText1Style.copyWith(fontSize: 20),
                        unselectedLabelStyle: bodyText2Style.copyWith(fontSize: 12),
                        indicatorPadding: EdgeInsets.zero,
                        indicatorColor: Colors.red,
                        dividerColor: Colors.lightBlue,
                        padding: EdgeInsets.zero,
                        tabs:
                        [
                          const
                          Tab(child: Text("UPI",style: TextStyle(fontSize: 20),),
                          ),
                          const Tab(
                            child: Text("Bank Account",style: TextStyle(fontSize: 20)),
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Obx(
                        () => Container(
                      child: controller.selectedComunityIndex.value == 0
                          ? FadeTransition(opacity: _animation!, child:
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 200.w,
                              child:
                              Column(
                                children:
                                [
                                  EditTextWidgetAmount(
                                    controller: controller.etupiId,
                                    hint: 'Enter Your UPI ID',
                                    validator: (value){
                                      String pattern = '[a-zA-Z0-9.\-_]{2,256}@[a-zA-Z]{2,64}';
                                      RegExp regExp = RegExp(pattern);
                                      if(value.toString().isEmpty)
                                      {
                                        return "Please Enter Your UPI ID";
                                      }
                                      if (!regExp.hasMatch(value.toString()))
                                      {
                                        return 'Please Enter valid UPI ID';
                                      }

                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 50,),
                            InkWell(
                              onTap: (){
                                UtilsMethod.PopupBoxTrasction(context,"");
                              },
                              child:
                              Text.rich(

                                TextSpan(
                                  style: smallTextStyle,
                                  children: [
                                    TextSpan(
                                      text:
                                      'To get Information on processing fees and  withdrawing \n cash from your account ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12,
                                          height: 2,
                                          letterSpacing: 0.2),
                                    ),
                                    TextSpan(
                                      text: 'click here',
                                      style: TextStyle(
                                        color: const Color(0xff006eff),
                                        fontWeight: FontWeight.w300,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),


                                  ],
                                ),
                                textHeightBehavior:
                                TextHeightBehavior(applyHeightToFirstAscent: false),

                                softWrap: false,
                              ),
                            ),
                          ],
                        ),
                      ))
                          : controller.selectedComunityIndex.value == 1
                          ?
                      Column(
                        children: [
                          Container(
                            height: 460.h,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                border: Border.all(color: Colors.grey)
                            ),
                            child:
                            Column(
                              children:
                              [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 40.h,
                                  color: Colors.orangeAccent.withOpacity(0.1),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 8.0),
                                    child:  Text("Bank Details",style:subtitleStyle ,),
                                  ),
                                ),
                                Divider(height: 0.8,color: Colors.grey,thickness: 1,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children:
                                    [
                                      Container(
                                        width: 200.w,
                                        child:
                                        EditTextWidgetAmount(
                                          controller: controller.etAccountNumber,
                                          hint: 'Enter Account Number',
                                          type: TextInputType.number,
                                          validator: (value){
                                            if(value.toString().isEmpty)
                                            {
                                              return "Please Account Number";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 150,top: 30),
                                        child: EditTextWidgetAmount(
                                          hint: 'Re-Enter Account Number',
                                          type: TextInputType.number,
                                          validator: (value){
                                            if(value.toString().isEmpty)
                                            {
                                              return "Please Enter Account Number";
                                            }
                                            if(controller.etAccountNumber.text.toString()!=value.toString())
                                            {
                                              return "Please Enter Confirms Account Number";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 150,top: 30),
                                        child: EditTextWidgetAmount(
                                          hint: 'Enter Branch Name',
                                          controller: controller.etBranchName,
                                          type: TextInputType.text,
                                          validator: (value){
                                            if(value.toString().isEmpty)
                                            {
                                              return "Please Enter Branch Name";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 150,top: 30),
                                        child: EditTextWidgetAmount(
                                          hint: 'Enter Bank IFSC CODE',
                                          controller: controller.etIFSCECODE,
                                          type: TextInputType.text,
                                          validator: (value){
                                            if(value.toString().isEmpty)
                                            {
                                              return "Please Enter Bank IFSC CODE";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 150,top: 30),
                                        child: EditTextWidgetAmount(
                                          hint: 'Enter Bank Address',
                                          controller: controller.etAddress,
                                          type: TextInputType.text,
                                          validator: (value){
                                            if(value.toString().isEmpty)
                                            {
                                              return "Please Enter Bank Address";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      Padding(
                                          padding: const EdgeInsets.only(left: 3.0,right: 150),
                                          child: Obx(() => controller.bankModel.value.data!=null?
                                          DropdownButton(

                                            // Initial Value
                                            value: controller.selectedState,
                                            isExpanded: true,

                                            // Down Arrow Icon
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            underline: Container(
                                              height: 1,
                                              color: Colors.black,
                                            ),

                                            // Array list of items
                                            items: controller.bankModel.value.data!.map((BankDatum items)
                                            {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(" "+items.bankName.toString(),style:subtitleStyle),
                                              );
                                            }).toList(),

                                            hint: Text("Select Bank",
                                              style: subtitleStyle.copyWith(color: Colors.grey),),

                                            onChanged: (newValue)
                                            {
                                              controller.selectedState=newValue;
                                              controller.etSate.text=controller.selectedState.id;
                                              controller.bankModel.refresh();

                                            },
                                          ):Center()
                                          )
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 150,top: 30),
                                        child: EditTextWidgetAmount(
                                          hint: 'Remark',
                                          controller: controller.etSignature,
                                          type: TextInputType.text,
                                          validator: (value){
                                            if(value.toString().isEmpty)
                                            {
                                              return "Please Verify Account ";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),


                          ),
                          SizedBox(height: 50,),
                          InkWell(
                            onTap: (){
                              UtilsMethod.PopupBoxTrasction(context,"");
                            },
                            child: Text.rich(
                              TextSpan(
                                style: smallTextStyle,
                                children: [
                                  TextSpan(
                                    text:
                                    'To get Information on processing fees and  withdrawing \n cash from your account ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12,
                                        height: 2,
                                        letterSpacing: 0.2),
                                  ),
                                  TextSpan(
                                    text: 'click here',
                                    style: TextStyle(
                                      color: const Color(0xff006eff),
                                      fontWeight: FontWeight.w300,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),


                                ],
                              ),
                              textHeightBehavior:
                              TextHeightBehavior(applyHeightToFirstAscent: false),

                              softWrap: false,
                            ),
                          ),
                        ],
                      )
                          : Container(),
                    ),
                  )


                ],
              ),
            ),
          ),
        )
                    : Container(),
              ),
            )
          ],
        ),
      )



    );
  }
}
