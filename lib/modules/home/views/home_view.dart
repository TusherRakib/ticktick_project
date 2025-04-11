import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticktick_project/app_routes/routes_path.dart';
import '../../../utils/app_progress_dialog.dart';
import '../../../widgets/event_card.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final HomeController controller = Get.find<HomeController>(); // Use Get.find instead of Get.put

  final List<String> categories = ["Discover", 'Concert', 'Standup Comedy', 'Workshop', 'Conference', 'Seminar'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Text(
              "Sudbury, Ontario",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Icon(Icons.arrow_drop_down, color: Colors.black),
          ],
        ),
        actions: [
          Icon(Icons.notifications_none, color: Colors.black),
          SizedBox(width: 20),
        ],
      ),
      drawer: _buildDrawer(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            _buildSearchBar(),
            SizedBox(height: 20),
            _buildCategoryTabs(),
            SizedBox(height: 20),
            _buildSectionTitle("Events near you"),
            Expanded(child: Obx(() => _buildEventList())), // Ensure ListView takes full space
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search concert, attraction or other",
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          String category = categories[index];
          return Padding(
            padding: EdgeInsets.only(right: 10, bottom: 10),
            child: Obx(() => ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: controller.selectedCategory.value == category
                    ? Colors.black
                    : Colors.white,
                foregroundColor: controller.selectedCategory.value == category
                    ? Colors.white
                    : Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                controller.filterEventsByCategory(category);
              },
              child: Text(category),
            )),
          );
        },
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.black),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.account_circle, size: 60, color: Colors.white),
                SizedBox(height: 10),
                Text("Welcome!", style: TextStyle(color: Colors.white, fontSize: 18)),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Account"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.event_note),
            title: Text("Create Event"),
            onTap: () {
              Get.back();
              Get.toNamed(RoutesPath.eventView);
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Sign Out"),
            onTap: () {
              if (controller.authController != null) { // Prevent null access
                AppProgressDialog.showLoaderDialog(Get.context!);
                controller.authController!.signOut().then((value) {
                  AppProgressDialog.hide();
                });
              } else {
                log("authController is null!");
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Icon(Icons.arrow_forward, color: Colors.black),
      ],
    );
  }

  Widget _buildEventList() {
    if (controller.filteredEventsList.isEmpty) {
      return Center(child: Text("No events available"));
    }

    return ListView.builder(
      shrinkWrap: true,
      // physics: NeverScrollableScrollPhysics(),
      itemCount: controller.filteredEventsList.length,
      itemBuilder: (context, index) {
        var event = controller.filteredEventsList[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: GestureDetector(
            onTap: (){

              Get.toNamed(RoutesPath.eventDetailsView);
            },
            child: EventCard(
              image: "assets/images/eminemt_banner.jpg",
              price: event["price"] != null ? "\$${event["price"]} CAD" : "Price not available",
              date: event["start_date"] ?? "Date not available",
              location: event["location"] ?? "Location not available",
              title: event["name"] ?? "Unnamed Event",
            ),
          ),
        );
      },
    );
  }
}
