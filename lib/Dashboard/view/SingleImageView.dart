



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../../AppConstant/APIConstant.dart';
import '../controller/CommunityDetails.dart';


class SingleImageView extends StatelessWidget {
   String image;
   SingleImageView( this.image, {Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {

print("dfhghjhjk"+image);
    return Scaffold(
      appBar: AppBar(
    backgroundColor: Colors.white.withOpacity(0.5),
    leadingWidth: 60,
    elevation: 0.0,
        leading: new IconButton
      (
      icon: new Icon(Icons.arrow_back_ios, color: Colors.grey),
      onPressed: () => Navigator.of(context).pop(),
       ),

      ),
      // Implemented with a PageView, simpler than setting it up yourself
      // You can either specify images directly or by using a builder as in this tutorial
      body:
      PhotoViewGallery.builder(
        itemCount: 1,
        builder: (context, index)
        {
           return PhotoViewGalleryPageOptions(
            imageProvider:
                 NetworkImage(
                     image
                 ),
            minScale: PhotoViewComputedScale.contained * 1,
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        },
        scrollPhysics: BouncingScrollPhysics(),
        // Set the background color to the "classic white"
        backgroundDecoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
        ),



      ),
    );
  }
}