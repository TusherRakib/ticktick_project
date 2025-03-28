import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/event_controller.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final _formKey = GlobalKey<FormState>();
  final EventController _controller = EventController();

  final List<String> eventCategories = ['Concert', 'Standup Comedy', 'Workshop', 'Conference', 'Seminar'];
  final List<String> eventTypes = ['Online', 'In-Person', 'Hybrid'];

  int _currentStep = 0;
  List<bool> stepCompleted = [false, false, false];

  @override
  void dispose() {
    _controller.clearControllers();
    super.dispose();
  }

  Future<void> _selectDate(TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  bool _validateCurrentStep() {
    log("Validating Step $_currentStep");

    // if (!_formKey.currentState!.validate()) {
    //   return false;
    // }

    switch (_currentStep) {
      case 0:
        if (_controller.selectedCategory == null) {
          _showValidationDialog("Event Category");
          return false;
        }
        if (_controller.selectedEventType == null) {
          _showValidationDialog("Event Type");
          return false;
        }
        return true;

      case 1:
        return true;

      case 2:
        return true;

      default:
        return false;
    }
  }

  void _showValidationDialog(String missingField) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Validation Error"),
        content: Text("Please fill up $missingField to continue"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  Future<void> _submitForm() async {
    if (_validateCurrentStep()) {
      log("Submitting event...");
      bool value = await _controller.createEvent();
      if(value){
        Get.back();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Event created successfully!"))
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Event not created!"))
        );
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Event")),
      body: Form(
        key: _formKey,
        child: Stepper(
          currentStep: _currentStep,
          steps: _getSteps(),
          onStepContinue: () {
            if (_validateCurrentStep()) {
              setState(() {
                stepCompleted[_currentStep] = true;
                if (_currentStep < 2) {
                  _currentStep++;
                } else {
                  _submitForm();
                }
              });
            }
          },
          onStepTapped: (step) {
            if (step < _currentStep || stepCompleted[step]) {
              setState(() => _currentStep = step);
            }
          },
          onStepCancel: () {
            if (_currentStep > 0) {
              setState(() => _currentStep--);
            }
          },
        ),
      ),
    );
  }

  List<Step> _getSteps() {
    return [
      Step(
        title: Text('Event Details'),
        content: _buildStep1Content(),
        isActive: _currentStep >= 0,
        state: stepCompleted[0] ? StepState.complete : StepState.editing,
      ),
      Step(
        title: Text('Tickets'),
        content: _buildStep2Content(),
        isActive: _currentStep >= 1,
        state: stepCompleted[1] ? StepState.complete : StepState.editing,
      ),
      Step(
        title: Text('Payment Info'),
        content: _buildStep3Content(),
        isActive: _currentStep >= 2,
        state: stepCompleted[2] ? StepState.complete : StepState.editing,
      ),
    ];
  }

  Widget _buildStep1Content() {
    return Column(
      children: [
        TextFormField(
          controller: _controller.nameController,
          decoration: InputDecoration(labelText: "Event Name *"),
          validator: (value) => value!.isEmpty ? "Required field" : null,
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: _controller.descriptionController,
          decoration: InputDecoration(labelText: "Event Description *"),
          maxLines: 3,
          validator: (value) => value!.isEmpty ? "Required field" : null,
        ), SizedBox(height: 10),
        ElevatedButton(
          onPressed: () async {
            await _controller.pickImage();
            setState(() {});
          },
          child: Text('Pick Cover Photo'),
        ),

        // Show Selected Image
        _controller.eventCoverPhoto != null
            ? Image.file(_controller.eventCoverPhoto!, height: 150)
            : Text('No image selected'),

        // Submit Button
        SizedBox(height: 20),
        TextFormField(
          controller: _controller.locationController,
          decoration: InputDecoration(labelText: "Event Location *"),
          maxLines: 1,
          validator: (value) => value!.isEmpty ? "Required field" : null,
        ), SizedBox(height: 10),
        TextFormField(
          controller: _controller.organizerController,
          decoration: InputDecoration(labelText: "Event Organizer *"),
          maxLines: 1,
          validator: (value) => value!.isEmpty ? "Required field" : null,
        ),
        SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: _controller.selectedCategory,
          decoration: InputDecoration(labelText: "Event Category *"),
          items: eventCategories.map((category) => DropdownMenuItem(
            value: category,
            child: Text(category),
          )).toList(),
          onChanged: (value) => setState(() => _controller.selectedCategory = value),
          validator: (value) => value == null ? "Required field" : null,
        ),
        SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: _controller.selectedEventType,
          decoration: InputDecoration(labelText: "Event Type *"),
          items: eventTypes.map((type) => DropdownMenuItem(
            value: type,
            child: Text(type),
          )).toList(),
          onChanged: (value) => setState(() => _controller.selectedEventType = value),
          validator: (value) => value == null ? "Required field" : null,
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: _controller.startDateController,
          decoration: InputDecoration(labelText: "Start Date *"),
          readOnly: true,
          onTap: () => _selectDate(_controller.startDateController),
          validator: (value) => value!.isEmpty ? "Required field" : null,
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: _controller.endDateController,
          decoration: InputDecoration(labelText: "End Date *"),
          readOnly: true,
          onTap: () => _selectDate(_controller.endDateController),
          validator: (value) => value!.isEmpty ? "Required field" : null,
        ),
      ],
    );
  }

  Widget _buildStep2Content() {
    return Column(
      children: [
        TextFormField(
          controller: _controller.seatTypeController,
          decoration: InputDecoration(labelText: "Seat Type *"),
          validator: (value) => value!.isEmpty ? "Required field" : null,
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: _controller.priceController,
          decoration: InputDecoration(labelText: "Price *"),
          keyboardType: TextInputType.number,
          validator: (value) => value!.isEmpty ? "Required field" : null,
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: _controller.quantityController,
          decoration: InputDecoration(labelText: "Quantity Available *"),
          keyboardType: TextInputType.number,
          validator: (value) => value!.isEmpty ? "Required field" : null,
        ),
      ],
    );
  }

  Widget _buildStep3Content() {
    return Column(
      children: [
        TextFormField(
          controller: _controller.ticketInfoController,
          decoration: InputDecoration(labelText: "Ticket Information *"),
          validator: (value) => value!.isEmpty ? "Required field" : null,
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: _controller.rsvpDeadlineController,
          decoration: InputDecoration(labelText: "RSVP Deadline *"),
          readOnly: true,
          onTap: () => _selectDate(_controller.rsvpDeadlineController),
          validator: (value) => value!.isEmpty ? "Required field" : null,
        ),
      ],
    );
  }
}
