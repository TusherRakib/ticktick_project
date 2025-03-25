import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
// import 'package:permission_handler/permission_handler.dart';

import '../../../authentication/authentication_controller.dart';
import '../../../model/login_model.dart';

class HomeController extends GetxController {
  Rx<User?> user = User().obs;
  AuthenticationController authController = Get.find();
  RxString locationName = ''.obs;

  // Method to request permission and fetch location
  // Future<void> getCustomerLocation() async {
  //   // Request permission to access location
  //   PermissionStatus permission = await Permission.location.request();
  //
  //   // Check if permission is granted
  //   if (permission.isGranted) {
  //     try {
  //       // Get the current position (latitude and longitude)
  //       Position position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high,
  //       );
  //
  //       // Fetch the location name (reverse geocoding)
  //       List<Placemark> placemarks = await placemarkFromCoordinates(
  //         position.latitude,
  //         position.longitude,
  //       );
  //
  //       if (placemarks.isNotEmpty) {
  //         Placemark placemark = placemarks.first;
  //         // Set the location name (e.g., City, Country)
  //         locationName.value = "${placemark.locality}, ${placemark.country}";
  //       }
  //     } catch (e) {
  //       print("Error getting location: $e");
  //     }
  //   } else {
  //     // If permission is denied, handle the error
  //     print("Location permission denied");
  //     // Optionally, you can also ask the user to open settings to enable the permission
  //     openAppSettings();
  //   }
  // }
}
