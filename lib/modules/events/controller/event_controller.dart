import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EventController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String? selectedCategory;
  String? selectedEventType;
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController organizerController = TextEditingController();
  final TextEditingController rsvpDeadlineController = TextEditingController();
  final TextEditingController ticketInfoController = TextEditingController();
  final TextEditingController seatTypeController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController additionalInfoController = TextEditingController();

  File? eventCoverPhoto; // Cover photo file

  // Function to pick an image
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      eventCoverPhoto = File(pickedFile.path);
    }
  }

  // Function to upload image to Firebase Storage
  Future<String?> uploadImage(File image) async {
    try {
      String fileName = "event_covers/${DateTime.now().millisecondsSinceEpoch}.jpg";
      Reference ref = FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = ref.putFile(image);
      TaskSnapshot snapshot = await uploadTask;

      return await snapshot.ref.getDownloadURL(); // Get image URL
    } catch (e) {
      log("Image upload failed: $e");
      return null;
    }
  }

  Future<bool> createEvent() async {
    try {
      if (nameController.text.isEmpty ||
          descriptionController.text.isEmpty ||
          selectedCategory == null ||
          selectedEventType == null ||
          startDateController.text.isEmpty ||
          endDateController.text.isEmpty ||
          locationController.text.isEmpty) {
        throw Exception('Please fill all required fields');
      }

      String? imageUrl;
      if (eventCoverPhoto != null) {
        imageUrl = await uploadImage(eventCoverPhoto!);
        log(imageUrl.toString());
      }

      Map<String, dynamic> eventData = {
        'name': nameController.text,
        'description': descriptionController.text,
        'category': selectedCategory,
        'event_type': selectedEventType,
        'start_date': startDateController.text,
        'end_date': endDateController.text,
        'location': locationController.text,
        'organizer': organizerController.text,
        'rsvp_deadline': rsvpDeadlineController.text,
        'ticket_info': ticketInfoController.text,
        'seat_type': seatTypeController.text,
        'price': priceController.text,
        'quantity': quantityController.text,
        'additional_info': additionalInfoController.text,
        'cover_photo': imageUrl, // Store image URL in Firestore
        'created_at': DateTime.now().toString(),
      };

      log("Event Data: ${eventData.toString()}");

      await FirebaseFirestore.instance.collection('events').add(eventData);

      // clearControllers();
      return true;
    } catch (e) {
      log('Failed to create event: ${e.toString()}');
      return false;
    }
  }

  void clearControllers() {
    nameController.clear();
    descriptionController.clear();
    selectedCategory = null;
    selectedEventType = null;
    startDateController.clear();
    endDateController.clear();
    locationController.clear();
    organizerController.clear();
    rsvpDeadlineController.clear();
    ticketInfoController.clear();
    seatTypeController.clear();
    priceController.clear();
    quantityController.clear();
    additionalInfoController.clear();
    eventCoverPhoto = null;
  }
}
