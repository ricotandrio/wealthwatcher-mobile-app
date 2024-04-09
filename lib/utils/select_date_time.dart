import 'package:flutter/material.dart';

class SelectDateTime {
  final TextEditingController selectedDate = TextEditingController();

  SelectDateTime(){
    selectedDate.text = DateTime.now().toIso8601String();
  }

  Future<void> dateTimeModal(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final DateTime selectedDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
      );

      selectedDate.text = selectedDateTime.toIso8601String();
    }
  }

  String getDateTime() {
    return selectedDate.text.split('T')[0];
  }

  void resetDate() {
    selectedDate.text = DateTime.now().toIso8601String();
  }
}
