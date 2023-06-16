import 'dart:convert';
import 'dart:io';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vlesociety/AppConstant/AppConstant.dart';
import 'package:vlesociety/Dashboard/model/AwardModel.dart';
import 'package:vlesociety/Dashboard/model/BannerModel.dart';
import 'package:vlesociety/Dashboard/model/FeedBackModel.dart';
import 'package:vlesociety/Dashboard/model/follow_model.dart';
import '../../Ads/AdHelper.dart';
import '../../AppConstant/APIConstant.dart';
import '../../Auth/controller/login_controller.dart';
import '../../Notification/FirebaseServices.dart';
import '../../Splash/SplashPage.dart';
import '../../UtilsMethod/BaseController.dart';
import '../../UtilsMethod/base_client.dart';
import '../model/AboutCscModel .dart';
import '../model/AnswerModel.dart';
import '../model/ArticalModel.dart';
import '../model/AwardsModel.dart';
import '../model/BankModel.dart';
import '../model/CertificateModel.dart';
import '../model/CommunityCategoryModel.dart';
import '../model/CommunityModel.dart';
import '../model/FaqModel.dart';
import '../model/FeedArticalModel.dart';
import '../model/GovernMentServices.dart';
import '../model/LikeDislike.dart';
import '../model/NotificationModel.dart';
import '../model/PointsModelDetails.dart';
import '../model/PressMediaData.dart';
import '../model/PressMrdiaDetailsModel.dart';
import '../model/PrivacyModel .dart';
import '../model/QuizModel.dart';
import '../model/Quiz_Model/ContestQuize.dart';
import '../model/Quiz_Model/quizq_model.dart';
import '../model/RedeemPointsModel.dart';
import '../model/ReferalModel.dart';
import '../model/ReportPostApi.dart';
import '../model/SearchKeyModel.dart';
import '../model/ServiceCategoryModel.dart';
import '../model/ServiceModel.dart';
import '../model/SettingModel.dart';
import '../model/TestimonialModel.dart';
import '../model/TransactionsModel.dart';
import '../model/UserDetails.dart';
import '../model/UserType.dart';
import '../view/ArticalSearch.dart';
import '../view/Community.dart';
import '../view/Earning/ReferAndEarn.dart';
import '../view/SearchScreen.dart';
import '../view/SubCategoryOfCategoryServices.dart';
import '../view/SubCategoryOfServices.dart';
import '../view/ThirdLevelOfServices.dart';
import '../view/notification.dart';
import '../view/profile/AboutCSC.dart';
import '../view/profile/Awards.dart';
import '../view/profile/Certificates.dart';
import '../view/profile/FCQ.dart';
import '../view/profile/PointRedeem.dart';
import '../view/profile/PointTable.dart';
import '../view/profile/PressMediaDetails.dart';
import '../view/profile/PressMida.dart';
import '../view/profile/TestimonialsDetails.dart';
import '../view/profile/testimonials.dart';
import '../view/profile/transaction.dart';
import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class followContrller extends GetxController {
  bool follow = false;
}

class DashboardController extends GetxController {
  final ScrollController scrollController = ScrollController();
  final ScrollController sFcrollController1 = ScrollController();
  final ScrollController scrollController2 = ScrollController();
  final ScrollController scrollControllerTrasaction = ScrollController();
  final formKey=GlobalKey<FormState>();
  final formKey1=GlobalKey<FormState>();
  final upiformKey=GlobalKey<FormState>();
  TextEditingController etAmount=TextEditingController();
  TextEditingController etupiId=TextEditingController();
  TextEditingController etSate=TextEditingController();
  TextEditingController etAccountNumber=TextEditingController();
  TextEditingController etIFSCECODE=TextEditingController();
  TextEditingController etBranchName=TextEditingController();
  TextEditingController etAddress=TextEditingController();
  TextEditingController etSignature=TextEditingController();
  var userTypemodel = UserType().obs;

