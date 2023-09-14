import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:strady/data/functions.dart';
import 'package:strady/data/variables.dart';

class NoteProvider extends ChangeNotifier {
  Map<String, Map<String, dynamic>> _dayNotes = {};

  Map<String, Map<String, dynamic>> get dayNotes => _dayNotes;

/*   void addDayNote({
    required DateTime date,
    required List<String> images,
    required String note,
  }) {
    _dayNotes[dateToString(date)] = {
      "images": images,
      "note": note,
    };
    notifyListeners();
  } */

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
        // updateEvents(today);
      } else {
        focusNode.requestFocus();
      }
    } else {
      Map<String, dynamic>? currentDayNote = dayNotes[currentDate];
      if (currentDayNote != null) {
        List<String> existingImages =
            List<String>.from(currentDayNote["images"]);

        String text = currentDayNote["note"];
        dayNotes.remove(currentDate);
        dayNotes[currentDate] = {
          "images": existingImages,
          "note": controller.text.trim(),
        };
        controller.text = text;
        // updateEvents(today);
        focusNode.requestFocus();
      }
    }

    notifyListeners();
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
    notifyListeners();
  }

  void imageFunction() {
    importImage();
    if (controller.text.isNotEmpty || controller.text.trim() != "") {
      noteFunction();
    }
    if (selectedOrientation == OrientationOption.splitView) {
      tabController.animateTo(
        0,
        duration: const Duration(milliseconds: 400),
      );
    }
  }

  Future<void> importImage() async {
    final pickedImages = await ImagePicker().pickMultiImage(
      imageQuality: 100,
    );

    if (pickedImages.isNotEmpty) {
      final currentDate = dateToString(today);

      if (!dayNotes.containsKey(currentDate)) {
        dayNotes[currentDate] = {
          "images": [],
          "note": "",
        };
      }

      for (var pickedImage in pickedImages) {
        dayNotes[currentDate]!["images"].add(pickedImage.path);
      }
      // updateEvents(today);
    }
    notifyListeners();
  }

  /* void remove({
    required DateTime date,
    required List<String> images,
    required String note,
  }) {
    _dayNotes.remove(date.toString());
    notifyListeners();
  } */
}
