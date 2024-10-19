import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PickerHelper {
  Future<void> selectDate(BuildContext context, TextEditingController dateController) async {
    DateTime initialDate = DateTime.now();  // Get last selected date or use current date
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: initialDate,
      lastDate: DateTime(2040),
      builder: (BuildContext context, Widget? child) {
        return child!;
      },
    );

    if (picked != null && picked != DateTime.now()) {
      dateController.text = DateFormat.yMMMd().format(picked);
      // await _saveLastSelectedDate(picked);  // Save selected date
    }
  }
}
