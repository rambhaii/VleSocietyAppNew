// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:vlesociety/AppConstant/textStyle.dart';
// import 'package:vlesociety/Dashboard/controller/DashboardController.dart';
// import 'package:vlesociety/Dashboard/view/profile/like_video.dart';
//
// import '../../../CSC/CSCPage.dart';
// class like extends StatefulWidget {
//   const like({Key? key}) : super(key: key);
//
//   @override
//   State<like> createState() => _likeState();
// }
//
// class _likeState extends State<like> {
//   DashboardController controller = Get.find();
//   late TabController tabController;
//   AnimationController? _controller;
//   Animation<double>? _animation;
//   @override
//   void initState() {
//     super.initState();
//     controller.getCscNetworkApi();
//     tabController = TabController(length: 2, vsync: this);
//     _controller = AnimationController(
//         duration:  Duration(seconds: 1),
//         vsync: this,
//         value: 0,
//         lowerBound: 0,
//         upperBound: 1);
//     _animation =
//         CurvedAnimation(parent: _controller!, curve: Curves.fastOutSlowIn);
//     _controller!.forward();
//   }void dispose() {
//     tabController.dispose();
//     super.dispose();
//   }
//   @override
//
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           Container(
//             height: 35,
//             child: TabBar(
//                 onTap: (value) {
//                   controller.selectedComunityIndex.value = value;
//                   if (value == 1) {
//                   }
//                 },
//                 labelColor: Colors.black,
//                 unselectedLabelColor: Colors.black.withOpacity(0.56),
//                 isScrollable: true,
//                 controller: tabController,
//                 labelStyle: bodyText1Style.copyWith(fontSize: 12),
//                 unselectedLabelStyle: bodyText2Style.copyWith(fontSize: 12),
//                 indicatorPadding: EdgeInsets.zero,
//                 indicatorColor: Colors.transparent,
//                 padding: EdgeInsets.zero,
//                 tabs: [
//                   const Tab(
//                     child: Text("CSE NEWS"),
//                   ),
//                   const Tab(
//                     child: Text("SHOP"),
//                   ),
//                 ]),
//           ),
//           Container(
//             child: controller.selectedComunityIndex.value == 0
//                 ? FadeTransition(opacity: _animation!, child: CSCPage())
//                 : controller.selectedComunityIndex.value == 1
//                 ? Container()
//                 : Container(),
//           ),
//       Expanded(
//         child: TabBarView(children: [
//           like(),
//           video(),
//         ]),
//       )],
//       ),
//     );
//   }
// }
