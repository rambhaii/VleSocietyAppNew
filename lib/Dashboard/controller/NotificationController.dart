import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../AppConstant/APIConstant.dart';
import '../../AppConstant/AppConstant.dart';
import '../../UtilsMethod/BaseController.dart';
import '../../UtilsMethod/base_client.dart';
import '../model/NotificationModel.dart';
import '../view/notification.dart';

class NotificationController extends GetxController
{
  GetStorage _storage = GetStorage();
  var notificationModel = NotificationModel().obs;
  final ScrollController scrollController1=ScrollController();
  RxBool  isLoadingNotificationPage=false.obs;
  int count=0;

  int start=0;
  @override
  void onInit()
  {
    addItems();
    super.onInit();
  }

  addItems() async
  {

    scrollController1.addListener
      (
            ()
        {
          if (scrollController1.position.maxScrollExtent == scrollController1.position.pixels)
          {
            if(isLoadingNotificationPage.value)
            { start=start+int.parse(notificationModel.value.page!.toString());
              getNotificationListLoadingNetworkApi(start);
            }

          }
        });
  }


  getNotificationListLoadingNetworkApi(int start ) async
  {

    var response = await BaseClient()
        .get(getNotificationList + "?lng=eng&limit=${15}&page=${start}&user_id==${_storage.read(AppConstant.id)}")
        .catchError(BaseController().handleError);

    if (jsonDecode(response)["status"] == 1)
    {

      if(isLoadingNotificationPage.value==true)
      {

        notificationModel.value.data!.addAll(notificationModelFromJson(response).data!);
        notificationModel.refresh();
      }
    }
    else{
      isLoadingNotificationPage.value=false;
      Fluttertoast.showToast(msg: "No more data availabel ! ");
    }
  }



  getNotificationListNetworkApi() async
  {
     print("ksjdfhjh");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().get(getNotificationList + "?lng=eng&limit=${15}&page=0&user_id=${_storage.read(AppConstant.id)}").catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
     print("ksjdfhjh"+getNotificationList + "?lng=eng&limit=${10}&page=0&user_id==${_storage.read(AppConstant.id)}");
    if (jsonDecode(response)["status"] == 1)
    {
      notificationModel.value = notificationModelFromJson(response);
      print("bfhj"+notificationModel.value.page.toString());
      if(notificationModel.value.page.toString()=="15")
      {

        isLoadingNotificationPage.value = true;
      }

      return;
     }
    notificationModel.value = notificationModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

}