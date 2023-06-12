import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:strady/data/variables.dart';
import 'package:strady/static/colors.dart';

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

double maxDay(double goodDays, double badDays, double neutralDays) => [
      goodDays,
      badDays,
      neutralDays
    ].reduce((value, element) => value > element ? value : element);

int maxValue(List<int> numbers) {
  int greatestNumber = numbers[0];

  for (int i = 1; i < numbers.length; i++) {
    if (numbers[i] > greatestNumber) {
      greatestNumber = numbers[i];
    }
  }
  return greatestNumber;
}

Color getColorForLabel(String label) {
  if (label == "Good days") {
    return Colors.green;
  } else if (label == "Bad days") {
    return Colors.red;
  } else if (label == "Neutral days") {
    return grey400;
  } else {
    // Default color if label doesn't match any condition
    return Colors.grey;
  }
}

List<int> generateNumbersWithSum({required int targetSum, required int count}) {
  List<int> numbers = [];

  // Generate random numbers
  for (int i = 0; i < count - 1; i++) {
    int randomNumber = Random().nextInt(targetSum);
    numbers.add(randomNumber);
    targetSum -= randomNumber;
  }

  // Add the remaining target sum as the last number
  numbers.add(targetSum);

  return numbers;
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

String daySuffix(int n) {
  if (n.toString().length <= 1 || n.toString()[0] != "1") {
    switch (n.toString()[n.toString().length - 1]) {
      case "1":
        return "st";
      case "2":
        return "nd";
      case "3":
        return "rd";
      default:
        return "th";
    }
  } else {
    return "th";
  }
}

bool isKeyboardVisible(BuildContext context) {
  final EdgeInsets viewInsets = MediaQuery.of(context).viewInsets;
  return viewInsets.bottom > 0;
}

void updateEvents(DateTime day) {
  final String currentDate = dateToString(day);
  if (!events!.contains(day)) {
    events!.add(day);
  }
  if (dayNotes.containsKey(currentDate)) {
    if (dayNotes[currentDate]!["images"].isNotEmpty ||
        dayNotes[currentDate]!["note"].trim().isNotEmpty) {
      events!.add(day);
    } else {
      events!.remove(day);
    }
  }
}

void noteFunction() {
  String currentDate = dateToString(today);

  if (selectedOrientation == OrientationOption.splitView) {
    tabController.animateTo(
      1,
      duration: const Duration(milliseconds: 400),
    );
  }

  if (!dayNotes.containsKey(currentDate)) {
    if (controller.value.text.trim() != "") {
      dayNotes[currentDate] = {
        "images": [],
        "note": controller.text.trim(),
      };
      controller.clear();
      updateEvents(today);
    } else {
      focusNode.requestFocus();
    }
  } else {
    Map<String, dynamic>? currentDayNote = dayNotes[currentDate];
    if (currentDayNote != null) {
      List<String> existingImages = List<String>.from(currentDayNote["images"]);

      String text = currentDayNote["note"];
      dayNotes.remove(currentDate);
      dayNotes[currentDate] = {
        "images": existingImages,
        "note": controller.text.trim(),
      };
      controller.text = text;
      updateEvents(today);
      focusNode.requestFocus();
    }
  }
}
