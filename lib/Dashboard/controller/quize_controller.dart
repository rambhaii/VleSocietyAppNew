import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../AppConstant/APIConstant.dart';
import '../../AppConstant/AppConstant.dart';
import '../../UtilsMethod/BaseController.dart';
import '../../UtilsMethod/base_client.dart';
import '../model/Quiz_Model/quizq_model.dart';
import '../view/quizeQA/showresult.dart';

class QuizeController extends GetxController
{
  final String quizeId;
  QuizeController({required this.quizeId});

  var quizqModel= QuizqModel().obs;
  RxInt ind=0.obs;
  RxInt selectedIndex=(-1).obs;
  RxString selectedAnswer="".obs;
  List<String> questionListId=[];
  List<String> selectedAnsList=[];
  List<String> selectedAnsListShowingHistory=[];
  List<String> ansList=[];
  PageController pageController= PageController(viewportFraction: 1, keepPage: true);
  GetStorage _storage = GetStorage();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  getQuizqNetworkApi() async {
    var response = await BaseClient().get(getQuizqApi + "?lng=eng&quizId=${quizeId}").catchError(BaseController().handleError);

    if (jsonDecode(response)["status"] == 1) {
      quizqModel.value = quizqModelFromJson(response);

      if(quizqModel.value.data!.questionList!.isEmpty){
        Fluttertoast.showToast(msg: "No Question Available");
        Get.back();
      };
      return;
    }
    quizqModel.value = quizqModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }


  jumptopage(){
    if(quizqModel.value.data!.questionList!.isNotEmpty && ind.value<(quizqModel.value.data!.questionList!.length))
      {
        questionListId.add(quizqModel.value.data!.questionList![ind.value].id!);
        ansList.add(quizqModel.value.data!.questionList![ind.value].answer!);
       switch(selectedIndex.value)
       {
           case 0:
           selectedAnsList.add("A");
           selectedAnsListShowingHistory.add("A");
           break;
           case 1:
           selectedAnsList.add("B");
           selectedAnsListShowingHistory.add("B");
           break;
           case 2:
           selectedAnsList.add("C");
           selectedAnsListShowingHistory.add("C");
           break;
           case 3:
           selectedAnsList.add("D");
           selectedAnsListShowingHistory.add("D");
           break;
       }
        ind.value=ind.value+1;
        selectedIndex.value=-1;
        pageController.animateToPage(
          ind.value , duration: const Duration(milliseconds: 400),
          curve: Curves.fastOutSlowIn,
        );
        print("sdvbjdsbv");
        print(ind.value);
        print(quizqModel.value.data!.questionList!.length);
      }
    if((quizqModel.value.data!.questionList!.length)==ind.value)
      {
        print("sdvbjdsbv@");
        print(ind.value);
        QuizTestNetworkApi();
      }
    }

 ///vle_admin/api/Dashboard/quizTest

 QuizTestNetworkApi()async{
    var bodyRequest={
    "lng":"eng",
    "user_id":_storage.read(AppConstant.id),
    "times":"1:13",
    "quiz_id":quizeId,
    "qusdtion_id":jsonEncode(questionListId),
    "choose_answer":jsonEncode(selectedAnsList),
    "answer":jsonEncode(ansList)
    };
    print("dfjghkdjf"+jsonEncode(selectedAnsList).toString());
    print(bodyRequest);
    Get.context!.loaderOverlay.show();
    var response=await BaseClient().post(quizTestApi, bodyRequest).catchError(BaseController().handleError);
    print("vdsbvdsjkvbl");
    print(response);
    Get.context!.loaderOverlay.hide();
    if(jsonDecode(response)["status"]==1)
    {

      Get.off(()=>showresult(selectedAnsList,quize_id: jsonDecode(response)["Data"]["tbl_quiz_id"].toString(),ttCorrect: jsonDecode(response)["Data"]["ttl_correct"].toString(), ttInCorrect:jsonDecode(response)["Data"]["ttl_wrong"].toString(),));
      return;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }


}