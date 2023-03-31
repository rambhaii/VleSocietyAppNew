
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:vlesociety/UtilsMethod/app_exception.dart';
import 'package:vlesociety/UtilsMethod/dailog_healper.dart';



class BaseController {
  void handleError(error)
  {
    Get.context!.loaderOverlay.hide();
    if (error is BadRequestException) {
      var message = error.message;
      errorSnack(message.toString());
    } else if (error is FetchDataException) {
      var message = error.message;
      errorSnack(message.toString());
    } else if (error is ApiNotRespondingException) {
      errorSnack("Oops! It took longer to respond.");
    }
    else{
      errorSnack("Something went wrong");
    }
  }
  showLoading(String? message) {
    DialogHelper.showLoading(message);
  }
  hideLoading() {
    DialogHelper.hideLoading();
  }
  errorSnack(String message)
  {
    Get.snackbar("Error", message,
      backgroundGradient: LinearGradient(colors: [Colors.red,Colors.black45]),
      icon: Icon(Icons.cancel, color: Colors.black),
      snackPosition: SnackPosition.TOP,
      borderRadius: 3,
    );
  }
  successSnack(String message)
  {
    Get.snackbar("Success", message,
      backgroundGradient: LinearGradient(colors: [Colors.green,Colors.black45]),
      icon: Icon(Icons.check, color: Colors.black),
      snackPosition: SnackPosition.TOP,
      borderRadius: 3,
    );
  }
  warningSnack(String message)
  {
    Get.snackbar("Warning",message,
      backgroundGradient: LinearGradient(colors: [Colors.amber,Colors.black45]),
      icon: Icon(Icons.warning_amber, color: Colors.black),
      snackPosition: SnackPosition.TOP,
      borderRadius: 5,
    );
  }
}