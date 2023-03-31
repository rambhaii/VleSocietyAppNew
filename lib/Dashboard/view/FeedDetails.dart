 import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../AppConstant/textStyle.dart';
class FeedDetails extends StatelessWidget {
   const FeedDetails({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {
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
                       leading: Container(
                         height: 8,
                         width: 8,
                         decoration: BoxDecoration(

                         ),
                         child: IconButton(
                           onPressed:()=> Navigator.of(context).pop(),
                           icon: Icon(Icons.arrow_back_ios_new,color: Colors.black,),),
                       ),
                       leadingWidth: 60,
                       elevation: 0.0,
                       title:
                       Text("hello", style: subtitleStyle.copyWith(fontWeight: FontWeight.w900,fontSize: 16)
                       )
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
           child: ListView.separated(
             padding: EdgeInsets.all(10),
             shrinkWrap: true,
             reverse: true,
             physics: NeverScrollableScrollPhysics(),
             itemCount: 50,
             separatorBuilder: (BuildContext context, int index) => Divider(
               height: 5,
               thickness: 1.6,
               color: Colors.grey.withOpacity(0.2),
             ),
             itemBuilder: (BuildContext context, int index) {

               return Padding(
                 padding: const EdgeInsets.only(top: 6.0,bottom: 6.0),
                 child: InkWell(
                   onTap: (){

                   },
                   child: Row(
                     children: [
                       Expanded(child: Text(
                         "List",
                         style: bodyText1Style,overflow: TextOverflow.ellipsis,
                         maxLines: 3,
                       ),),
                       SizedBox(width: 10,),
                       ClipRRect(
                         borderRadius: BorderRadius.circular(10),
                         child: CachedNetworkImage(
                           fit: BoxFit.cover,
                           imageUrl:'',
                           height: 75,
                           width: 75,
                           placeholder: (context, url) =>
                               Center(child: const CircularProgressIndicator()),
                           errorWidget: (context, url, error) =>
                           const Icon(Icons.error),
                         ),
                       )
                     ],
                   ),
                 ),
               );
             },
           ),
         ),

     );
   }
 }
