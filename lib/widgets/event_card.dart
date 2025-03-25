import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final String image, price, date, location, title;

  const EventCard(
      {required this.image,
        required this.price,
        required this.date,
        required this.location,
        required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      margin: EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 10,
            right: 10,
            child: Icon(Icons.favorite_border, color: Colors.white),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(price,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)),
                  SizedBox(height: 5),
                  Text(date, style: TextStyle(fontSize: 12)),
                  Text(location, style: TextStyle(fontSize: 12)),
                  Text(title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
