import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vlesociety/Dashboard/controller/DashboardController.dart';
import 'package:whatsapp_share/whatsapp_share.dart';

import '../../../AppConstant/textStyle.dart';
import '../profile/FCQ.dart';


class ReferAndEarn extends StatefulWidget {
   const ReferAndEarn({Key? key}) : super(key: key);

   @override
   State<ReferAndEarn> createState() => _ReferAndEarnState();
 }

 class _ReferAndEarnState extends State<ReferAndEarn> {
  DashboardController controller=Get.find();

   @override
   Widget build(BuildContext context) {
     controller.getReferalPointsDetailNetworkApi();

     return Scaffold(
       appBar: PreferredSize(
         preferredSize: Size.fromHeight(60),
         child: AppBar(
           backgroundColor:Color.fromRGBO(91, 105, 197, 1.0),
           elevation: 0.0,
           automaticallyImplyLeading: false,
           title: Padding(
             padding: const EdgeInsets.only(top: 8.0),
             child: Center(
               child: Column(
                 children: [
                   Text("Refer & Earn",style: TextStyle(fontSize: 14),),
                   SizedBox(height: 2,),
                   Container(
                     height: 3,
                     width: 39,
                     color: Colors.amber,
                   ),SizedBox(height: 4,),
                   //Text("Get a Course Free!",style: TextStyle(fontSize: 14),)
                 ],
               ),
             ),
           ),
           actions: [
             Padding(
               padding: const EdgeInsets.only(top: 5,right: 15),
               child: Padding(
                 padding: const EdgeInsets.only(top: 8.0),
                 child: Column(
                   children: [
                     InkWell(
                         onTap: (){
                           controller.getFaQNetworkApi();
                         },
                         child: Text("?FAQs",style: TextStyle(fontSize: 13),)),
                     Container(
                       height: 2,
                       width: 29,
                       color: Colors.white,
                     ),

                   ],
                 ),
               ),
             )
           ],
           leading: Padding(
             padding: const EdgeInsets.all(12.0),
             child: Container(
                 padding: EdgeInsets.only(left: 3),
                 height: 10,
                 width: 10,
                 decoration: BoxDecoration(
                     color: Colors.white,
                     shape: BoxShape.circle
                 ),
                 child: IconButton(onPressed: (){
                   Get.back();
                 },icon: Icon(Icons.arrow_back_ios,color: Colors.black,size: 15,),)),
           ),
         ),
       ),
       body:SingleChildScrollView(
         child: Column(
           children: [
             Container(
               child: Column(
                 children: [
                   Container(
                     height: 240.h,
                     child: Stack(
                       children: [
                         Container(
                           height: 210,
                           width: MediaQuery.of(context).size.width,
                           decoration: BoxDecoration(
                             color:Color.fromRGBO(91, 105, 197, 1.0),
                           ),
                           child: Container(
                             padding: EdgeInsets.symmetric(horizontal: 35),
                             child: Column(
                               children: [
                                 Container(
                                   child: Column(
                                     children: [
                                       Image(image: AssetImage("assets/images/team.png",),height: 240,)
                                     ],
                                   ),
                                 ),
                               ],
                             ),
                           ),
                         ),
                         Positioned(
                           top: 170,
                           left: 10,
                           right: 10,
                           child: Card(
                             elevation: 5,
                             shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(5)
                             ),
                             child: Container(
                               height: 58,
                               width: MediaQuery.of(context).size.width/1.10,
                               decoration: BoxDecoration(
                                   color: Colors.white,
                                   borderRadius: BorderRadius.circular(15)
                               ),
                               child: Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Row(
                                   children: [
                                     Image(image: AssetImage("assets/images/ratus.png")),
                                     Container(
                                         padding: EdgeInsets.only(left: 10),
                                         child: Text("Invite Friends on VLE Community",
                                           style: TextStyle(fontSize: 10),)),
                                     Spacer(),
                                     InkWell(
                                       onTap: (){
                                         Share.share(subject: "", "AppLink ");
                                       },
                                         child: Text("Invite",style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.w600),),
                                     )

                                   ],
                                 ),
                               ),
                             ),
                           ),
                         ),
                       ],
                     ),
                   ),
                   Container(
                     width: MediaQuery.of(context).size.width/1.07,
                     height:150.h,
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(5),
                         border: Border.all(width: .5)
                     ),
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Row(
                             children: [
                               Text("How it Works?"),
                               Spacer(),
                               InkWell(
                                 onTap: (){
                                   termsAndPolicey();
                                 },
                                 child:Text("T&Cs",style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.w600),),
                               )

                             ],
                           ),
                           SizedBox(height: 15,),
                           Divider(color: Colors.grey,height: 2,),
                           ListView.builder(
                               itemCount: 1,
                               shrinkWrap: true,
                               itemBuilder: (context,index){
                                 return Container(
                                   margin: EdgeInsets.only(top: 15),
                                   child: Row(
                                     children: [
                                       Card(
                                         shape: RoundedRectangleBorder(
                                             borderRadius: BorderRadius.circular(40)
                                         ),
                                         child: Container(
                                           height: 40,
                                           width: 40,
                                           decoration: BoxDecoration(
                                               shape: BoxShape.circle
                                           ),
                                           child: Center(child: Text("1x")),
                                         ),
                                       ),
                                       controller.referalModel.value.data!=null?
                                       Container(
                                         width: MediaQuery.of(context).size.width/1.8,
                                         child: Column
                                           (
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           children:
                                           [
                                             Text("Your Friend registers on Community",style: TextStyle(fontSize: 12),),

                                            Text(controller.referalModel.value.data!.referalUse!=null?"Friend earn ${ controller.referalModel.value.data!.referalUse.toString()} points":"Friend earn 0 points ",
                                              maxLines:2, style:TextStyle(height:1.4,fontSize: 12,color: Colors.green),overflow: TextOverflow.ellipsis,
                                             )],
                                         ),
                                       ):Container(),

                                       Spacer(),

                                       Container(
                                         margin: EdgeInsets.only(top: 15),
                                         height: 70,
                                         width: 75,
                                         child: Stack(
                                           children: [
                                             Container(
                                               height: 40,
                                               width: 75,
                                                 padding: EdgeInsets.only(left: 3,right: 3),
                                               decoration: BoxDecoration(
                                                   border: Border.all(width: 1,color: Colors.black),
                                                   borderRadius: BorderRadius.circular(5)
                                               ),
                                               child:
                                               Text( controller.referalModel.value.data!.referalUse!=null?"${ controller.referalModel.value.data!.referalUse.toString()} points you earn  ":"0 point you ",maxLines:2, style:TextStyle(height:1.4,fontSize: 12,color: Colors.black),overflow: TextOverflow.ellipsis,
                                               )
                                             ),

                                             // Positioned(
                                             //     top: -10,
                                             //     right: 20,
                                             //     child: Container(
                                             //       height: 20,
                                             //       width: 20,
                                             //       decoration: BoxDecoration(
                                             //           shape: BoxShape.circle,
                                             //           border: Border.all(width: 1,
                                             //             color: Colors.black,
                                             //           ),),
                                             //       child: Icon(Icons.add,color: Colors.white,size: 10,),
                                             //     ))
                                           ],
                                         ),
                                       ),
                                     ],
                                   ),
                                 );
                               })
                         ],
                       ),
                     ),
                   ),
                   SizedBox(height: 90,),
                   Container(
                       width: MediaQuery.of(context).size.width/1.07,
                       height: 100,
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(5),
                           color: Color.fromRGBO(212, 213, 224, 1.0)
                       ),
                       child: Column(
                         children: [
                           Expanded(
                             child: Align(
                               alignment: Alignment.bottomCenter,
                               child: Container(
                                 margin: const EdgeInsets.all(5),
                                 width: double.infinity,
                                 child: ElevatedButton(
                                   onPressed: () {},
                                   style: ButtonStyle(
                                       backgroundColor: MaterialStateProperty.all(Colors.red)
                                   ),
                                   child: Text("Give Contact Permission to Invite Your Friends",style:
                                   TextStyle(fontSize: 11,fontWeight: FontWeight.bold),), // trying to move to the bottom
                                 ),
                               ),
                             ),),
                           Expanded(
                             child: Align(
                               alignment: Alignment.bottomCenter,
                               child: Container(
                                 margin: const EdgeInsets.all(5),
                                 width: double.infinity,
                                 child: ElevatedButton(
                                     onPressed: () {},
                                     style: ButtonStyle(
                                         backgroundColor: MaterialStateProperty.all(Colors.white)
                                     ),
                                     child:
                                     InkWell(
                                       onTap: () async
                                       {
                                         await WhatsappShare.share
                                           (
                                           text: "App Link",
                                           linkUrl: 'https://www.animationmedia.org/',
                                           phone: '911234567890',
                                         );
                                       },
                                       child: Row(
                                         crossAxisAlignment: CrossAxisAlignment.center,
                                         mainAxisAlignment: MainAxisAlignment.center,
                                         children:
                                         [
                                           Text("Refer Now",style: TextStyle(color: Colors.black),),SizedBox(width: 5,),
                                           Image(image: AssetImage("assets/images/whatsapp.png",),height: 20,)
                                         ],
                                       ),
                                     ) // trying to move to the bottom
                                 ),
                               ),
                             ),)
                         ],
                       )
                   ),
                 ],
               ),
             ),
           ],
         ),
       ),
     );
   }

  void termsAndPolicey()
  {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    showModalBottomSheet(
        context: context,
        barrierColor: Colors.transparent,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder:(context){
          return Obx(() =>controller.privacyModel.value.data!=null? SingleChildScrollView(
            child: Padding(padding:EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                      child: Container(
                          height: Get.height/1.25,
                          padding: EdgeInsets.all(10),
                          // height: h * 0.45,
                          width: double.infinity,
                          color: Colors.white70,
                          child: SingleChildScrollView(
                            child: Column(
                                children: [
                                  SizedBox(height: 10,),
                                  Container(
                                    width: 40,
                                    height: 6,
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 0.5, color: Colors.black12),
                                        borderRadius: BorderRadius.circular(10)),
                                  ),
                                  controller.privacyModel.value.data!.description!=null?  Html(
                                      data:  controller.privacyModel.value.data!.description.toString(),
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
                                      }):Center()






                                ]
                            ),
                          )
                      ),
                    )
                )
            ),
          ):Center()
          )
          ;
        }

    );

  }

 }

