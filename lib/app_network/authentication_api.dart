
import 'package:get/get.dart';
import '../authentication/authentication_controller.dart';

AuthenticationController authenticationController = Get.find();
//
// Future<LoginModel?> logInApi(Map<String, dynamic> map) async {
//   var result;
//
//   try {
//     Dio dio = network.getDio();
//     result = await dio.post('login', data: map);
//     log(result.toString());
//   } on DioException catch (e) {
//     log(e.toString());
//   }
//   if (result != null) {
//     LoginModel loginModel = LoginModel.fromJson(result.data);
//
//     if (loginModel.status ?? false) {
//       GetStorage box = GetStorage("Auth");
//       box.write('user', loginModel.token);
//
//       log("CURRENTUSER FROM BOX: ${box.read('user')}");
//       authenticationController.state = Authenticated(user: loginModel.token!);
//     }
//     log(loginModel.message.toString());
//     return loginModel;
//   }
//   return null;
// }