  Timer? _timer;
  RxInt startime = 0.obs;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (startime.value == 0) {
          timer.cancel();
        } else {
          startime.value++;
        }
      },
    );
  }
  var selectedState;
  RxInt countvalue = 0.obs;
  RxInt countervalue=0.obs;
  Future<void> counter() async
  {
    print("fjgjfg");
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
       countervalue.value = prefs.getInt('count')!;
      if(countervalue.value==null)
        {
          countervalue.value=0;
        }

      if (counter!= null)
      {
        print("dfgfghghgh"+countervalue.value.toString());
        countervalue.value = countervalue.value! + 1;
        await prefs.setInt("count", countervalue.value!);
        countvalue.value = countervalue.value!;

      }
    } catch (e)
    {
      print("djghffdggfhgdhj "+e.toString());
    }
  }

  int start = 0;
  int end = 10;

  RxInt selectedIndex = 0.obs;
  RxInt selectedIndexOfArtical = 0.obs;
  RxInt selectedComunityIndex = 0.obs;
  RxInt selectedTrasactionIndex = 0.obs;
  RxInt selectedTabRedeemIndex = 0.obs;
  RxInt selectedServicesIndex = 0.obs;
  RxBool isCategorySelected = false.obs;
  RxBool isDob = true.obs;
  var bannerModel = BannerModel().obs;
  var quizModel = QuzeModel().obs;
  var quizModelContest = QuzeModel().obs;

  var communityModel = CommunityModel().obs;
  var communityModelBySerachKey = CommunityModel().obs;
  var myAskModel = CommunityModel().obs;
  var answerModel = AnswarModel().obs;

  var serviceModel = ServiceModel().obs;
  var governmentServiceModel = ServiceModel().obs;
  var serviceCategoryModel = ServiceCategoryModel().obs;
  var serviceCategoryModel1 = ServiceCategoryModel().obs;
  var serviceCategoryModel2 = ServiceCategoryModel().obs;
  var serviceCSCModel = ServiceModel().obs;

  var followModel = FollowModel().obs;
  var feedArticalModel = FeedArticalModel().obs;
  var likeDislike = LikeDisLike().obs;
  var shareModel = LikeDisLike().obs;
  var governMentServices = GovernMentServices().obs;
  var faqModel = FaqModel().obs;
  var contestQuize = ContestQuize().obs;
  var reportPostApi = ReportPostApi().obs;
  var referalModel = ReferalModel().obs;
  var userDetails = UserDetails().obs;
  var bankModel = BankModel().obs;
  var redeemPointsModel = RedeemPointsModel().obs;
  var settingModel = SettingModel().obs;
  var pointsModelDetails = PointsModelDetails().obs;

  var certificateModel = CertificateModel().obs;

  //var searchKeyModel = SearchKeyModel().obs;
  var awardsModel = AwardsModel().obs;
  var transactionsModel = TransactionsModel().obs;
  var testimonialModel = TestimonialModel().obs;
  var pressMediaData = PressMediaData().obs;
  var pressMediaDetailsModel = PressMediaDetailsModel().obs;
  var communityCategoryModel = CommunityCategoryModel().obs;
  var privacyModel = PrivacyModel().obs;
  var aboutCscModel = AboutCscModel().obs;
  var feedBackModel = FeedBackModel().obs;
  var awardModel = AwardModel().obs;
  RxInt fileLength = 0.obs;
  List<XFile>? imagesList = [];
  RxString rxMessaage = "".obs;
  RxString urlvalue = "".obs;
  TextEditingController etMessage = TextEditingController();
  TextEditingController searchkey = TextEditingController();

  GetStorage _storage = GetStorage();
  String userName = "";
  String email = "";
  String image = "";
  String userType = "";
  String points = "0";
  String dob = "";
  RxBool isLoadingPage = false.obs;
  RxBool isLoadingMyAsk = false.obs;
  RxBool isLoadingPageArtical = false.obs;
  RxBool isLoadingQuizePage = false.obs;
  RxBool isLoadingCSCPage = false.obs;
  RxBool isLoadingVleNewsPage = false.obs;
  RxBool isLoadingTransactionPage = false.obs;
  RxBool isLoadinginsertialAds = false.obs;

  RxInt setCategoryOfArtical = 0.obs;
  RxInt setSelectedCategoryOfArtical = 1.obs;

  var articleModel = ArticaleModel().obs;
  var articleModelByCategory = ArticaleModel().obs;
  var articleModelWithFilter = ArticaleModel().obs;
  var articleModelWithSearchKey = ArticaleModel().obs;
  var cscModel = ArticaleModel().obs;

  @override
  void onInit() {

    setupRemoteConfig();

    userName = _storage.read(AppConstant.userName) ?? "";
    email = _storage.read(AppConstant.email) ?? "";
    image = _storage.read(AppConstant.profileImg) ?? "";
    userType = _storage.read(AppConstant.userType) ?? "";
    dob = _storage.read(AppConstant.dob) ?? "";
    getSettingsNetworkApi();
    getgetUserDetailsNetworkApi();
    addItems();
    getBannerNetworkApi();
    getCommunityNetworkApi();
    getreportPostApiNetworkApi();
    getQuizNetworkApi();
    addItemsQuize();
    addTransaction();


    super.onInit();
  }
    loadInterstitialAd()
  {
   // Get.context!.loaderOverlay.show();

    InterstitialAd? interstitialAd;
    InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad)
          {

            interstitialAd = ad;
            interstitialAd!.show();
          //  Get.context!.loaderOverlay.hide();
            interstitialAd!.fullScreenContentCallback =
                FullScreenContentCallback(
                    onAdFailedToShowFullScreenContent: ((ad, error) {
                      ad.dispose();
                      interstitialAd!.dispose();
                      debugPrint(error.message);
                    }),
                    onAdDismissedFullScreenContent: (ad) {
                      ad.dispose();
                      interstitialAd!.dispose();

                    //  Get.to(() => CommunityDetails(cid:id.toString()));
                    }

                );
          },
          onAdFailedToLoad: (err) {
            debugPrint(err.message);
          },
        ));
  }







































  addItems() async
  {

    print("objedfdfgdfct");
    print(isLoadingMyAsk.value);
    print( selectedIndex.value);
    print(setSelectedCategoryOfArtical.value);

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        if (isLoadingPage.value && selectedIndex.value == 0 && selectedComunityIndex.value == 0)
        {

          start = start + int.parse(communityModel.value.page!.toString());
          getCommunityLoadingNetworkApi(start);
        }
        else if(isLoadingMyAsk.value && selectedIndex.value == 0 && selectedComunityIndex.value == 1)
          {

            start = start + int.parse(myAskModel.value.page!.toString());
            getMyAskLoadingNetworkApi(start);
            print("jhgj");
          }


        else if (isLoadingPageArtical.value && selectedIndex.value == 1 &&
            setSelectedCategoryOfArtical.value == 1)
        {
          print("djdfh");
          start = start + int.parse(feedArticalModel.value.page!.toString());
          getFeedArticalLoadingNetworkApi(start);
        } else if (isLoadingQuizePage.value && selectedIndex.value == 3) {
          start = start + int.parse(quizModel.value.page!.toString());
          getQuizeLoadingNetworkApi(start);
        } else if (isLoadingPageArtical.value && selectedIndex.value == 1
            && setSelectedCategoryOfArtical.value == 2)
        {
          print("jfdhg");
          start = start + int.parse(articleModel.value.page!.toString());
          getArticalLoadingNetworkApi(start);
        }
      }
    });
  }

  addItemsQuize() async {
    scrollController2.addListener(() {
      if (scrollController2.position.maxScrollExtent ==
          scrollController2.position.pixels) {
        if (isLoadingVleNewsPage.value)
        {
          start = start + int.parse(feedArticalModel.value.page!.toString());
         getFeedArticalLoadingNetworkApi(start);
        }
      }
    });
  }
  addTransaction() async
  {
    scrollControllerTrasaction.addListener(()
    {
      print("djfkhkg");
      if (scrollControllerTrasaction.position.maxScrollExtent == scrollControllerTrasaction.position.pixels)
      {
        if (isLoadingTransactionPage.value)
        {
          start = start + int.parse(transactionsModel.value.page!.toString());
          getTransactionLoadingNetworkApi(start);
        }
      }
    });
  }

  getTransactionLoadingNetworkApi(int end) async {

  print("dkjhjg");

    var response = await BaseClient()
        .get(gettransactionHistory + "?lng=eng&limit=${15}&page=${end}&user_id=${_storage.read(AppConstant.id)}")
        .catchError(BaseController().handleError);
    print("dfgfghghfj"+response);

    if (jsonDecode(response)["status"] == 1)
    {
      if (isLoadingTransactionPage.value == true)
      {
        print("dkjhjg");
        transactionsModel.value.data!.addAll(transactionsModelFromJson(response).data!);
        transactionsModel.refresh();
      }
    } else
    {
      print("dkjhjghgfgdfgdgd");
      isLoadingTransactionPage.value = false;
      Fluttertoast.showToast(msg: "No more data available !");
    }
  }




  RxList reportMessageList = [
    "Harashment",
    "Spam",
    "Insincere",
    "Abusive",
    "Poorly Written",
    "Unwanted Add",
    "Pornographic"
  ].obs;

  getBannerNetworkApi() async {
    var response = await BaseClient()
        .get(getBannerApi + "?lng=eng")
        .catchError(BaseController().handleError);

    if (jsonDecode(response)["status"].toString() == "1") {
      bannerModel.value = bannerModelFromJson(response);
      return;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getCommunityLoadingNetworkApi(int end) async {
  print("djfgjfgfg");
    var response = await BaseClient()
        .get(getCommunityApi +
            "?lng=eng&user_id=${_storage.read(AppConstant.id)}&limit=${10}&page=${end}")
        .catchError(BaseController().handleError);

    if (jsonDecode(response)["status"] == 1) {
      if (isLoadingPage.value == true) {
        communityModel.value.data!
            .addAll(communityModelFromJson(response).data!);
        //controller.end=controller.communityModel.value.page!;
        communityModel.refresh();
      }
    } else {
      isLoadingPage.value = false;
      Fluttertoast.showToast(msg: "No more data availabel ! ");
    }
  }

  getMyAskLoadingNetworkApi(int end) async {

    var response = await BaseClient()
        .get(getMyAsk +
        "?lng=eng&user_id=${_storage.read(AppConstant.id)}&limit=${10}&page=${end}")
        .catchError(BaseController().handleError);

    if (jsonDecode(response)["status"] == 1) {
      if (isLoadingMyAsk.value == true) {
        myAskModel.value.data!.addAll(communityModelFromJson(response).data!);
        //controller.end=controller.communityModel.value.page!;
        myAskModel.refresh();
      }
    } else {
      isLoadingMyAsk.value = false;
      Fluttertoast.showToast(msg: "No more data availabel ! ");
    }
  }




  getFeedArticalLoadingNetworkApi(int end) async {

    var response = await BaseClient()
        .get(getFeedArtical + "?lng=eng&limit=${20}&page=${end}")
        .catchError(BaseController().handleError);
    print("dfgfghghfj"+response);

    if (jsonDecode(response)["status"] == 1)
    {
      if (isLoadingPageArtical.value == true)
      {
       feedArticalModel.value.data!.reversed;
       feedArticalModel.value.data!.addAll(feedArticalModelFromJson(response).data!);
       feedArticalModel.refresh();
      }
    } else
    {
      isLoadingPageArtical.value = false;
      Fluttertoast.showToast(msg: "No more data available !");
    }
  }

  getArticalLoadingNetworkApi(int end) async
  {
    var response = await BaseClient()
        .get(getArticalApi + "?lng=eng&limit=${20}&page=${end}")
        .catchError(BaseController().handleError);
    if (jsonDecode(response)["status"] == 1) {
      if (isLoadingPageArtical.value == true) {
        articleModel.value.data!.addAll(articleModelFromJson(response).data!);
        articleModel.refresh();
      }
    } else {
      isLoadingPageArtical.value = false;
      Fluttertoast.showToast(msg: "No more data availabel ! ");
    }
  }


  getCommunityNetworkApi() async {
    var response = await BaseClient()
        .get(getCommunityApi +
            "?lng=eng&user_id=${_storage.read(AppConstant.id)}&limit=${10}&page=${0}")
        .catchError(BaseController().handleError);
    if (jsonDecode(response)["status"] == 1)
    {
      communityModel.value = communityModelFromJson(response);
      isLoadingPage.value = true;
      start = 0;
      end = 10;

    }
  }

  getAnswerNetworkApi(String communityId) async {
    var response = await BaseClient()
        .get(getCommunityAnswerApi +
            "?lng=eng&user_id=${_storage.read(AppConstant.id)}&community_id=${communityId}&limit=100&page=0")
        .catchError(BaseController().handleError);
    if (jsonDecode(response)["status"] == 1) {
      answerModel.value = answarModelFromJson(response);
      return;
    }
    rxMessaage.value = "No Answer Available";
    answerModel.value = answarModelFromJson(response);
  }

  getCommmunityCategoryNetworkApi() async {
    final data = {
      "id": 0,
      "title": "feed",
      "image": "",
      "followStatus": "",
    };

    var response = await BaseClient()
        .get(getCommunityCategorryApi +
            "?lng=eng&user_id=${_storage.read(AppConstant.id)}&limit=200&page=0")
        .catchError(BaseController().handleError);
    if (jsonDecode(response)["status"] == 1) {
      communityCategoryModel.value = communityCategoryModelFromJson(response);
      return;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  communityAnswerLikeDislikeNetworkApi(
      String answerId, String likeStatus, String communityId) async {
    String status = "";
    if (likeStatus == "0") {
      status = "1";
    } else {
      status = "0";
    }
    var response = await BaseClient()
        .get(communityAnswerLikeDislikeApi +
            "?lng=eng&user_id=${_storage.read(AppConstant.id)}&community_answer_id=${answerId}&status=${status}")
        .catchError(BaseController().handleError);
    if (jsonDecode(response)["status"] == 1) {
      // BaseController().successSnack(jsonDecode(response)["message"]);
      getAnswerNetworkApi(communityId);
      return;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  Future<bool> postCommunityAnswerNetworkApi(
      String message, String communityId) async {
    var bodyRequest = {
      "lng": language,
      "user_id": _storage.read(AppConstant.id),
      "community_id": communityId,
      "answer": message
    };


    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .post(postCommunityAnswerApi, bodyRequest)
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();

    if (jsonDecode(response)["status"] == 1) {
      // BaseController().successSnack(jsonDecode(response)["message"]);
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  postCommunityNetworkApi(String catid, msg) async {
    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .postMultipleImage(postCommunityApi, imagesList!,
            _storage.read(AppConstant.id), catid, msg)
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();

    if (jsonDecode(response)["status"] == 1)
    {
      BaseController().successSnack("Community post has been successfuly");
      getCommunityNetworkApi();
      return;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  postFeedbackNetworkApi(String catid, msg) async {
    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .postMultiple(postFeedBack, imagesList!, _storage.read(AppConstant.id),
            catid, msg)
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();

    if (jsonDecode(response)["status"] == 1) {

      BaseController().successSnack("FeedBack has been successfuly");
      return;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  logout() async {
    _storage.remove(AppConstant.userType);
    _storage.remove(AppConstant.id);
    _storage.remove(AppConstant.userId);
    _storage.remove(AppConstant.userName);
    _storage.remove(AppConstant.profileImg);
    _storage.remove(AppConstant.email);
    _storage.remove(AppConstant.phone);
    _storage.remove(AppConstant.block);
    _storage.remove(AppConstant.zip);
    _storage.remove(AppConstant.dob);
    _storage.remove(AppConstant.points);
    Get.delete<LoginController>();
    final _auth = FirebaseAuth.instance;
    final _googleSignIn = GoogleSignIn();
    await _auth.signOut();
    await _googleSignIn.signOut();
    Get.offAll(() => SplashPage());
  }

  void selectMultipleImage() async
  {
    final ImagePicker _picker = ImagePicker();
    List<XFile>? imagesList2 = await _picker.pickMultiImage(
        imageQuality: 60, requestFullMetadata: true);
    if (imagesList2.isNotEmpty)
    {
      fileLength.value = imagesList2.length;
      imagesList = imagesList2;
    }
  }

  getAskApi() async
  {
    print("krjhkjfgh");
    var response = await BaseClient()
        .get(getMyAsk + "?lng=eng&user_id=${_storage.read(AppConstant.id)}&limit=10&page=0")
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();

    if (jsonDecode(response)["status"] == 1)
    {
      myAskModel.value = communityModelFromJson(response);

     if(myAskModel.value.page.toString()=="10")
     {
       isLoadingMyAsk.value = true;
       start = 0;
       end = 10;
     }
     return;
    }
    isLoadingMyAsk.value = false;
    myAskModel.value = communityModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }


  getArticleNetworkApi() async {
    var response = await BaseClient()
        .get(getArticalApi + "?lng=eng")
        .catchError(BaseController().handleError);
    if (jsonDecode(response)["status"].toString() == "1") {
      articleModel.value = articleModelFromJson(response);
      if (articleModel.value.page! >= 9)
      {
        isLoadingPageArtical.value = true;
        setCategoryOfArtical.value = 2;
      }

      return;
    }
    articleModel.value = articleModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getArticleByCategoryNetworkApi(String cat_id) async
  {
    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
       // .get(getArticalApi + "?lng=eng&csc_id=8&post_category_id=${cat_id}")
        .get(getArticalApi + "?lng=eng&post_category_id=${cat_id}")
        .catchError(BaseController().handleError);
    print("articalmodel"+response);
    Get.context!.loaderOverlay.hide();
    if (jsonDecode(response)["status"].toString() == "1")
    {
      articleModelByCategory.value = articleModelFromJson(response);
      return;
    }
    articleModelByCategory.value = articleModelFromJson(response);
    //BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getArticleWithFilterNetworkApi(String cat_id, String state_id) async {
    var response = await BaseClient()
        .get(getArticalApi +
            "?lng=eng&csc_id=8&post_category_id=${cat_id}&state_id=${state_id}")
        .catchError(BaseController().handleError);
    if (jsonDecode(response)["status"] == 1) {
      articleModelWithFilter.value = articleModelFromJson(response);
      return;
    }
    articleModelWithFilter.value = articleModelFromJson(response);
    //   BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getCscNetworkApi() async {
    var response = await BaseClient()
        .get(getCsc + "?lng=eng")
        .catchError(BaseController().handleError);

    if (jsonDecode(response)["status"] == 1) {
      cscModel.value = articleModelFromJson(response);
      return;
    }
    cscModel.value = articleModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getQuizNetworkApi() async {
    var response = await BaseClient()
        .get(getQuizApi + "?lng=eng&limit=${10}&page=${0}")
        .catchError(BaseController().handleError);

    if (jsonDecode(response)["status"] == 1) {
      quizModel.value = quzeModelFromJson(response);
      if (quizModel.value.page! >= 10) {
        isLoadingQuizePage.value = true;
      }

      return;
    }
    quizModel.value = quzeModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getQuizeLoadingNetworkApi(int end) async {

    var response = await BaseClient()
        .get(getQuizApi + "?lng=eng&limit=${10}&page=${end}")
        .catchError(BaseController().handleError);
    if (jsonDecode(response)["status"] == 1) {
      if (isLoadingQuizePage.value == true) {
        quizModel.value.data!.addAll(quzeModelFromJson(response).data!);
        quizModel.refresh();
      }
    } else {
      isLoadingQuizePage.value = false;
      Fluttertoast.showToast(msg: "No more data availabel ! ");
    }
  }

  getQuizContestNetworkApi() async {
    var response = await BaseClient()
        .get(getQuizApi + "?lng=eng&limit=200&page=0&quiz_type=2")
        .catchError(BaseController().handleError);

    if (jsonDecode(response)["status"] == 1) {
      quizModelContest.value = quzeModelFromJson(response);
      return;
    }
    quizModelContest.value = quzeModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getServiceNetworkApi() async {
    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .get(getServicesApi + "?lng=eng&limit=200&page=0")
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    if (jsonDecode(response)["status"] == 1) {
      serviceModel.value = serviceModelFromJson(response);
      return;
    }
    serviceModel.value = serviceModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getServicesSubCategoryNetworkApi(
      String service_master_parentId, String title) async {

    var response = await BaseClient()
        .get(getServicesApi +
            "?lng=eng&limit=200&page=0&service_master_parent=${service_master_parentId}")
        .catchError(BaseController().handleError);
    if (jsonDecode(response)["status"] == 1) {

      serviceCategoryModel.value = serviceCategoryModelFromJson(response);
      Get.to(SubCategoryOfServices(title, "0"));

      return;
    }
    serviceCategoryModel.value = serviceCategoryModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getServicesSubCategoryOfCategoryNetworkApi(
      String service_master_parentId, String title) async {

    var response = await BaseClient()
        .get(getServicesApi +
            "?lng=eng&limit=200&page=0&service_master_parent=${service_master_parentId}")
        .catchError(BaseController().handleError);
    if (jsonDecode(response)["status"] == 1) {
      serviceCategoryModel1.value = serviceCategoryModelFromJson(response);
      Get.to(SubCategoryOfCategoryServices(title, "0"));

      return;
    }
    serviceCategoryModel1.value = serviceCategoryModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getServicesSubCategoryOfCategoryThirdLevelNetworkApi(
      String service_master_parentId, String title) async {

    var response = await BaseClient()
        .get(getServicesApi +
            "?lng=eng&limit=200&page=0&service_master_parent=${service_master_parentId}")
        .catchError(BaseController().handleError);
    if (jsonDecode(response)["status"] == 1) {

      serviceCategoryModel2.value = serviceCategoryModelFromJson(response);
      Get.to(ThirdLevelOfServicesimport(title));

      return;
    }
    serviceCategoryModel2.value = serviceCategoryModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getfollowNetworkApi(String follow_user_id, String status) async {

    var response = await BaseClient()
        .get(getFollowApi +
            "?lng=eng&user_id=${_storage.read(AppConstant.id)}&follow_user_id=${follow_user_id}&status=${status}")
        .catchError(BaseController().handleError);

    if (jsonDecode(response)["status"] == 1) {
      followModel.value = followModelFromJson(response);
      return;
    }
    followModel.value = followModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  gettransactionHistoryDetails(String filter) async {

    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .get(gettransactionHistory + "?lng=eng&user_id=${_storage.read(AppConstant.id)}&limit=15&page=0&txn_status=${filter}")
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();

    if (jsonDecode(response)["status"] .toString()== "1")
    { transactionsModel.value = transactionsModelFromJson(response);
      Get.to(transaction());
      if(transactionsModel.value.page.toString()=="15")
      {
        isLoadingTransactionPage.value = true;
       /* start = 0;
        end = 15;*/
      }

      return;
    }
    transactionsModel.value = transactionsModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }
  gettransactionPointsDetails() async
  {

    Get.context!.loaderOverlay.show();
    var response = await BaseClient().get(gettransactionHistory +"?lng=eng&user_id=${_storage.read(AppConstant.id)}&limit=500&page=0&txn_status=").catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    if (jsonDecode(response)["status"] .toString()== "1")
    {
      transactionsModel.value = transactionsModelFromJson(response);
      Get.to(()=>PointTable());
      return;
    }
    transactionsModel.value = transactionsModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getTestimonialsData() async {
    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .get(getTestimonialslist + "?lng=eng&limit=200&page=0")
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();

    if (jsonDecode(response)["status"] == 1) {

      testimonialModel.value = testimonialModelFromJson(response);
      Get.to(() => Tesimonials());
      return;
    }
    testimonialModel.value = testimonialModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getPressMediataListNetWorkApi() async {
    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .get(getPressMedia + "?lng=eng&limit=200&page=0")
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();

    if (jsonDecode(response)["status"].toString() == "1")
    {

      pressMediaData.value = pressMediaDataFromJson(response);
      Get.to(() => PressMedia());
      return;
     }
    pressMediaData.value = pressMediaDataFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getPressMediaDetailsNetWorkApi(String pressMedia_id,BuildContext context) async {
    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .get(getPressMediaDetails +
            "?lng=eng&limit=200&page=0&pressMedia_id=${pressMedia_id}")
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    if (jsonDecode(response)["status"] == 1) {
      pressMediaDetailsModel.value = pressMediaDetailsModelFromJson(response);
      Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft,
          duration: Duration(milliseconds: 700), child:PressMediaDetails()));

      return;
    }
    pressMediaDetailsModel.value = pressMediaDetailsModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getAboutCscNetworkApi() async {
    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .get(getAboutCsc + "?lng=eng")
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    if (jsonDecode(response)["status"].toString() == "1") {
      aboutCscModel.value = aboutCscModelFromJson(response);
      Get.to(() => AboutCSC());
      return;
    }
    aboutCscModel.value = aboutCscModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getPrivacyNetworkApi() async {
    var response = await BaseClient()
        .get(getPrivacy1 + "?lng=eng")
        .catchError(BaseController().handleError);

    if (jsonDecode(response)["status"].toString()== '1') {
      privacyModel.value = privacyModelFromJson(response);
      return;
    }
    privacyModel.value = privacyModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getAwardNetworkApi() async {
    var response = await BaseClient()
        .get(getAward + "?lng=eng&user_id=1&limit=10&page=0")
        .catchError(BaseController().handleError);

    if (jsonDecode(response)["status"] == 1) {
      awardModel.value = awardModelFromJson(response);
      return;
    }
    awardModel.value = awardModelFromJson(response);
   BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getComunitylikeDislikeNetworkApi(String community_id, String status) async {
    var response = await BaseClient()
        .get(getCommunitylikeDislike +
            "?lng=eng&user_id=${_storage.read(AppConstant.id)}&community_id=${community_id}&status=${status}")
        .catchError(BaseController().handleError);

    if (jsonDecode(response)["status"] == 1) {
      likeDislike.value = likeDisLikeFromJson(response);
      return;
    }
    likeDislike.value = likeDisLikeFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getFaQNetworkApi() async {
    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .get(getFaq + "?lng=eng&limit=200&page=0")
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    if (jsonDecode(response)["status"] == 1) {
      faqModel.value = faqModelFromJson(response);
      Get.to(Faq());
      return;
    }
    faqModel.value = faqModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getQuizAwardListNetworkApi() async {
    var response = await BaseClient()
        .get(getQuizAwardList + "?lng=eng&limit=200&page=0")
        .catchError(BaseController().handleError);

    if (jsonDecode(response)["status"].toString() == "1") {
      contestQuize.value = contestQuizeFromJson(response);
      return;
    }
    contestQuize.value = contestQuizeFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  Future<bool> postAppFeedbackNetworkApi(String message, String rating) async {
    var bodyRequest = {
      "lng": language,
      "user_id": _storage.read(AppConstant.id),
      "rating": rating,
      "description": message
    };

    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .post(postFeedback, bodyRequest)
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();

    if (jsonDecode(response)["status"] == 1) {
      BaseController().successSnack(jsonDecode(response)["message"]);
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  getSearchListNetworkApi(
      String searchKey, String post_category_master_id) async
  {
       Get.context!.loaderOverlay.show();

    var response = await BaseClient()
        .get(getCommunity_search +
            "?lng=eng&limit=10&page=0&user_id=${_storage.read(AppConstant.id)}&searchkey=${searchKey}&post_category_master_id=${post_category_master_id}")
        .catchError(BaseController().handleError);
    print("gfghjkhjkjkjkl"+getCommunity_search +
        "?lng=eng&limit=10&page=0&user_id=${_storage.read(AppConstant.id)}&searchkey=${searchKey}&post_category_master_id=${post_category_master_id}");
   Get.context!.loaderOverlay.hide();
    if (jsonDecode(response)["status"] == 1) {
      communityModelBySerachKey.value = communityModelFromJson(response);

      return;
    }
    communityModelBySerachKey.value = communityModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }
    getSearchDataListNetworkApi(
      String searchKey, String post_category_master_id) async
     {

    var response = await BaseClient()
        .get(getCommunity_search +
        "?lng=eng&limit=100&page=0&user_id=${_storage.read(AppConstant.id)}&searchkey=${searchKey}&post_category_master_id=${post_category_master_id}")
        .catchError(BaseController().handleError);

    if (jsonDecode(response)["status"] == 1) {
      communityModelBySerachKey.value = communityModelFromJson(response);

      return;
    }
    communityModelBySerachKey.value = communityModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }






  getArticleBySearchKeyNetworkApi(
      String searchkey, String state_id, String post_category_id) async {
    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .get(getArticalApi +
            "?lng=eng&csc_id=8&post_category_id=${post_category_id}&state_id=${state_id}&searchkey=${searchkey}")
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    if (jsonDecode(response)["status"] == 1) {
      articleModelWithSearchKey.value = articleModelFromJson(response);

      return;
    }
    articleModelWithSearchKey.value = articleModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getCertificateListNetworkApi() async {
    var response = await BaseClient()
        .get(getMyCertificate +
            "?lng=eng&limit=200&page=0&user_id=${_storage.read(AppConstant.id)}")
        .catchError(BaseController().handleError);
    if (jsonDecode(response)["status"] == 1) {
      certificateModel.value = certificateModelFromJson(response);

      return;
    }
    certificateModel.value = certificateModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getcommunityShareNetworkApi(String community_id) async {
    var response = await BaseClient()
        .get(getcommunityShare +
            "?lng=eng&user_id=${_storage.read(AppConstant.id)}&community_id=${community_id}")
        .catchError(BaseController().handleError);

    if (jsonDecode(response)["status"] == 1) {
      shareModel.value = likeDisLikeFromJson(response);

      return;
    }
    shareModel.value = likeDisLikeFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getServicesGovernmentNetworkApi(String state_id) async {
    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .get(getServicesGovernment +
            "?lng=eng&limit=200&page=0&state_id=${state_id}")
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    if (jsonDecode(response)["status"] == 1) {
      governmentServiceModel.value = serviceModelFromJson(response);
      return;
    }
    governmentServiceModel.value = serviceModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getServicesGovernmentSubCategoryNetworkApi(
      String service_master_parentId, String title) async {
    var response = await BaseClient()
        .get(getServicesGovernment +
            "?lng=eng&limit=200&page=0&state_id=${""}&service_master_parent=${service_master_parentId}")
        .catchError(BaseController().handleError);
    if (jsonDecode(response)["status"] == 1) {
      serviceCategoryModel.value = serviceCategoryModelFromJson(response);
      Get.to(SubCategoryOfServices(title, "1"));

      return;
    }
    serviceCategoryModel.value = serviceCategoryModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getServicesGovernmentSubCategoryOfCategoryNetworkApi(
      String service_master_parentId, String title) async {
    var response = await BaseClient()
        .get(getServicesGovernment +
            "?lng=eng&limit=200&page=0&state_id=${""}&service_master_parent=${service_master_parentId}")
        .catchError(BaseController().handleError);
    if (jsonDecode(response)["status"] == 1) {
      serviceCategoryModel1.value = serviceCategoryModelFromJson(response);
      Get.to(SubCategoryOfCategoryServices(title, "1"));

      return;
    }
    serviceCategoryModel1.value = serviceCategoryModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getServicesGovernmentSubCategoryOfCategoryThirdLevelNetworkApi(
      String service_master_parentId, String title) async {
    var response = await BaseClient()
        .get(getServicesGovernment +
            "?lng=eng&limit=200&page=0&state_id=${""}&service_master_parent=${service_master_parentId}")
        .catchError(BaseController().handleError);
    if (jsonDecode(response)["status"] == 1) {
      serviceCategoryModel2.value = serviceCategoryModelFromJson(response);
      Get.to(ThirdLevelOfServicesimport(title));

      return;
    }
    serviceCategoryModel2.value = serviceCategoryModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getServicesCSCNetworkApi() async {
    Get.context!.loaderOverlay.show();

    var response = await BaseClient()
        .get(getServicesCSC + "?lng=eng&limit=200&page=0")
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    if (jsonDecode(response)["status"] == 1) {
      serviceCSCModel.value = serviceModelFromJson(response);
      return;
    }
    serviceCSCModel.value = serviceModelFromJson(response);
    //BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getServicesCSCSubCategoryNetworkApi(
      String service_master_parentId, String title) async {
    var response = await BaseClient()
        .get(getServicesCSC +
            "?lng=eng&limit=200&page=0&service_master_parent=${service_master_parentId}")
        .catchError(BaseController().handleError);
    if (jsonDecode(response)["status"] == 1) {
      serviceCategoryModel.value = serviceCategoryModelFromJson(response);
      Get.to(SubCategoryOfServices(title, "2"));

      return;
    }
    serviceCategoryModel.value = serviceCategoryModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getServicesCSCSubCategoryOfCategoryNetworkApi(
      String service_master_parentId, String title) async {
    var response = await BaseClient()
        .get(getServicesCSC +
            "?lng=eng&limit=200&page=0&service_master_parent=${service_master_parentId}")
        .catchError(BaseController().handleError);
    if (jsonDecode(response)["status"] == 1) {
      serviceCategoryModel1.value = serviceCategoryModelFromJson(response);
      Get.to(SubCategoryOfCategoryServices(title, "2"));

      return;
    }
    serviceCategoryModel1.value = serviceCategoryModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getServicesCSCSSubCategoryOfCategoryThirdLevelNetworkApi(
      String service_master_parentId, String title) async {
    print("shdfhdfghkdgetServicesSubCategoryOfCategoryNetworkApi" +
        service_master_parentId);
    var response = await BaseClient()
        .get(getServicesCSC +
            "?lng=eng&limit=200&page=0&service_master_parent=${service_master_parentId}")
        .catchError(BaseController().handleError);
    if (jsonDecode(response)["status"] == 1) {
      print("fjghkjfdgh" + response);
      serviceCategoryModel2.value = serviceCategoryModelFromJson(response);
      Get.to(ThirdLevelOfServicesimport(title));

      return;
    }
    serviceCategoryModel2.value = serviceCategoryModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getFeedArticalNetworkApi(String searchkey)
  async {
    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .get(getFeedArtical + "?lng=eng&limit=${20}&page=${0}&searchkey=${searchkey}")
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    if (jsonDecode(response)["status"] == 1)
    {
      feedArticalModel.value = feedArticalModelFromJson(response);

      isLoadingPageArtical.value = true;
      isLoadingVleNewsPage.value = true;
      setCategoryOfArtical.value = 1;
      return;
    }
    feedArticalModel.value = feedArticalModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getreportPostApiNetworkApi() async {
    var response = await BaseClient()
        .get(getPostReport + "?lng=eng&limit=100&page=0")
        .catchError(BaseController().handleError);
    if (jsonDecode(response)["status"] == 1) {
      print("fjghkjfdgh" + response);
      reportPostApi.value = reportPostApiFromJson(response);
      return;
    }
    reportPostApi.value = reportPostApiFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  Future<bool> postReportNetworkApi(
      String post_report_id, String community_id) async {
    var bodyRequest = {
      "lng": language,
      "user_id": _storage.read(AppConstant.id),
      "post_report_id": post_report_id,
      "community_id": community_id
    };

    print(bodyRequest);

    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .post(postPostReport, bodyRequest)
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("dfbijbdkbd");
    print(response);
    if (jsonDecode(response)["status"] == 1) {
      BaseController().successSnack("Report" + jsonDecode(response)["message"]);
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  getReferalPointsDetailNetworkApi() async
  {
    print('kjdfghkj');
    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .get(getReferalPointsDetail + "?lng=eng")
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    if (jsonDecode(response)["status"] == 1) {
      referalModel.value = referalModelFromJson(response);
      Get.to(() => ReferAndEarn());
      return;
    }
    referalModel.value = referalModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }
  RxString pointData="0".obs;
  getgetUserDetailsNetworkApi() async
  {

    var response = await BaseClient()
        .get(getUserDetails + "?lng=eng&ID=${_storage.read(AppConstant.id)}")
        .catchError(BaseController().handleError);
     if (jsonDecode(response)["status"].toString() == "1")
     {
       print("");
        points = jsonDecode(response)["Data"]["points"] ?? "";
       pointData.value=jsonDecode(response)["Data"]["points"] ?? "";
       dob = jsonDecode(response)["Data"]["dob"] ?? "";
      _storage.write(AppConstant.points, jsonDecode(response)["Data"]["points"]??"");
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
       _storage.write(AppConstant.dob, jsonDecode(response)["Data"]["dob"]??"");




      userDetails.value = userDetailsFromJson(response);
      return;
    }
    userDetails.value = userDetailsFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }



  getBankListNetworkApi() async {
    var response = await BaseClient()
        .get(getBankList + "?lng=eng")
        .catchError(BaseController().handleError);
    if (jsonDecode(response)["status"].toString() == "1")
    {
      bankModel.value = bankModelFromJson(response);
      return;
    }
    bankModel.value = bankModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

//
  Future<bool> postRedeemNetworkApi(String rdeemType) async {





    var bodyRequest =
    {
      "lng": language,
      "user_id": _storage.read(AppConstant.id),
      "amount": etAmount.text.toString(),
      "redeem_type":rdeemType.toString() ,
      "upi_id":etupiId.text.toString().trim() ,
      "bank_master_id":etSate.text.toString().trim() ,
      "branch": etBranchName.text.toString().trim(),
      "ifsc_code":etIFSCECODE.text.toString().trim() ,
      "address":  etAddress.text.toString().trim(),
      "remark": etSignature.text.toString().trim(),
    };

    print(bodyRequest);

    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .post(postRedeem, bodyRequest)
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("dfbijbdkbd");
    print(response);
    if (jsonDecode(response)["status"] == 1) {
      BaseController().successSnack("Report" + jsonDecode(response)["message"]);
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }
//getRedeemList


  getRedeemListNetworkApi() async {
    var response = await BaseClient()
        .get(getRedeemList + "?lng=eng&user_id=${_storage.read(AppConstant.id)}")
        .catchError(BaseController().handleError);
    if (jsonDecode(response)["status"].toString() == "1")
    {
      redeemPointsModel.value = redeemPointsModelFromJson(response);
      return;
    }
    redeemPointsModel.value = redeemPointsModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }
  getSettingsNetworkApi() async {
    var response = await BaseClient()
        .get(getSettings + "?lng=eng")
        .catchError(BaseController().handleError);
    if (jsonDecode(response)["status"].toString() == "1")
    {
      settingModel.value=settingModelFromJson(response);
      return;
    }
    settingModel.value = settingModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }
  getPointsMaster_listNetworkApi() async
  {
    var response = await BaseClient()
        .get(getPointsMaster_list + "?lng=eng&user_id=${_storage.read(AppConstant.id)}")
        .catchError(BaseController().handleError);
    if (jsonDecode(response)["status"].toString() == "1")
    {
      pointsModelDetails.value = pointsModelDetailsFromJson(response);
      return;
    }
    pointsModelDetails.value = pointsModelDetailsFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }







  setupRemoteConfig() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    final  remoteConfig = FirebaseRemoteConfig.instance;
    remoteConfig.setConfigSettings(
        RemoteConfigSettings(fetchTimeout: Duration(seconds: 10), minimumFetchInterval: Duration.zero)
    );
    await remoteConfig.fetch();
    await remoteConfig.activate();
    if(remoteConfig.getValue(AppConstant.vleSocietyUpdate).asBool())
    {

      if(version!=remoteConfig.getValue(AppConstant.vleSocietyVersion).asString() && remoteConfig.getValue(AppConstant.forceFully).asBool() )
      {
        _forceFullyupdate(remoteConfig.getString(AppConstant.vleSocietyUrl),remoteConfig.getString(AppConstant.vleSocietyMessage));
        return;
      }
      if(version!=remoteConfig.getValue(AppConstant.vleSocietyVersion).asString())
      {
        _update(remoteConfig.getString(AppConstant.vleSocietyUrl),remoteConfig.getString(AppConstant.vleSocietyMessage));
        return;
      }

    }

    //  print(remoteConfig.getValue('version').asString());

  }
  void _update(String url,String Message) {
    showCupertinoDialog(
        context: Get.context!,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: const Text('Update ! '),
            content:  Text(Message),
            actions: [
              // The "Yes" button
              CupertinoDialogAction(
                onPressed: () {
                  Get.back();
                },
                child: const Text('May be later'),
                isDefaultAction: true,
                isDestructiveAction: true,
              ),
              // The "No" button
              CupertinoDialogAction(
                onPressed: () {
                  _lunchInBrowser(url);
                },
                child: const Text('Install'),
                isDefaultAction: false,
                isDestructiveAction: false,
              )
            ],
          );
        });
  }


  void _forceFullyupdate(String url,String Message) {
    showCupertinoDialog(
        context: Get.context!,
        barrierDismissible: true,
        builder: (BuildContext ctx) {
          return WillPopScope(onWillPop: ()async{
            return false;
          },
            child: CupertinoAlertDialog(
              insetAnimationCurve: Curves.easeInOutCubic,
              insetAnimationDuration:Duration(milliseconds: 600),
              title: const Text('Update required !',),
              content:  Text(Message),
              actions: [
                // The "Yes" button

                // The "No" button
                CupertinoDialogAction(
                  onPressed: () {
                    _lunchInBrowser(url);
                  },
                  child: const Text('Install'),
                  isDefaultAction: false,
                  isDestructiveAction: false,
                )
              ],
            ),
          );
        });
  }
  Future<void> _lunchInBrowser(String url) async
  {
    if(await canLaunch(url))
    {
      await launch(url,forceSafariVC: false,forceWebView: false,
          headers: <String,String>{"headesr_key":  "headers_value"}
      );

    }
    else{
      throw "url not lunched $url";
    }
  }




}
