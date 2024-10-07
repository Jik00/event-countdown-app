import 'package:flutter/material.dart';
import '../view_models/event_view_model.dart';

void showEditEventDialog(BuildContext context, EventViewModel eventViewModel, int index, String eventName, DateTime eventDate) {
  String updatedName = eventName;
  DateTime selectedDate = eventDate;

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text('Edit Event', style: TextStyle(color: Colors.black)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: TextEditingController(text: eventName),
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Event Name',
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  updatedName = value;
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != selectedDate) {
                    selectedDate = picked;
                  }
                },
                child: Text('Select Date', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (updatedName.isNotEmpty) {
                eventViewModel.editEvent(index, updatedName, selectedDate);
              }
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            child: Text('Update', style: TextStyle(color: Colors.white)),
          ),
        ],
      );
    },
  );
}
