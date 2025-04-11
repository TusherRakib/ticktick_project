import 'package:get/get.dart';
import 'package:ticktick_project/modules/event_details/bindings/event_details_binding.dart';
import 'package:ticktick_project/modules/event_details/views/event_details_view.dart';
import 'package:ticktick_project/modules/event_details/views/ticket_booking_view.dart';
import '../modules/events/bindings/event_binding.dart';
import '../modules/events/views/event_view.dart';
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
      name: RoutesPath.eventDetailsView,
      binding: EventDetailsBindings(),
      page: () => EventDetailsView(),
    ),
    // GetPage(
    //   name: RoutesPath.ticketBookingsView,
    //   binding: TicketBookingBindings(),
    //   page: () => TicketBookingView(),
    // ),


    GetPage(
      name: RoutesPath.homeView,
      binding: HomeBindings(),
      page: () => HomeView(),
    ),
    GetPage(
      name: RoutesPath.eventView,
      binding: EventBindings(),
      page: () => EventPage(),
    ),
    GetPage(
      name: RoutesPath.logInView,
      binding: LogInBinding(),
      page: () => const LogInView(),
    ),

  ];
}
