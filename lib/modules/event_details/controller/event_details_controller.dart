import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventDetailsController extends GetxController {
  // --- Event Information ---
  var isFollowing = false.obs;
  final eventDate = "19 September 2025".obs;
  final eventTime = "08:00PM to 11:00PM".obs;
  final eventLocation = "Rogers Arena".obs;
  final eventName = "Eminem World Tour".obs;
  final eventOrganizer = "Star Agency".obs;
  final eventDescription = """
Get ready for a night of raw energy, lyrical genius, and unforgettable moments as Eminem, the rap icon and Detroit’s very own, hits the stage with The Real Slim Shady Tour! From chart-topping hits like Lose Yourself, Rap God, and Without Me to fan-favorite deep cuts, Eminem promises a high-octane performance backed by insane visuals, killer beats, and a hyped crowd.

Join thousands of fans at Motor City Arena for this once-in-a-lifetime experience where fire bars meet fierce passion. Whether you grew up on his rhymes or you're just discovering the legend, this is one show you won’t want to miss.
""".obs;

  void toggleFollow() {
    isFollowing.value = !isFollowing.value;
  }

  // --- Ticket Booking ---
  int selectedDateIndex = 0;
  int selectedTimeIndex = 0;
  List<String> selectedSeats = [];

  final List<DateTime> dates = List.generate(7, (index) {
    return DateTime.now().add(Duration(days: index));
  });

  final List<String> timeSlots = [
    "19:30", "20:00", "20:30", "21:00", "21:30", "22:00"
  ];

  final Map<String, String> seatStatus = {};

  void initializeSeats() {
    for (int row = 0; row < 8; row++) {
      for (int col = 0; col < 8; col++) {
        String seatId = '$row-$col';
        seatStatus[seatId] = "available";
      }
    }

    // Simulate reserved seats
    seatStatus["3-3"] = "reserved";
    seatStatus["3-4"] = "reserved";
    seatStatus["5-2"] = "reserved";
  }

  void toggleSeatSelection(String seatId) {
    if (seatStatus[seatId] == "reserved") return;

    if (seatStatus[seatId] == "selected") {
      seatStatus[seatId] = "available";
      selectedSeats.remove(seatId);
    } else {
      seatStatus[seatId] = "selected";
      selectedSeats.add(seatId);
    }
  }

  // --- Ticket Confirmation / Customer Info ---
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  bool validateInputs(BuildContext context) {
    if (nameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      return false;
    }

    final emailPattern = RegExp(r"^[\w\.-]+@[\w\.-]+\.\w+$");
    if (!emailPattern.hasMatch(emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Enter a valid email address')),
      );
      return false;
    }

    final phonePattern = RegExp(r"^\d{10,15}$");
    if (!phonePattern.hasMatch(phoneController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Enter a valid phone number')),
      );
      return false;
    }

    return true;
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.onClose();
  }
}
