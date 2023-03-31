import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:vlesociety/Dashboard/controller/DashboardController.dart';

class FourmPage extends StatelessWidget {
  FourmPage({super.key});
  DashboardController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [const Text("FourmPage  Page")],

    );
  }
}