import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:vlesociety/AppConstant/AppConstant.dart';
import 'package:vlesociety/Dashboard/model/AwardModel.dart';
import 'package:vlesociety/Dashboard/model/BannerModel.dart';
import 'package:vlesociety/Dashboard/model/FeedBackModel.dart';
import 'package:vlesociety/Dashboard/model/follow_model.dart';
import '../../AppConstant/APIConstant.dart';
import '../../Auth/controller/login_controller.dart';
import '../../Splash/SplashPage.dart';
import '../../UtilsMethod/BaseController.dart';
import '../../UtilsMethod/base_client.dart';
import '../model/AboutCscModel .dart';
import '../model/AnswerModel.dart';
import '../model/ArticalModel.dart';
import '../model/AwardsModel.dart';
import '../model/CertificateModel.dart';
import '../model/CommunityCategoryModel.dart';
import '../model/CommunityModel.dart';
import '../model/FaqModel.dart';
import '../model/FeedArticalModel.dart';
import '../model/GovernMentServices.dart';
import '../model/LikeDislike.dart';
import '../model/NotificationModel.dart';
import '../model/PressMediaData.dart';
import '../model/PressMrdiaDetailsModel.dart';
import '../model/PrivacyModel .dart';
import '../model/QuizModel.dart';
import '../model/Quiz_Model/ContestQuize.dart';
import '../model/Quiz_Model/quizq_model.dart';
import '../model/ReportPostApi.dart';
import '../model/SearchKeyModel.dart';
import '../model/ServiceCategoryModel.dart';
import '../model/ServiceModel.dart';
import '../model/TestimonialModel.dart';
import '../model/TransactionsModel.dart';
import '../view/ArticalSearch.dart';
import '../view/Community.dart';
import '../view/SearchScreen.dart';
import '../view/SubCategoryOfCategoryServices.dart';
import '../view/SubCategoryOfServices.dart';
import '../view/ThirdLevelOfServices.dart';
import '../view/notification.dart';
import '../view/profile/AboutCSC.dart';
import '../view/profile/Awards.dart';
import '../view/profile/Certificates.dart';
import '../view/profile/FCQ.dart';
import '../view/profile/PressMediaDetails.dart';
import '../view/profile/PressMida.dart';
import '../view/profile/testimonials.dart';
import '../view/profile/transaction.dart';
class followContrller extends GetxController{
  bool follow=false;
  void likee(){
    follow=!follow;
    update();
  }
}

class DashboardController extends GetxController {
  final ScrollController scrollController=ScrollController();
  final ScrollController scrollController1=ScrollController();

  int start=0;
  int end=10;

  RxInt selectedIndex = 0.obs;
  RxInt selectedIndexOfArtical = 0.obs;
  RxInt selectedComunityIndex = 0.obs;
  RxInt selectedServicesIndex = 0.obs;
  RxBool isCategorySelected = false.obs;
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
  var followModel = FollowModel().obs;
  var feedArticalModel = FeedArticalModel().obs;
  var likeDislike = LikeDisLike().obs;
  var shareModel = LikeDisLike().obs;
  var governMentServices = GovernMentServices().obs;
  var faqModel = FaqModel().obs;
  var contestQuize = ContestQuize().obs;
  var reportPostApi = ReportPostApi().obs;
  var notificationModel = NotificationModel().obs;
  var certificateModel = CertificateModel().obs;
  //var searchKeyModel = SearchKeyModel().obs;
  var awardsModel = AwardsModel().obs;
  var transactionsModel = TransactionsModel().obs;
  var testimonialModel = TestimonialModel().obs;
  var pressMediaData = PressMediaData().obs;
  var pressMediaDetailsModel = PressMediaDetailsModel().obs;
  var communityCategoryModel = CommunityCategoryModel().obs;
  var privacyModel=PrivacyModel().obs;
  var aboutCscModel=AboutCscModel().obs;
  var feedBackModel=FeedBackModel().obs;
  var awardModel=AwardModel().obs;
  RxInt fileLength = 0.obs;
  List<XFile>? imagesList = [];
  RxString rxMessaage = "".obs;
  TextEditingController etMessage = TextEditingController();
  TextEditingController searchkey = TextEditingController();

  GetStorage _storage = GetStorage();
  String userName = "";
  String email = "";
  String image = "";
  String userType = "";
  RxBool  isLoadingPage=false.obs;
  RxBool  isLoadingPageArtical=false.obs;
  RxBool  isLoadingCSCPage=false.obs;

