import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticktick_project/modules/event_details/controller/event_details_controller.dart';
import 'package:ticktick_project/modules/event_details/views/ticket_confirmation_view.dart';
import '../../../utils/app_colors.dart';

class TicketBookingView extends StatefulWidget {
  @override
  _TicketBookingViewState createState() => _TicketBookingViewState();
}

class _TicketBookingViewState extends State<TicketBookingView> {
  final controller = Get.find<EventDetailsController>();

  @override
  void initState() {
    super.initState();
    controller.initializeSeats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sonic Fusion (AU)", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSubtitle(),
            SizedBox(height: 20),
            _buildDateSelector(),
            SizedBox(height: 10),
            _buildTimeSelector(),
            SizedBox(height: 20),
            Divider(),
            Expanded(child: _buildSeatGrid()),
            _buildLegend(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.black,
              ),
              onPressed: (){
                Get.to(TicketConfirmationView());
              },
              child: Text('Book A Ticket', style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      "Pulse Clubhouse 19/09/2023",
      style: TextStyle(color: Colors.grey[700], fontSize: 14),
    );
  }

  Widget _buildDateSelector() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.dates.length,
        itemBuilder: (_, index) {
          DateTime date = controller.dates[index];
          bool isSelected = controller.selectedDateIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                controller.selectedDateIndex = index;
              });
            },
            child: Container(
              width: 50,
              margin: EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                color: isSelected ? Colors.orange : Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"][date.weekday % 7],
                    style: TextStyle(color: isSelected ? Colors.white : Colors.black),
                  ),
                  Text(
                    "${date.day}",
                    style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimeSelector() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.timeSlots.length,
        itemBuilder: (_, index) {
          bool isSelected = controller.selectedTimeIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                controller.selectedTimeIndex = index;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              margin: EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                color: isSelected ? Colors.orange : Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Center(
                child: Text(
                  controller.timeSlots[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSeatGrid() {
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 8,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: 64,
      itemBuilder: (_, index) {
        int row = index ~/ 8;
        int col = index % 8;
        String seatId = "$row-$col";
        String status = controller.seatStatus[seatId] ?? "available";

        Color seatColor;
        switch (status) {
          case "reserved":
            seatColor = Colors.grey;
            break;
          case "selected":
            seatColor = Colors.deepPurple;
            break;
          default:
            seatColor = Colors.purple.shade100;
        }

        return GestureDetector(
          onTap: () {
            setState(() {
              controller.toggleSeatSelection(seatId);
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: seatColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: controller.selectedSeats.contains(seatId)
                  ? Text(
                "${controller.selectedSeats.indexOf(seatId) + 1}",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )
                  : null,
            ),
          ),
        );
      },
    );
  }

  Widget _buildLegend() {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildLegendItem(Colors.purple.shade100, "Available"),
          _buildLegendItem(Colors.grey, "Reserved"),
          _buildLegendItem(Colors.deepPurple, "Selected"),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        SizedBox(width: 5),
        Text(label),
      ],
    );
  }
}
