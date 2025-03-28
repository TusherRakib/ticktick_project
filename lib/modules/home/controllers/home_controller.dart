import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../authentication/authentication_controller.dart';
import '../../../model/login_model.dart';

class HomeController extends GetxController {
  Rx<User?> user = User().obs;
  AuthenticationController authController = Get.find();
  RxString locationName = ''.obs;

  var eventsList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

  void fetchEvents() async {
    try {
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('events').get();

      eventsList.value = querySnapshot.docs.map((doc) {
        return {
          'name': doc['name'] ?? '',
          'description': doc['description'] ?? '',
          'category': doc['category'] ?? '',
          'event_type': doc['event_type'] ?? '',
          'start_date': doc['start_date'] ?? '',
          'end_date': doc['end_date'] ?? '',
          'location': doc['location'] ?? '',
          'organizer': doc['organizer'] ?? '',
          'rsvp_deadline': doc['rsvp_deadline'] ?? '',
          'ticket_info': doc['ticket_info'] ?? '',
          'seat_type': doc['seat_type'] ?? '',
          'price': doc['price'] ?? '',
          'quantity': doc['quantity'] ?? '',
          'additional_info': doc['additional_info'] ?? '',
          'created_at': doc['created_at'] ?? '',
        };
      }).toList();

      print("Fetched Events: ${eventsList.length}");
    } catch (e) {
      print("Error fetching events: $e");
    }
  }
}
