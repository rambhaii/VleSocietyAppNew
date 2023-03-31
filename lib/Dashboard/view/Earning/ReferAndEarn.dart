import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vlesociety/Dashboard/controller/DashboardController.dart';

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
                   Text("Get a Course Free!",style: TextStyle(fontSize: 14),)
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
                     height: 240,
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
                                         child: Text("Invite Friends on Bada Business Community",
                                           style: TextStyle(fontSize: 10),)),
                                     Spacer(),
                                     Text("Invite",style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.w600),)
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
                     height:240,
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
                               Text("T&Cs",style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.w600),),
                             ],
                           ),
                           SizedBox(height: 15,),
                           Divider(color: Colors.grey,height: 2,),
                           ListView.builder(
                               itemCount: 2,
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
                                       Container(
                                         width: MediaQuery.of(context).size.width/1.8,
                                         child: Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           children: [
                                             Text("Your Friend registers on Community",style: TextStyle(fontSize: 12),),
                                             Text("Friend earn 250 point &gets a free Course",maxLines:2,
                                               style:TextStyle(height:1.4,fontSize: 12,color: Colors.green),overflow: TextOverflow.ellipsis,)
                                           ],
                                         ),
                                       ),
                                       Spacer(),
                                       Container(
                                         height: 70,
                                         width: 60,
                                         child: Stack(
                                           children: [
                                             Container(
                                               height: 40,
                                               width: 60,
                                               decoration: BoxDecoration(
                                                   border: Border.all(width: 1,color: Colors.black),
                                                   borderRadius: BorderRadius.circular(5)

                                               ),
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
                                     child:Row(
                                       crossAxisAlignment: CrossAxisAlignment.center,
                                       mainAxisAlignment: MainAxisAlignment.center,
                                       children: [
                                         Text("Refer Now",style: TextStyle(color: Colors.black),),SizedBox(width: 5,),
                                         Image(image: AssetImage("assets/images/whatsapp.png",),height: 20,)
                                       ],
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
 }

