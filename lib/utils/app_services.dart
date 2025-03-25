import 'dart:math';
import 'package:get/get.dart';
import 'app_constants.dart';

class AppServices {
  static DeviceType getDeviceType() {
    if (Get.size.shortestSide < 600) {
      log(Get.size.shortestSide);
      return DeviceType.mobile;
    } else if (Get.size.shortestSide > 600 && Get.size.shortestSide < 720) {
      log(Get.size.shortestSide);
      return DeviceType.smallTablet;
    } else {
      log(Get.size.shortestSide);
      return DeviceType.largeTablet;
    }
  }
}
