import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vlesociety/AppConstant/AppConstant.dart';

import '../../AppConstant/APIConstant.dart';
import '../../UtilsMethod/BaseController.dart';
import '../../UtilsMethod/base_client.dart';
import '../model/CommunityDetaisModel.dart';
class CommunityDetailsController extends GetxController{
  final String cid;
  CommunityDetailsController({required this.cid});

  var communityModel = CommunityDetailsModel().obs;
  GetStorage _storage = GetStorage();
     @override
  void onInit() {
    // TODO: implement onInit
       getCommunityDetailsNetworkApi();
    super.onInit();
  }
  getCommunityDetailsNetworkApi() async
  {
       var response = await BaseClient().get(getCommunityDetailsApi + "?lng=eng&user_id=${_storage.read(AppConstant.id)}&community_id=${cid}").catchError(BaseController().handleError);
       print("vdfvsds");
       print(response);
       print({_storage.read(AppConstant.id)});
       print({cid});
       if (jsonDecode(response)["status"] == 1) {
         communityModel.value = communityDetailsModelFromJson(response);
         return;
       }
       communityModel.value = communityDetailsModelFromJson(response);
       BaseController().errorSnack(jsonDecode(response)["message"]);
     }




}