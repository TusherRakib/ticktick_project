import 'dart:developer';

import 'package:get/get.dart';

import '../../../app_routes/routes_path.dart';
import '../../../authentication/authentication_service.dart';

class SplashController extends GetxController {
  UserAuthenticationService authenticationState = UserAuthenticationService();

  @override
  Future<void> onReady() async {
    var token = await authenticationState.getCurrentUser();

    log("TOKEN: ${token}");

    Future.delayed(const Duration(seconds: 3)).then(
      (value) => Get.offAllNamed(
        token == "" || token == null || token == "null" ? RoutesPath.logInView : RoutesPath.homeView,
      ),
    );
  }
}
