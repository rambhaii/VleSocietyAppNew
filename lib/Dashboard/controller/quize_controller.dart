import 'dart:async';
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

  RxString hoursString = "00".obs, minuteString = "00".obs, secondString = "00".obs;

  RxInt hours = 0.obs, minutes = 0.obs, seconds = 0.obs;

  late Timer _timer;






  void startTimer()
  {
    _timer = Timer.periodic(Duration(seconds: 1), (timer)
    {
      _startSecond();
    });
  }

  void pauseTimer() {
    _timer.cancel();
  }

  void _startSecond() {

      if (seconds < 59)
      {
        seconds++;
        secondString.value = seconds.toString();
        if (secondString.value.length == 1) {
          secondString.value = "0" + secondString.value;
        }
      } else
      {
        _startMinute();
      }

  }

  void _startMinute() {

      if (minutes < 59)
      {
        seconds.value = 0;
        secondString.value = "00";
        minutes++;
        minuteString.value= minutes.toString();
        if (minuteString.value.length == 1)
        {
          minuteString.value = "0" + minuteString.value;
        }
      } else {
        _starHour();
      }

  }

  void _starHour() {

      seconds.value = 0;
      minutes.value = 0;
      secondString.value = "00";
      minuteString.value = "00";
      hours++;
      hoursString.value = hours.toString();
      if (hoursString.value.length == 1) {
        hoursString.value = "0" + hoursString.value;
      }

  }

  void resetTimer() {
    _timer.cancel();

      seconds.value = 0;
      minutes.value = 0;
      hours.value = 0;
      secondString.value = "00";
      minuteString.value = "00";
      hoursString.value = "00";


  }

  bool checkValues()
  {
    if (seconds != 0 || minutes != 0 || hours != 0) {
      return true;
    } else {
      return false;
    }
  }



















  jumptopage()
  {
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
        print("sdsdfgfdgghd"+secondString.value+""+minuteString.value);
        QuizTestNetworkApi();
      }
    }

 ///vle_admin/api/Dashboard/quizTest

 QuizTestNetworkApi()async{
    var bodyRequest={
    "lng":"eng",
    "user_id":_storage.read(AppConstant.id),
    "times":minuteString.value+":"+secondString.value,
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