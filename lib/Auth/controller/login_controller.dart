import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:vlesociety/AppConstant/AppConstant.dart';
import 'package:vlesociety/Dashboard/view/dashboard.dart';

import '../../AppConstant/APIConstant.dart';
import '../../UtilsMethod/BaseController.dart';
import '../../UtilsMethod/base_client.dart';
import '../model/CityModel.dart';
import '../model/StateModel.dart';
import '../view/Registration.dart';
import '../view/VerifyOTP.dart';

class LoginController extends GetxController{
  var stateData=StateModel().obs;
  var cityModel=CityModel().obs;
  TextEditingController etMobile=TextEditingController();
   var selectedState;
   var selectedCity;
   RxString rxPath="".obs;
  TextEditingController etName=TextEditingController();
  TextEditingController etEmail=TextEditingController();
  TextEditingController etZip=TextEditingController();
  TextEditingController etblock=TextEditingController();
  TextEditingController etSate=TextEditingController();
  TextEditingController etCity=TextEditingController();
  final formKey=GlobalKey<FormState>();
  GetStorage _storage=GetStorage();

 loginNetworkApi(String device_id )async
 {
   print("assdd"+device_id);
  var bodyRequest=
  {
     "lng":language,
     "mobile":etMobile.text,
     "fcm_id":device_id,
      };
  Get.context!.loaderOverlay.show();
  var response=await BaseClient().post(loginApi, bodyRequest).catchError(BaseController().handleError);
  Get.context!.loaderOverlay.hide();

  print("vsdfbfd"+etMobile.text);
  print(response);
  if(jsonDecode(response)["status"]==1)
    {
      BaseController().successSnack(jsonDecode(response)["message"]+" "+jsonDecode(response)["Data"]["otp"]);
      Get.to(()=>OtypVerifyPage(id: jsonDecode(response)["Data"]["ID"],otp:jsonDecode(response)["Data"]["otp"] ,));
          return;
    }
  BaseController().errorSnack(jsonDecode(response)["message"]);
 }


  Timer? _timer;
  RxInt start = 60.obs;

  void startTimer() {
    const oneSec =  Duration(seconds: 1);
    _timer =  Timer.periodic(
      oneSec,
          (Timer timer) {
        if (start.value == 0) {
            timer.cancel();
        } else {
          start.value--;
        }
      },
    );
  }

