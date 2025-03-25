import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/app_progress_dialog.dart';
import '../../../widgets/event_card.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController controller = Get.put(HomeController());
  final List<String> categories = ["Discover", "Concert", "Sport", "Fashion"];
  String selectedCategory = "Discover";

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  // A separate method to handle the async task
  Future<void> _initializeLocation() async {
    // await controller.getCustomerLocation();
    log(controller.locationName.value);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: IconButton(
        //   icon: Icon(Icons.menu, color: Colors.black),
        //   onPressed: () {
        //     Scaffold.of(context).openDrawer();
        //   },
        // ),
        title: Row(
          children: [
            Text("Jakarta, Indonesia", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Icon(Icons.arrow_drop_down, color: Colors.black),
          ],
        ),
        actions: [Icon(Icons.notifications_none, color: Colors.black), SizedBox(width: 20)],
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
            _buildSectionTitle("Event near you"),
            _buildEventList(),
            SizedBox(height: 20),
            _buildSectionTitle("Popular event"),
            _buildEventList(),
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
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
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedCategory == category ? Colors.black : Colors.white,
                foregroundColor: selectedCategory == category ? Colors.white : Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                setState(() {
                  selectedCategory = category;
                });
              },
              child: Text(category),
            ),
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
            leading: Icon(Icons.exit_to_app),
            title: Text("Sign Out"),
            onTap: () {
              AppProgressDialog.showLoaderDialog(Get.context!);
              controller.authController.signOut().then((value) {
                AppProgressDialog.hide();
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), Icon(Icons.arrow_forward, color: Colors.black)],
    );
  }

  Widget _buildEventList() {
    List<Map<String, String>> events = [
      {
        "image": "assets/images/concert_1.jpg",
        "price": "IDR 50.000",
        "date": "August, 25",
        "location": "Melodia Auditorium",
        "title": "Redefining Jakarta: A Celebration of Creativity",
      },
      {
        "image": "assets/images/eminemt_banner.jpg",
        "price": "IDR 250.000",
        "date": "August, 26",
        "location": "Melodia Auditorium",
        "title": "Faris Pratama: Harmoni Cita",
      },
      {
        "image": "assets/images/eminemt_banner.jpg",
        "price": "IDR 80.000",
        "date": "September, 09",
        "location": "Jakarta Stadium",
        "title": "The Voltage Fusion: Live Music Expedition",
      },
    ];

    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: events.length,
        itemBuilder: (context, index) {
          var event = events[index];
          return Padding(
            padding: EdgeInsets.only(right: 15),
            child: EventCard(
              image: event["image"]!,
              price: event["price"]!,
              date: event["date"]!,
              location: event["location"]!,
              title: event["title"]!,
            ),
          );
        },
      ),
    );
  }
}
