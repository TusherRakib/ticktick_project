import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../app_routes/routes_path.dart';
import '../modules/login/controllers/login_controller.dart';
import 'authentication_service.dart';
import 'authentication_state.dart';

class AuthenticationController extends GetxController {
  final AuthenticationService _authenticationService;
  final _authenticationStateStream = const AuthenticationState().obs;

  AuthenticationState get state => _authenticationStateStream.value;

  set state(AuthenticationState newState) => _authenticationStateStream.value = newState;

  AuthenticationController(this._authenticationService);

  @override
  void onInit() {
    _getAuthenticatedUser();
    super.onInit();
  }


  Future<void> signOut() async {
    await _authenticationService.signOut();
    await _handleSignOut();
    _authenticationStateStream.value = UnAuthenticated();
  }

  void _getAuthenticatedUser() async {
    _authenticationStateStream.value = AuthenticationLoading();

    final user = await _authenticationService.getCurrentUser();

    if (user == null) {
      _authenticationStateStream.value = UnAuthenticated();
    } else {
      _authenticationStateStream.value = Authenticated(user: user);
    }
  }

  Future<void> _handleSignOut() async {
    try {
      // String? fcmToken = await FirebaseMessaging.instance.getToken();
      // await logOutApi(fcmToken);

      Get.put(LogInController());

      Get.offAllNamed(RoutesPath.logInView);
      GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();

    } catch (exception) {
      log(exception.toString());
    }
  }
}