  verifyNetworkApi(String id,String otp)async
  {
    var bodyRequest={
      "lng":language,
      "ID":id,
      "otp":otp,
    };
    Get.context!.loaderOverlay.show();
    var response=await BaseClient().post(verfyApi, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("jnvkjnkdsv");
    print(response);
    if(jsonDecode(response)["status"]==1)
    {
      if (jsonDecode(response)["Data"].isNotEmpty)
      {
        if(jsonDecode(response)["Data"]["ID"].toString().isNotEmpty && jsonDecode(response)["Data"]["user_email"].toString().isNotEmpty)
          {
            _storage.write(AppConstant.id, jsonDecode(response)["Data"]["ID"]??"");
            _storage.write(AppConstant.userId, jsonDecode(response)["Data"]["user_login"]??"");
            _storage.write(AppConstant.userName, jsonDecode(response)["Data"]["display_name"]??"");
            _storage.write(AppConstant.profileImg, jsonDecode(response)["Data"]["profile"]??"");
            _storage.write(AppConstant.email, jsonDecode(response)["Data"]["user_email"]??"");
            _storage.write(AppConstant.phone, jsonDecode(response)["Data"]["mobile_no"]??"");
            _storage.write(AppConstant.block, jsonDecode(response)["Data"]["block"]??"");
            _storage.write(AppConstant.stateId, jsonDecode(response)["Data"]["state_id"]??"");
            _storage.write(AppConstant.cityId, jsonDecode(response)["Data"]["city_id"]??"");
            _storage.write(AppConstant.zip, jsonDecode(response)["Data"]["zip_code"]??"");
            _storage.write(AppConstant.userType, jsonDecode(response)["Data"]["u_type"]??"");
            print("jnvkjnkdsv"+jsonDecode(response)["Data"]["u_type"]??"");
            Get.offAll(() => HomeDashboard());
          }
       else{
          _storage.write(AppConstant.id, jsonDecode(response)["Data"]["ID"]??"");
          Get.to(() => Registration());
        }
        BaseController().successSnack(jsonDecode(response)["message"]);

      }
    }
    else{
      BaseController().errorSnack(jsonDecode(response)["message"]);
    }

  }
  signUpNetworkApi(String deviceId)async
  {
  print("dfhgdjh"+deviceId);
    if(etSate.text.isEmpty)
      {
        BaseController().warningSnack("Please Select State");
        return;
      }
    if(etCity.text.isEmpty){
      BaseController().warningSnack("Please Select City");
      return;
    }
    var bodyRequest={
      "lng":language,
    "name":etName.text,
    "email":etEmail.text,
    "mobile":etMobile.text,
    "zip_code":etZip.text,
    "block":etblock.text,
    "state_id":etSate.text,
    "city_id":etCity.text,
    "device_id":"",
    "fcm_id":deviceId,
      "ID":_storage.read(AppConstant.id).toString().trim(),
      "profile":""
    };
    print("vbdsjsjkbsdvjbvds");
    print(bodyRequest);
    Get.context!.loaderOverlay.show();
    var response=await BaseClient().post(signUpApi, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    if(jsonDecode(response)["status"]==1)
    {
      BaseController().successSnack(jsonDecode(response)["message"]);
      _storage.write(AppConstant.userId, jsonDecode(response)["Data"]["user_login"]??"");
      _storage.write(AppConstant.userName, jsonDecode(response)["Data"]["display_name"]??"");
      _storage.write(AppConstant.profileImg, jsonDecode(response)["Data"]["profile"]??"");
      _storage.write(AppConstant.email, jsonDecode(response)["Data"]["user_email"]??"");
      _storage.write(AppConstant.phone, jsonDecode(response)["Data"]["mobile_no"]??"");
      _storage.write(AppConstant.block, jsonDecode(response)["Data"]["block"]??"");
      _storage.write(AppConstant.zip, jsonDecode(response)["Data"]["zip_code"]??"");
      _storage.write(AppConstant.cityId, jsonDecode(response)["Data"]["city_id"]??"");
      _storage.write(AppConstant.zip, jsonDecode(response)["Data"]["zip_code"]??"");
      _storage.write(AppConstant.userType, jsonDecode(response)["Data"]["u_type"]??"");
      Get.offAll(() => HomeDashboard());
     return;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }
  signUpwithSocialLoginNetworkApi(UserCredential userCredential,String deviceId)async
  {
    final user = userCredential.user;

   // user?.phoneNumber.toString()

    var bodyRequest={
      "lng":language,
      "name":user?.displayName.toString(),
      "email":user?.email.toString(),
      "mobile":"",
      "device_id":"",
      "fcm_id":deviceId,

    };
    print("vbdsjsjkbsdvjbvds"+bodyRequest.toString());
    print(bodyRequest);
    Get.context!.loaderOverlay.show();
    var response=await BaseClient().post(socialSignInUp, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
     print("vbdsjsjkbsdvjbvds"+response);
    if(jsonDecode(response)["status"]==1)
    {
      BaseController().successSnack(jsonDecode(response)["message"]);
      _storage.write(AppConstant.id, jsonDecode(response)["Data"]["ID"]??"");
      _storage.write(AppConstant.userId, jsonDecode(response)["Data"]["user_login"]??"");
      _storage.write(AppConstant.userName, jsonDecode(response)["Data"]["display_name"]??"");
      _storage.write(AppConstant.profileImg, jsonDecode(response)["Data"]["profile"]??"");
      _storage.write(AppConstant.email, jsonDecode(response)["Data"]["user_email"]??"");
      _storage.write(AppConstant.phone, jsonDecode(response)["Data"]["mobile_no"]??"");
      _storage.write(AppConstant.block, jsonDecode(response)["Data"]["block"]??"");
      _storage.write(AppConstant.zip, jsonDecode(response)["Data"]["zip_code"]??"");
      _storage.write(AppConstant.cityId, jsonDecode(response)["Data"]["city_id"]??"");
      _storage.write(AppConstant.zip, jsonDecode(response)["Data"]["zip_code"]??"");
      _storage.write(AppConstant.userType, jsonDecode(response)["Data"]["u_type"]??"");
      Get.offAll(() => HomeDashboard());
      return;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }




  signUpUsAGestUserNetworkApi(String deviceId)async
  {
    var bodyRequest=
    {
      "lng":language,
      "device_id":"",
      "fcm_id":deviceId,
    };
    print("vbdsjsjkbsdvjbvds");
    print(bodyRequest);
    Get.context!.loaderOverlay.show();
    var response=await BaseClient().post(guestUserLogin, bodyRequest)
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("vbdsjsjkbsdvjbvds"+response);
    if(jsonDecode(response)["status"]==1)
    {
      BaseController().successSnack(jsonDecode(response)["message"]);
      _storage.write(AppConstant.userId, jsonDecode(response)["Data"]["user_login"]??"");
      _storage.write(AppConstant.userName, jsonDecode(response)["Data"]["display_name"]??"");
      _storage.write(AppConstant.profileImg, jsonDecode(response)["Data"]["profile"]??"");
      _storage.write(AppConstant.email, jsonDecode(response)["Data"]["user_email"]??"");
      _storage.write(AppConstant.phone, jsonDecode(response)["Data"]["mobile_no"]??"");
      _storage.write(AppConstant.block, jsonDecode(response)["Data"]["block"]??"");
      _storage.write(AppConstant.zip, jsonDecode(response)["Data"]["zip_code"]??"");
      _storage.write(AppConstant.cityId, jsonDecode(response)["Data"]["city_id"]??"");
      _storage.write(AppConstant.zip, jsonDecode(response)["Data"]["zip_code"]??"");
      _storage.write(AppConstant.userType, jsonDecode(response)["Data"]["u_type"]??"");

      Get.offAll(() => HomeDashboard());
      return;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getStateNetworkApi()async{
    Get.context!.loaderOverlay.show();
    var response=await BaseClient().get(getStateApi+"?lng=eng").catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    if(jsonDecode(response)["status"]==1)
    {

      stateData.value=stateModelFromJson(response);
      return;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }
  getCityNetworkApi(String id)async{
    Get.context!.loaderOverlay.show();
    var response=await BaseClient().get(getCityApi+"?lng=eng&state_id=${id}").catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    if(jsonDecode(response)["status"]==1)
    {
     print("vdsbvkjdsbvkjs");
     print(response);
     cityModel.value=cityModelFromJson(response);
      return;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  setEtDataController()
  {
    etName.text=_storage.read(AppConstant.userName);
    etEmail.text=_storage.read(AppConstant.email);
    etMobile.text=_storage.read(AppConstant.phone);
  }


  chooseImage(bool isCamera)async{
    final ImagePicker _picker = ImagePicker();
    try {
      final XFile? image = await _picker.pickImage(source:isCamera?ImageSource.camera:ImageSource.gallery,imageQuality: 60);
      if(image!=null)
      {
        rxPath.value=image.path;
      }
    } on Exception catch (e) {
      print("cxjkbjvkbsdjv"+e.toString());
    }

  }

  signUpProfileImgNetworkApi()async{
    print("djskfhj");
    if(etSate.text.isEmpty)
    {
      BaseController().warningSnack("Please Select State");
      return;
    }
    if(etCity.text.isEmpty){
      BaseController().warningSnack("Please Select City");
      return;
    }
    var bodyRequest={
      "lng":language,
      "name":etName.text,
      "email":etEmail.text,
      "mobile":etMobile.text,
      "zip_code":etZip.text,
      "block":etblock.text,
      "state_id":etSate.text,
      "city_id":etCity.text,
      "device_id":"",
      "fcm_id":"",
      "ID":_storage.read(AppConstant.id).toString().trim(),
    };
    print("vbdsjsjkbsdvjbvds");
    print(bodyRequest);
    Get.context!.loaderOverlay.show();
    var response=await BaseClient().profileUpdate(rxPath.value,bodyRequest,signUpApi).catchError(BaseController().handleError);
    print("@@response");
    print(response);
    Get.context!.loaderOverlay.hide();
    if(jsonDecode(response)["status"]==1)
    {
      BaseController().successSnack(jsonDecode(response)["message"]);
      _storage.write(AppConstant.userId, jsonDecode(response)["Data"]["user_login"]??"");
      _storage.write(AppConstant.userName, jsonDecode(response)["Data"]["display_name"]??"");
      _storage.write(AppConstant.profileImg, jsonDecode(response)["Data"]["profile"]??"");
      _storage.write(AppConstant.email, jsonDecode(response)["Data"]["user_email"]??"");
      _storage.write(AppConstant.phone, jsonDecode(response)["Data"]["mobile_no"]??"");
      _storage.write(AppConstant.block, jsonDecode(response)["Data"]["block"]??"");
      _storage.write(AppConstant.zip, jsonDecode(response)["Data"]["zip_code"]??"");
      _storage.write(AppConstant.cityId, jsonDecode(response)["Data"]["city_id"]??"");
      _storage.write(AppConstant.zip, jsonDecode(response)["Data"]["zip_code"]??"");
      _storage.write(AppConstant.userType, jsonDecode(response)["Data"]["u_type"]??"");
     // Get.back();
     // Get.offAll(() => HomeDashboard());
      return;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

}