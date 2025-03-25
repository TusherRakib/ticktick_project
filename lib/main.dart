import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ticktick_project/utils/check_internet.dart';
import 'app_routes/routes.dart';
import 'app_routes/routes_path.dart';
import 'authentication/authentication_controller.dart';
import 'authentication/authentication_service.dart';
import 'firebase_options.dart';
import 'utils/app_colors.dart';
import 'utils/app_theme.dart';

late bool isIntro = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  await GetStorage.init("Auth");
  checkInternetConnection();

  initialize();
  runApp(const MyApp());
}

void initialize() {
  Get.put(
      AuthenticationController(
        Get.put(UserAuthenticationService(), permanent: true),
      ),
      permanent: true);
}

loadSharePre() async {
  // SharedPreferences prefs = await SharedPreferences.getInstance();

  // isIntro = (prefs.getBool('intro') ?? false);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isTokenAvailable = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      color: AppColors.colorPrimary,
      theme: AppTheme.lightTheme(),
      getPages: Routes.routes,
      initialRoute: RoutesPath.splashView,
      debugShowCheckedModeBanner: false,
    );
  }
}

