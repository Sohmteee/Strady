import 'dart:io';

import 'package:flutter/material.dart';
import 'package:strady/data/variables.dart';

String monthToString(int month) {
  switch (month) {
    case 1:
      return "January";
    case 2:
      return "February";
    case 3:
      return "March";
    case 4:
      return "April";
    case 5:
      return "May";
    case 6:
      return "June";
    case 7:
      return "July";
    case 8:
      return "August";
    case 9:
      return "September";
    case 10:
      return "October";
    case 11:
      return "November";
    case 12:
      return "December";
    default:
      return "";
  }
}

String dateToString(DateTime date) => "${date.day}-${date.month}-${date.year}";

showPictureDialog({context, today, index}) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return InteractiveViewer(
          panEnabled: true,
          scaleEnabled: true,
          minScale: 0.5,
          maxScale: 4.0,
          child: Dialog(
            child: Image.file(
              File(
                dayNotes[dateToString(today)]?["images"][index],
              ),
              fit: BoxFit.fitHeight,
            ),
          ),
        );
      });
}
