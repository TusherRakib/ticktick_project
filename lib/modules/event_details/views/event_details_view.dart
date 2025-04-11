import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticktick_project/app_routes/routes_path.dart';
import 'package:ticktick_project/modules/event_details/views/ticket_booking_view.dart';
import 'package:ticktick_project/utils/app_colors.dart';

import '../controller/event_details_controller.dart';

class EventDetailsView extends StatefulWidget {
  @override
  _EventDetailsViewState createState() => _EventDetailsViewState();
}

class _EventDetailsViewState extends State<EventDetailsView> {


  final EventDetailsController controller = EventDetailsController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() => SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/eminemt_banner.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    top: 10,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Get.back(),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 16,
                    child: Text(
                      controller.eventName.value,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Divider(height: 30),
                    Row(
                      children: [
                        Icon(Icons.calendar_today, color: Colors.purple),
                        SizedBox(width: 10),
                        Text(controller.eventDate.value),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.access_time, color: Colors.purple),
                        SizedBox(width: 10),
                        Text(controller.eventTime.value),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.purple),
                        SizedBox(width: 10),
                        Text(controller.eventLocation.value),
                        Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    onPressed: (){
                      Get.to(TicketBookingView());
                    },
                    child: Text("Book a ticket", style: TextStyle(color: Colors.white),),
                  )
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      controller.eventDescription.value,
                      style: TextStyle(height: 1.4),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
