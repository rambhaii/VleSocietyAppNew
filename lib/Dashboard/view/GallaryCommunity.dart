



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../../AppConstant/APIConstant.dart';
import '../controller/CommunityDetails.dart';


class GalleryPage extends StatefulWidget {
  final String cid;
  const GalleryPage({Key? key, required this.cid}) : super(key: key);


  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage>
{
  late  CommunityDetailsController controller;
  @override
  void initState() {
    controller=Get.put(CommunityDetailsController(cid: widget.cid));
    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    print(controller.communityModel.value.data);
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
      body: PhotoViewGallery.builder(
        itemCount: controller.communityModel.value.data!.imageList!.length,
        builder: (context, index)
        {
           return PhotoViewGalleryPageOptions(
            imageProvider:
                 NetworkImage(
                     BASE_URL +controller.communityModel.value.data!.imageList![index].image!
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