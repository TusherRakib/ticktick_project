import 'package:get/get.dart';
import '../modules/home/bindings/home_bindings.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_bindings.dart';
import '../modules/login/views/login_view.dart';
import '../modules/signup/bindings/signup_bindings.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/splash/bindings/splash_bindings.dart';
import '../modules/splash/views/splash_view.dart';
import 'routes_path.dart';

class Routes {
  static final List<GetPage> routes = [
    GetPage(
      name: RoutesPath.splashView,
      binding: SplashBinding(),
      page: () => const SplashView(),
    ),
    GetPage(
      name: RoutesPath.signUpView,
      binding: SignupBindings(),
      page: () => SignupPage(),
    ),
    GetPage(
      name: RoutesPath.homeView,
      binding: HomeBindings(),
      page: () => HomeView(),
    ),
    GetPage(
      name: RoutesPath.logInView,
      binding: LogInBinding(),
      page: () => const LogInView(),
    ),

  ];
}