  RxInt setCategoryOfArtical = 0.obs;
  RxInt setSelectedCategoryOfArtical = 0.obs;

  var articleModel = ArticaleModel().obs;
  var articleModelByCategory = ArticaleModel().obs;
  var articleModelWithFilter= ArticaleModel().obs;
  var articleModelWithSearchKey= ArticaleModel().obs;
  var cscModel = ArticaleModel().obs;

  @override
  void onInit()
  {
    userName = _storage.read(AppConstant.userName)??"";
    email = _storage.read(AppConstant.email)??"";
    image = _storage.read(AppConstant.profileImg)??"";
    userType = _storage.read(AppConstant.userType)??"";
       addItems();
        getBannerNetworkApi();
        getCommunityNetworkApi();
        getreportPostApiNetworkApi();
        getQuizNetworkApi();
        addItemsQuize();
        getFeedArticalNetworkApi("");
        print("dfkjghdfkjhgiueryt"+isLoadingPage.value.toString());
    super.onInit();
  }
  addItems() async
  {
    scrollController.addListener
      (
            ()
    {
      if (scrollController.position.maxScrollExtent == scrollController.position.pixels)
      {

        print("dfkjghdfkjhgidsfsfuersddyt"+isLoadingPageArtical.value.toString());
        print("dfkjghdfkjhgiueryt"+isLoadingPage.value.toString());
        if(isLoadingPage.value && selectedIndex.value==0)
        {

          print("");
             //start=end;
            //end=start+10;
           // print("sdjhdhfg"+communityModel.value.page!.toString());
          //print("dfgdfg"+start.toString());
         // print(""+end.toString());
            start=start+int.parse(communityModel.value.page!.toString());
            //print("dfhgdjfg"+start.toString());
          getCommunityLoadingNetworkApi(start);
        }
        else if(isLoadingPageArtical.value && selectedIndex.value==1 && setSelectedCategoryOfArtical.value==1)
          {
            start=start+int.parse(feedArticalModel.value.page!.toString());
            getFeedArticalLoadingNetworkApi(start);
          }
        else if(isLoadingPage.value && selectedIndex.value==3)
          {
            start=start+int.parse(quizModel.value.page!.toString());
            getQuizeLoadingNetworkApi(start);
          }
        else if(isLoadingPageArtical.value && selectedIndex.value==1 &&setSelectedCategoryOfArtical.value==2 )
          {
            start=start+int.parse(articleModel.value.page!.toString());
            getArticalLoadingNetworkApi(start);
          }

      }
    });
  }



  addItemsQuize() async
  {
    scrollController1.addListener
      (
            ()
        {
          if (scrollController1.position.maxScrollExtent == scrollController1.position.pixels)
          {
            print("djkfghj"+isLoadingPage.value.toString());
            if(isLoadingPage.value)
            {
              start=start+int.parse(quizModel.value.page!.toString());

              print("dfhgdjvcvdffdgffdgbbfg"+start.toString());
              getQuizeLoadingNetworkApi(start);
            }

          }
        });
  }


