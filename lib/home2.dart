import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:strady/data/variables.dart';
import 'package:strady/static/colors.dart';
import 'package:strady/static/views/select_view.dart';

import 'custom/orientation_options.dart';
import 'data/functions.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
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

      setState(() {
        for (var pickedImage in pickedImages) {
          dayNotes[currentDate]!["images"].add(pickedImage.path);
        }
        updateEvents(today);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          backgroundColor: grey800,
          appBar: CalendarAppBar(
            onDateChanged: (day) {
              setState(() {
                var previousDay = today;
                today = day;

                if (controller.text.isNotEmpty ||
                    controller.text.trim() != "") {
                  dayNotes[dateToString(previousDay)]?["note"] =
                      controller.text;
                  controller.clear();
                  updateEvents(previousDay);
                }
                updateEvents(today);
              });
            },
            firstDate: DateTime.utc(2010, 10, 16),
            lastDate: DateTime.now(),
            selectedDate: today,
            accent: grey800,
            white: grey100,
            black: grey900,
            fullCalendar: true,
            backButton: false,
            locale: 'en',
            events: events,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Stack(
              children: [
                Column(
                  children: [
                    OrientationOptions(
                      selectedOrientation: selectedOrientation,
                      onOrientationChanged: (orientation) {
                        setState(() {
                          selectedOrientation = orientation;
                        });
                      },
                    ),
                    SizedBox(height: 10.h),
                    SelectView(
                      selectedOrientation: selectedOrientation,
                    ),
                    SizedBox(height: 15.h),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 120.h,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          grey800.withOpacity(0),
                          grey800,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: GestureDetector(
            onTap: () {
              setState(() {
                isClicked = !isClicked;
              });
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      importImage();
                      if (controller.text.isNotEmpty ||
                          controller.text.trim() != "") {
                        noteFunction();
                      }
                      if (selectedOrientation == OrientationOption.splitView) {
                        tabController.animateTo(
                          0,
                          duration: const Duration(milliseconds: 400),
                        );
                      }
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 20.h,
                      horizontal: 15.w,
                    ),
                    decoration: BoxDecoration(
                      color: grey900.withOpacity(.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      Icons.add_photo_alternate_rounded,
                      color: grey300,
                      size: 30.sp,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      noteFunction();
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 20.h,
                      horizontal: 15.w,
                    ),
                    decoration: BoxDecoration(
                      color: grey900.withOpacity(.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: dayNotes.containsKey(dateToString(today))
                        ? controller.text.trim() != ""
                            ? Icon(
                                Icons.done,
                                color: grey300,
                                size: 30.sp,
                              )
                            : Icon(
                                Icons.edit,
                                color: grey300,
                                size: 30.sp,
                              )
                        : (controller.text.trim().isEmpty ||
                                controller.text.trim() == "")
                            ? Icon(
                                Icons.add,
                                color: grey300,
                                size: 30.sp,
                              )
                            : Icon(
                                Icons.done,
                                color: grey300,
                                size: 30.sp,
                              ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
