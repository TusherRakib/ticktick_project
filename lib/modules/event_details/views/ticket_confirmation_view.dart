import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticktick_project/modules/event_details/controller/event_details_controller.dart';

class TicketConfirmationView extends StatelessWidget {
  final controller = Get.find<EventDetailsController>();

  @override
  Widget build(BuildContext context) {
    final selectedDate = controller.dates[controller.selectedDateIndex];
    final selectedTime = controller.timeSlots[controller.selectedTimeIndex];
    final seatList = controller.selectedSeats.join(', ');
    final formattedDate =
        "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";

    return Scaffold(
      appBar: AppBar(
        title: Text("Confirm Your Ticket"),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle("Event Details"),
            _cardContainer([
              _detailRow("Event Name:", controller.eventName.value),
              _detailRow("Date:", formattedDate),
              _detailRow("Time:", selectedTime),
              _detailRow("Location:", controller.eventLocation.value),
              _detailRow("Organizer:", controller.eventOrganizer.value),
            ]),

            SizedBox(height: 20),
            _sectionTitle("Selected Seats"),
            _cardContainer([
              Text(seatList, style: TextStyle(fontSize: 16)),
            ]),

            SizedBox(height: 20),
            _sectionTitle("Your Information"),
            _inputField(controller.nameController, "Full Name"),
            _inputField(controller.phoneController, "Phone Number", keyboardType: TextInputType.phone),
            _inputField(controller.emailController, "Email Address", keyboardType: TextInputType.emailAddress),

            SizedBox(height: 20),
            _sectionTitle("Concert Rules"),
            _buildRules(),

            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                if (controller.validateInputs(context)) {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      alignment: Alignment.center,
                      title: Text("Booking Confirmed!",),
                      content: Text("Your tickets have been booked successfully. The tickets are sent to your email"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("OK"),
                        )
                      ],
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: EdgeInsets.symmetric(vertical: 16),
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text("Confirm Booking", style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text("$label ", style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _cardContainer(List<Widget> children) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  Widget _inputField(TextEditingController controller, String label,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildRules() {
    final rules = [
      "1. Gates open 1 hour before the event.",
      "2. Tickets are non-refundable.",
      "3. Outside food/drinks are not allowed.",
      "4. All attendees are subject to security checks.",
      "5. Maintain respectful behavior."
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rules.map((rule) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          children: [
            Expanded(child: Text(rule)),
          ],
        ),
      )).toList(),
    );
  }
}
