import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:vlesociety/Splash/SplashPage.dart';
import 'AppConstant/AppConstant.dart';
import 'Dashboard/view/dashboard.dart';





void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await GetStorage.init();
  runApp(const MyApp());
}
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message)async
{
  await Firebase.initializeApp();
  print(message.notification!.title.toString());
  print(message.notification!.body.toString());
  print(message.data.toString());

}



class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (BuildContext context, Widget? child) {
        return GlobalLoaderOverlay(
          useDefaultLoading: false,
          overlayOpacity: 0.1,
          overlayWidget: Center(
            child: Container(
                height: 41,
                width: 41,
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const CircularProgressIndicator(
                  color: Colors.black,
                  strokeWidth: 3.5,
                )),
          ),
          child: GetMaterialApp(
            title: 'Vle Society',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: GetStorage().read(AppConstant.userName)!=null?
            GetStorage().read(AppConstant.userName).toString().isNotEmpty?HomeDashboard():
            const SplashPage():const SplashPage(),
            debugShowCheckedModeBanner: false,
          ),
        );
      },

    );
  }

}