  RxList reportMessageList =
      [
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

    if (jsonDecode(response)["status"] == 1) {
      bannerModel.value = bannerModelFromJson(response);
      return;
    }
      BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getCommunityLoadingNetworkApi(int end) async
  {
    print("dfjgfdkjg"+end.toString());
    var response = await BaseClient()
        .get(getCommunityApi +
        "?lng=eng&user_id=${_storage.read(AppConstant.id)}&limit=${10}&page=${end}")
        .catchError(BaseController().handleError);

    if (jsonDecode(response)["status"] == 1)
    {
      if(isLoadingPage.value==true)
      {
        communityModel.value.data!.addAll(communityModelFromJson(response).data!);
        //controller.end=controller.communityModel.value.page!;
        communityModel.refresh();
      }
    }
    else{
      isLoadingPage.value=false;
      Fluttertoast.showToast(msg: "No more data availabel ! ");
    }

  }

  getFeedArticalLoadingNetworkApi(int end) async
  {
    print("dfjgfdkjg"+end.toString());
    var response = await BaseClient().get(getFeedArtical +
        "?lng=eng&limit=${20}&page=${end}")
        .catchError(BaseController().handleError);


    if (jsonDecode(response)["status"] == 1)
    {
      if(isLoadingPageArtical.value==true)
      {
        feedArticalModel.value.data!.addAll(feedArticalModelFromJson(response).data!);
        feedArticalModel.refresh();
      }
    }
    else{
      isLoadingPageArtical.value=false;
      Fluttertoast.showToast(msg: "No more data availabel ! ");
    }

  }

  getArticalLoadingNetworkApi(int end) async
  {

    var response = await BaseClient().get(getArticalApi +
        "?lng=eng&limit=${20}&page=${end}")
        .catchError(BaseController().handleError);
    if (jsonDecode(response)["status"] == 1)
     {
      if(isLoadingPageArtical.value==true)
      {
        articleModel.value.data!.addAll(articleModelFromJson(response).data!);
        articleModel.refresh();
      }
    }
    else{
      isLoadingPageArtical.value=false;
      Fluttertoast.showToast(msg: "No more data availabel ! ");
    }

  }





  //Community
  getCommunityNetworkApi() async
  {
    var response = await BaseClient()
        .get(getCommunityApi +
        "?lng=eng&user_id=${_storage.read(AppConstant.id)}&limit=${10}&page=${0}")
        .catchError(BaseController().handleError);
    if (jsonDecode(response)["status"] == 1)
    {
      communityModel.value = communityModelFromJson(response);
      isLoadingPage.value=true;
      start=0;
      end=10;
      print("vdvbidbvdv");
      print(start);
      print(end);
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

  getCommmunityCategoryNetworkApi() async
  {

    final  data = {
      "id": 0,
      "title": "feed",
      "image": "",
      "followStatus": "",
    };



    var response = await BaseClient()
        .get(getCommunityCategorryApi +
            "?lng=eng&user_id=${_storage.read(AppConstant.id)}&limit=200&page=0")
        .catchError(BaseController().handleError);
    if (jsonDecode(response)["status"] == 1)
    {



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
      BaseController().successSnack(jsonDecode(response)["message"]);
      getAnswerNetworkApi(communityId);
      return;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  Future<bool> postCommunityAnswerNetworkApi(
      String message, String communityId) async {
    var bodyRequest = {
      "lng": language,
      "user_id":_storage.read(AppConstant.id),
      "community_id": communityId,
      "answer": message
    };
    print("dfbijbdkbd");
    print(bodyRequest);

    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .post(postCommunityAnswerApi, bodyRequest)
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("dfbijbdkbd");
    print(response);
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
        .postMultiple(postFeedBack, imagesList!,
        _storage.read(AppConstant.id), catid, msg)
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();

    if (jsonDecode(response)["status"] == 1)
    {
      print("sngyfsdvtyf"+response) ;
      BaseController().successSnack("FeedBack has been successfuly");
      return;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }


  logout()
  {

    _storage.remove(AppConstant.userType);
    _storage.remove(AppConstant.id);
    _storage.remove(AppConstant.userId);
    _storage.remove(AppConstant.userName);
    _storage.remove(AppConstant.profileImg);
    _storage.remove(AppConstant.email);
    _storage.remove(AppConstant.phone);
    _storage.remove(AppConstant.block);
    _storage.remove(AppConstant.zip);
    Get.delete<LoginController>();
    print("sddfgfdgfhfgh"+ _storage.remove(AppConstant.userType).toString());
    Get.off(() => SplashPage());
  }

  void selectMultipleImage() async {
    final ImagePicker _picker = ImagePicker();
    List<XFile>? imagesList2 = await _picker.pickMultiImage(
        imageQuality: 60, requestFullMetadata: true);
    if (imagesList2.isNotEmpty) {
      fileLength.value = imagesList2.length;
      imagesList = imagesList2;
    }
  }

  getAskApi() async {
    var response = await BaseClient()
        .get(getMyAsk +
            "?lng=eng&user_id=${_storage.read(AppConstant.id)}&limit=100&page=0")
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("vdsbvkbksdvbs");
    print(response);
    if (jsonDecode(response)["status"] == 1) {
      myAskModel.value = communityModelFromJson(response);
      return;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

//api/Dashboard/getArtical?lng=eng&csc_id=8
  getArticleNetworkApi()
  async {

    var response = await BaseClient()
        .get(getArticalApi + "?lng=eng")
        .catchError(BaseController().handleError);
    if (jsonDecode(response)["status"] == 1)
     {
       articleModel.value = articleModelFromJson(response);

       if(articleModel.value.page!>=9)
         {
          isLoadingPageArtical.value=true;
           setCategoryOfArtical.value=2;
         }


      return;
    }
    articleModel.value = articleModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }
  getArticleByCategoryNetworkApi(String cat_id)
  async
  {
    var response = await BaseClient().get(getArticalApi + "?lng=eng&csc_id=8&post_category_id=${cat_id}").
    catchError(BaseController().handleError);
    if (jsonDecode(response)["status"] == 1)
    {
      print("sjhbghsdasd"+response);
      articleModelByCategory.value = articleModelFromJson(response);

      return;
    }
    articleModelByCategory.value = articleModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }
  getArticleWithFilterNetworkApi(String cat_id,String state_id)
  async
  {
    var response = await BaseClient().get(getArticalApi + "?lng=eng&csc_id=8&post_category_id=${cat_id}&state_id=${state_id}").catchError(BaseController().handleError);
    if (jsonDecode(response)["status"] == 1)
    {
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
    print("vdfvsds");
    print(response);
    if (jsonDecode(response)["status"] == 1) {
      cscModel.value = articleModelFromJson(response);
      return;
    }
    cscModel.value = articleModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }
  getQuizNetworkApi() async {
    var response = await BaseClient()
        .get(getQuizApi + "?lng=eng&limit=${5}&page=${0}")
        .catchError(BaseController().handleError);
    print("vdfvsds");
    print(response);
    if (jsonDecode(response)["status"] == 1)
    {
      quizModel.value = quzeModelFromJson(response);
      isLoadingPage.value=true;


      return;
    }
    quizModel.value = quzeModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }
  getQuizeLoadingNetworkApi(int end) async
  {
    print("dfjgfdkjg"+end.toString());
    var response = await BaseClient().get(getQuizApi +
        "?lng=eng&limit=${5}&page=${end}")
        .catchError(BaseController().handleError);
    if (jsonDecode(response)["status"] == 1)
    {
      if(isLoadingPage.value==true)
      {
        quizModel.value.data!.addAll(quzeModelFromJson(response).data!);
        quizModel.refresh();
      }
    }
    else{
      isLoadingPage.value=false;
      Fluttertoast.showToast(msg: "No more data availabel ! ");
    }
  }

  getQuizContestNetworkApi()
  async {
    var response = await BaseClient()
        .get(getQuizApi + "?lng=eng&limit=200&page=0&quiz_type=2")
        .catchError(BaseController().handleError);
    print("vdfvsds");
    print(response);
    if (jsonDecode(response)["status"] == 1) {
      quizModelContest.value = quzeModelFromJson(response);
      return;
    }
    quizModelContest.value = quzeModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }




  getServiceNetworkApi() async
  {
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().get(getServicesApi + "?lng=eng&limit=200&page=0").catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    if (jsonDecode(response)["status"] == 1)
    {
      serviceModel.value = serviceModelFromJson(response);
      return;
    }
    serviceModel.value = serviceModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);


  }
  getServicesSubCategoryNetworkApi(String service_master_parentId,String title) async
  {
    print("shdfhdfghkd"+service_master_parentId);
    var response = await BaseClient().get(getServicesApi + "?lng=eng&limit=200&page=0&service_master_parent=${service_master_parentId}").catchError(BaseController().handleError);
    if (jsonDecode(response)["status"] == 1)
    {
      print("fjghkjfdgh"+response);
      serviceCategoryModel.value = serviceCategoryModelFromJson(response);
      Get.to(SubCategoryOfServices(title,"0"));

      return;
    }
    serviceCategoryModel.value = serviceCategoryModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);


  }
  getServicesSubCategoryOfCategoryNetworkApi(String service_master_parentId,String title) async
  {
    print("shdfhdfghkdgetServicesSubCategoryOfCategoryNetworkApi"+service_master_parentId+"hii");
    var response = await BaseClient().get(getServicesApi + "?lng=eng&limit=200&page=0&service_master_parent=${service_master_parentId}").catchError(BaseController().handleError);
    if (jsonDecode(response)["status"] == 1)
    {
      print("fjghkjfdgh"+response);
      serviceCategoryModel1.value = serviceCategoryModelFromJson(response);
    Get.to(SubCategoryOfCategoryServices(title,"0"));

      return;
    }
    serviceCategoryModel1.value = serviceCategoryModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);


  }
  getServicesSubCategoryOfCategoryThirdLevelNetworkApi(String service_master_parentId,String title) async
  {
    print("shdfhdfghkdgetServicesSubCategoryOfCategoryNetworkApi"+service_master_parentId);
    var response = await BaseClient().get(getServicesApi + "?lng=eng&limit=200&page=0&service_master_parent=${service_master_parentId}").catchError(BaseController().handleError);
    if (jsonDecode(response)["status"] == 1)
    {
      print("fjghkjfdgh"+response);
      serviceCategoryModel2.value = serviceCategoryModelFromJson(response);
      Get.to(ThirdLevelOfServicesimport(title));

      return;
    }
    serviceCategoryModel2.value = serviceCategoryModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }
  getfollowNetworkApi(String follow_user_id,String status )
  async {
  print(follow_user_id+"  "+_storage.read(AppConstant.id));
  var response = await BaseClient()
        .get(getFollowApi + "?lng=eng&user_id=${_storage.read(AppConstant.id)}&follow_user_id=${follow_user_id}&status=${status}")
        .catchError(BaseController().handleError);
    print("vdfnnvsds"+response);
    if (jsonDecode(response)["status"] == 1)
    {
      followModel.value = followModelFromJson(response);
      return;
    }
    followModel.value = followModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  gettransactionHistoryDetails()
  async {

   Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .get(gettransactionHistory + "?lng=eng&user_id=${_storage.read(AppConstant.id)}&limit=200&page=0")
        .catchError(BaseController().handleError);
   Get.context!.loaderOverlay.hide();

    if (jsonDecode(response)["status"] == 1)
    {transactionsModel.value = transactionsModelFromJson(response);
      Get.to(transaction());
      return;
    }
    transactionsModel.value = transactionsModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }
  getTestimonialsData()
  async {

    var response = await BaseClient()
        .get(getTestimonialslist + "?lng=eng&limit=200&page=0")
        .catchError(BaseController().handleError);

    if (jsonDecode(response)["status"] == 1)
    {
       print("hxgdjgdhg"+response);
      testimonialModel.value = testimonialModelFromJson(response);
       Get.to(()=>Tesimonials());
      return;
    }
    testimonialModel.value = testimonialModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }
  getPressMediataListNetWorkApi()
  async {

    var response = await BaseClient()
        .get(getPressMedia + "?lng=eng&limit=200&page=0")
        .catchError(BaseController().handleError);

    if (jsonDecode(response)["status"] == 1)
    {
      print("pressmedia"+response);
      pressMediaData.value = pressMediaDataFromJson(response);
     Get.to(()=>PressMedia());
      return;
    }
    pressMediaData.value = pressMediaDataFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getPressMediaDetailsNetWorkApi(String pressMedia_id)
  async {

    var response = await BaseClient()
        .get(getPressMediaDetails + "?lng=eng&limit=200&page=0&pressMedia_id=${pressMedia_id}")
        .catchError(BaseController().handleError);

    if (jsonDecode(response)["status"] == 1)
    {
      print("shdfgdjfhg"+response);
      pressMediaDetailsModel.value = pressMediaDetailsModelFromJson(response);

      Get.to(()=>PressMediaDetails());
      return;
    }
    pressMediaDetailsModel.value = pressMediaDetailsModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }
  getAboutCscNetworkApi() async {
    var response = await BaseClient()
        .get(getAboutCsc + "?lng=eng")
        .catchError(BaseController().handleError);
    print("vdfvsds");

    if (jsonDecode(response)["status"] == 1) {
      print("bhudfyug"+response);
      aboutCscModel.value = aboutCscModelFromJson(response);
      Get.to(()=>AboutCSC());
      return;
    }
    aboutCscModel.value = aboutCscModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }
  getPrivacyNetworkApi() async {
    var response = await BaseClient()
        .get(getPrivacy + "?lng=eng")
        .catchError(BaseController().handleError);

    if (jsonDecode(response)["status"] == 1) {

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
      print("sdhvudgfufyeg"+response);
      awardModel.value = awardModelFromJson(response);
      return;
    }
    awardModel.value = awardModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getComunitylikeDislikeNetworkApi(String community_id,String status) async
  {
    print("dfjghkfdghkj"+community_id+"  "+status+ "     "  +_storage.read(AppConstant.id));
    var response = await BaseClient()
        .get(getCommunitylikeDislike + "?lng=eng&user_id=${_storage.read(AppConstant.id)}&community_id=${community_id}&status=${status}")
        .catchError(BaseController().handleError);

    if (jsonDecode(response)["status"] == 1) {
print("dsghgdjf"+response);
      likeDislike.value = likeDisLikeFromJson(response);
      return;
    }
    likeDislike.value = likeDisLikeFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }
  getFaQNetworkApi() async
  {
    var response = await BaseClient()
        .get(getFaq + "?lng=eng&limit=200&page=0")
        .catchError(BaseController().handleError);

    if (jsonDecode(response)["status"] == 1) {
      print("dsghgdjf"+response);
      faqModel.value = faqModelFromJson(response);
      Get.to(Faq());
      return;
    }
    faqModel.value = faqModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }
  getQuizAwardListNetworkApi() async
  {
    var response = await BaseClient()
        .get(getQuizAwardList + "?lng=eng&limit=200&page=0")
        .catchError(BaseController().handleError);

    if (jsonDecode(response)["status"] == 1) {
      print("dsghgdjf"+response);
      contestQuize.value = contestQuizeFromJson(response);
      //Get.to(Faq());
      return;
    }
    contestQuize.value = contestQuizeFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  Future<bool> postAppFeedbackNetworkApi(String message,String rating) async {
    print("dfjhjfdgjhgjhf"+message+"    "+rating);
    var bodyRequest =
    {
      "lng": language,
      "user_id":_storage.read(AppConstant.id),
      "rating": rating,
      "description": message
    };

    print(bodyRequest);

    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .post(postFeedback, bodyRequest)
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("dfbijbdkbd");
    print(response);
    if (jsonDecode(response)["status"] == 1)
    {
      BaseController().successSnack(jsonDecode(response)["message"]);
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  getNotificationListNetworkApi() async
  {
    print("dfbijbdkbd"+_storage.read(AppConstant.id));
    var response = await BaseClient()
        .get(getNotificationList + "?lng=eng&limit=200&page=0&user_id==${_storage.read(AppConstant.id)}")
        .catchError(BaseController().handleError);

    if (jsonDecode(response)["status"] == 1) {
      print("dsghgdjf"+response);
      notificationModel.value = notificationModelFromJson(response);
      Get.to(()=>notification());
      return;
    }
    notificationModel.value = notificationModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }
  getSearchListNetworkApi(String searchKey,String post_category_master_id) async
  {

 //   Get.context!.loaderOverlay.show();

    var response = await BaseClient()
        .get(getCommunity_search + "?lng=eng&limit=10&page=0&user_id=${_storage.read(AppConstant.id)}&searchkey=${searchKey}&post_category_master_id=${post_category_master_id}")
        .catchError(BaseController().handleError);
   // Get.context!.loaderOverlay.hide();
    if (jsonDecode(response)["status"] == 1)
    {
      communityModelBySerachKey.value = communityModelFromJson(response);

      return;
    }
    communityModelBySerachKey.value = communityModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getArticleBySearchKeyNetworkApi(String searchkey,String state_id,String post_category_id)
  async
  {
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().get(getArticalApi +"?lng=eng&csc_id=8&post_category_id=${post_category_id}&state_id=${state_id}&searchkey=${searchkey}").catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    if (jsonDecode(response)["status"] == 1)
    {
      articleModelWithSearchKey.value = articleModelFromJson(response);
      Get.to(ArticalSearch());
      return;
    }
    articleModelWithSearchKey.value = articleModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getCertificateListNetworkApi() async
  {
    print("dfbijbdkbd"+_storage.read(AppConstant.id));
    var response = await BaseClient()
        .get(getMyCertificate + "?lng=eng&limit=200&page=0&user_id=${_storage.read(AppConstant.id)}")
        .catchError(BaseController().handleError);
    print("dfbisdfdfgfdgjbdkbd"+response);
    print("dfbisdfdfgfdgjbdkbd"+getMyCertificate + "?lng=eng&limit=200&page=0&user_id=${_storage.read(AppConstant.id)}");
    if (jsonDecode(response)["status"] == 1)
    {
      print("dsghgdjf"+response);
      certificateModel.value = certificateModelFromJson(response);

      return;
    }
    certificateModel.value = certificateModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }


  getcommunityShareNetworkApi(String community_id) async
  {

    var response = await BaseClient()
        .get(getcommunityShare + "?lng=eng&user_id=${_storage.read(AppConstant.id)}&community_id=${community_id}")
        .catchError(BaseController().handleError);

    if (jsonDecode(response)["status"] == 1)
    {
      print("dsghgsafsdfdjf"+response);
      shareModel.value = likeDisLikeFromJson(response);

      return;
    }
    shareModel.value = likeDisLikeFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }
  getServicesGovernmentNetworkApi(String state_id) async
  {
    Get.context!.loaderOverlay.show();
   print("dt"+state_id);
    var response = await BaseClient()

        .get(getServicesGovernment + "?lng=eng&limit=200&page=0&state_id=${state_id}")
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    if (jsonDecode(response)["status"] == 1)
    {
      print("ddsfdfggg"+response);
      governmentServiceModel.value = serviceModelFromJson(response);
    print("sdkj"+governmentServiceModel.value.data![0].title.toString());
      return;
    }
    governmentServiceModel.value = serviceModelFromJson(response);
    //BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getServicesGovernmentSubCategoryNetworkApi(String service_master_parentId,String title) async
  {
    print("shdfhdfghkd"+service_master_parentId+"hiii");
    var response = await BaseClient().get(getServicesGovernment + "?lng=eng&limit=200&page=0&state_id=${""}&service_master_parent=${service_master_parentId}").catchError(BaseController().handleError);
    if (jsonDecode(response)["status"] == 1)
    {
      print("fjghkjfdgh"+response);
      serviceCategoryModel.value = serviceCategoryModelFromJson(response);
      Get.to(SubCategoryOfServices(title,"1"));

      return;
    }
    serviceCategoryModel.value = serviceCategoryModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);


  }

  getServicesGovernmentSubCategoryOfCategoryNetworkApi(String service_master_parentId,String title) async
  {
    print("shdfhdfghkdgetServicesSubCategoryOfCategoryNetworkApi"+service_master_parentId);
    var response = await BaseClient().
    get(getServicesGovernment + "?lng=eng&limit=200&page=0&state_id=${""}&service_master_parent=${service_master_parentId}")
        .catchError(BaseController().handleError);
    if (jsonDecode(response)["status"] == 1)
    {
      print("fjghkjfdgh"+response);
      serviceCategoryModel1.value = serviceCategoryModelFromJson(response);
      Get.to(SubCategoryOfCategoryServices(title,"1"));

      return;
    }
    serviceCategoryModel1.value = serviceCategoryModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);


  }
  getServicesGovernmentSubCategoryOfCategoryThirdLevelNetworkApi(String service_master_parentId,String title) async
  {
    print("shdfhdfghkdgetServicesSubCategoryOfCategoryNetworkApi"+service_master_parentId);
    var response = await BaseClient().get(getServicesGovernment + "?lng=eng&limit=200&page=0&state_id=${""}&service_master_parent=${service_master_parentId}").catchError(BaseController().handleError);
    if (jsonDecode(response)["status"] == 1)
    {
      print("fjghkjfdgh"+response);
      serviceCategoryModel2.value = serviceCategoryModelFromJson(response);
      Get.to(ThirdLevelOfServicesimport(title));

      return;
    }
    serviceCategoryModel2.value = serviceCategoryModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }
   getFeedArticalNetworkApi(String searchkey)
   async
  {
    var response = await BaseClient().get(getFeedArtical + "?lng=eng&limit=${20}&page=${0}&searchkey=${searchkey}").catchError(BaseController().handleError);
    if (jsonDecode(response)["status"] == 1)
    {
      feedArticalModel.value = feedArticalModelFromJson(response);
      isLoadingPageArtical.value=true;
      setCategoryOfArtical.value=1;
      return;
    }
    feedArticalModel.value = feedArticalModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }
  getreportPostApiNetworkApi() async
  {
    var response = await BaseClient().get(getPostReport + "?lng=eng&limit=100&page=0").catchError(BaseController().handleError);
    if (jsonDecode(response)["status"] == 1)
    {
      print("fjghkjfdgh"+response);
      reportPostApi.value = reportPostApiFromJson(response);
      return;
    }
    reportPostApi.value = reportPostApiFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  Future<bool> postReportNetworkApi(String post_report_id,String community_id)
  async {

    var bodyRequest =
    {
      "lng": language,
      "user_id":_storage.read(AppConstant.id),
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
    if (jsonDecode(response)["status"] == 1)
    {
      BaseController().successSnack("Report"+jsonDecode(response)["message"]);
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }



}
