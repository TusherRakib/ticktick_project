import 'package:get/get.dart';
import 'package:ticktick_project/modules/event_details/controller/event_details_controller.dart';
import 'package:ticktick_project/modules/events/controller/event_controller.dart';


class EventDetailsBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(EventDetailsController());
  }
}
