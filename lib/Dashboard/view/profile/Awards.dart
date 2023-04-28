import 'dart:async';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:html/parser.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vlesociety/AppConstant/APIConstant.dart';
import 'package:vlesociety/Dashboard/controller/DashboardController.dart';
import 'package:vlesociety/Dashboard/view/profile.dart';
import 'package:vlesociety/Dashboard/view/profile/TestimonialsDetails.dart';
class Awords extends StatefulWidget {
  @override
  _AwordsState createState() => _AwordsState();
}
class _AwordsState extends State<Awords> {
  DashboardController controller = Get.find();
  PageController _pageController=PageController(
      initialPage: 0
  );
  int currentIndex = 0;
  static const _kDuration = const Duration(milliseconds: 360);
  static const _kCurve = Curves.ease;
  nextFunction() {
    _pageController.nextPage(duration: _kDuration, curve: _kCurve);
  }
  previousFunction() {
    _pageController.previousPage(duration: _kDuration, curve: _kCurve);
  }

  onChangedFunction(int index) {
    setState(() {
      currentIndex = index;
    });
  }
  @override
  void initState()
  {
    super.initState();
    _pageController = PageController();
    Timer.periodic(Duration(seconds: 5), (Timer timer)
    {
      return setState(() {
        if (currentIndex <2)
        {
          currentIndex++;
        } else{
          currentIndex=0;
        }
        _pageController.animateToPage(currentIndex, duration: Duration(milliseconds: 360), curve: Curves.easeIn);
      });
    });
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.getAwardNetworkApi();
    return Scaffold(
      appBar: PreferredSize(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/back1.png"),fit: BoxFit.fill
                  )
              ),
            ),
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
                  backgroundColor: Colors.white.withOpacity(.0),
                  leading: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.white.withOpacity(0.0),
                      backgroundImage: NetworkImage(BASE_URL+controller.image),
                    ),
                  ),
                  leadingWidth: 60,
                  title: Text(controller.userName.toString(), style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  elevation: 0,
                  actions: [
                    RawMaterialButton(
                      constraints: BoxConstraints(maxHeight: 40, minWidth: 40),
                      onPressed: () {
                        Get.to(()=>Profile());
                        //  controller.logout();
                      },
                      shape: CircleBorder(
                          side: BorderSide(width: 1, color: Colors.white)),
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
      body: Obx(()=> controller.awardModel.value.data!=null ?
      Stack(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(image: new AssetImage("assets/images/back1.png"), fit: BoxFit.fill,),
            ),
          ),

          Positioned(
            left: 16.w,
            bottom: 100.h,
            child: Container(


                height: 350.h,
                width: MediaQuery.of(context).size.width/1.1,
                // controller: _pageController,
                // onPageChanged: onChangedFunction,
                child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: onChangedFunction,
                    itemCount:controller.awardModel.value.data!.length,
                    itemBuilder:
                        (context,index){
                      final awarddata=controller.awardModel.value.data![index];
                      var awd=parse(awarddata.description);
                      String awardString = parse(awd.body!.text).documentElement!.text;

                      return Transform(
                        transform: Matrix4.identity(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 250.h,
                              width: 200.w,
                              decoration:
                              BoxDecoration(
                                border:  Border.all(
                                    color: Colors.brown,
                                    width: 10.0
                                ),
                              ),
                              child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl: BASE_URL+ awarddata.image.toString(),
                                height: 76.h,
                                width: 76.w,
                                placeholder: (context, url) =>
                                    Center(child: const CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                              ),
                            ),SizedBox(
                              height: 15.h,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(awarddata.title.toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue,
                                    decoration: TextDecoration.underline),),
                                Text(awardString,style: TextStyle(fontSize: 10,color: Colors.black),textAlign:
                                TextAlign.justify,maxLines: 6,),
                              ],
                            )
                          ],
                        ),
                      );
                    })
            ),

          ),
          Positioned(
            bottom: 50.w,
            left: 110.w,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                        onTap: () => previousFunction(),
                        child:Container(
                            padding: EdgeInsets.all(8),
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white)
                            ),
                            child:
                            Image.asset("assets/images/bac.png"))),
                    SizedBox(
                      width: 50,
                    ),
                    InkWell(onTap: () => nextFunction(),
                        child:Container(
                            padding: EdgeInsets.all(8),
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white)
                            ),
                            child:
                            Image.asset("assets/images/go.png")))
                  ],
                ),
              ),
            ),
          ),

        ],
      ):Container()
      ),
    );
  }
}

