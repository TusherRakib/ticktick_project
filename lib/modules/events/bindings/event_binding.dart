import 'package:get/get.dart';
import 'package:ticktick_project/modules/events/controller/event_controller.dart';


class EventBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(EventController());
  }
}
