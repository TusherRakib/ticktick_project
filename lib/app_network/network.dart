import 'dart:developer';
import 'package:get/get.dart';

import '../authentication/authentication_controller.dart';
import '../authentication/authentication_state.dart';
import '../utils/app_constants.dart';

Network network = Network();
//
// BaseOptions options = BaseOptions(
//   /** TODO
//    * Change base url before release
//    **/
//   baseUrl: AppConstants.baseUrlProd,
//   connectTimeout: const Duration(seconds: 600),
//   receiveTimeout: const Duration(seconds: 600),
//   headers: {HttpHeaders.contentTypeHeader: 'application/json'},
// );

class Network {
  AuthenticationController authenticationController = Get.find();

  //
  // Network() {
  //   if (authenticationController.state is Authenticated) {
  //     //String token = (authenticationController.state as Authenticated).user.data?.token ?? '';
  //     //options.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
  //   } else {}
  // }

 /* Dio getDio({bool isFormData = false}) {
    if (authenticationController.state is Authenticated) {
      String token = (authenticationController.state as Authenticated).user.data?.user?.fcmToken ?? '';
      log('Token: ' + token);
      options.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
      options.headers[HttpHeaders.contentTypeHeader] = 'application/json';
      options.headers[HttpHeaders.acceptHeader] = 'application/json';

      if (isFormData) {
        //debugPrint('isFormData: ' + isFormData.toString());
        options.headers[HttpHeaders.contentTypeHeader] = 'multipart/form-data';
      }
    } else {
      log('Api(): UnAuthenticated- No token found');
    }

    return Dio(options);
  }*/
}
