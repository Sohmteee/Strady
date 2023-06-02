// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:strady/data/variables.dart';
import 'package:strady/static/colors.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:velocity_x/velocity_x.dart';

import 'data/functions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isClicked = false;
  DateTime today = DateTime.now();
  TextEditingController controller = TextEditingController();
  PanelController panelController = PanelController();
  FocusNode focusNode = FocusNode();

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
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

  Future<void> importImage() async {
    final pickedImages = await ImagePicker().pickMultiImage(
      imageQuality: 100,
      maxHeight: 1000,
      maxWidth: 1000,
    );

    if (pickedImages.isNotEmpty) {
      final currentDate = dateToString(today);

      if (!dayNotes.containsKey(currentDate)) {
        dayNotes[currentDate] = {"images": [], "note": ""};
      }

      setState(() {
        for (var pickedImage in pickedImages) {
          dayNotes[currentDate]!["images"].add(pickedImage.path);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey50,
      body: SafeArea(
        child: Scaffold(
            backgroundColor: grey50,
            body: Stack(
              children: [
                SlidingUpPanel(
                  backdropColor: grey100,
                  minHeight: context.screenHeight * .3,
                  maxHeight: context.screenHeight * .85,
                  controller: panelController,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(30.r)),
                  color: grey800,
                  onPanelClosed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  onPanelOpened: () {
                    focusNode.requestFocus();
                  },
                  panel: Container(
                    padding: EdgeInsets.fromLTRB(15.w, 20.h, 15.w, 0),
                    decoration: BoxDecoration(
                      color: grey800,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30.r)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: 80.w,
                            height: 8.h,
                            decoration: BoxDecoration(
                              color: grey50,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                          ),
                        ),
                        SizedBox(height: 40.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${today.day}${daySuffix(today.day)} ${monthToString(today.month)}, ${today.year}",
                              style: TextStyle(
                                color: grey100,
                                fontSize: 30.sp,
                                fontFamily: "Nexa",
                              ),
                            ),
                            if ((today.day == DateTime.now().day) &&
                                (today.month == DateTime.now().month) &&
                                (today.year == DateTime.now().year))
                              Text(
                                " (Today)",
                                style: TextStyle(
                                  color: grey100,
                                  fontSize: 30.sp,
                                  fontFamily: "Nexa",
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 40.h),
                        if ((dayNotes[dateToString(today)]?["images"] !=
                                null) &&
                            (dayNotes[dateToString(today)]?["images"].length! !=
                                0))
                          SizedBox(
                            height: 200.h,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemCount: dayNotes[dateToString(today)]
                                      ?["images"]
                                  .length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    showPictureDialog(
                                      context: context,
                                      today: today,
                                      index: index,
                                    );
                                  },
                                  onLongPressStart:
                                      (LongPressStartDetails details) {
                                    final RenderBox overlay =
                                        Overlay.of(context)
                                            .context
                                            .findRenderObject() as RenderBox;
                                    final RelativeRect position =
                                        RelativeRect.fromRect(
                                      Rect.fromPoints(
                                        details.globalPosition,
                                        details.globalPosition,
                                      ),
                                      Offset.zero & overlay.size,
                                    );

                                    showMenu(
                                      context: context,
                                      position: position,
                                      color: grey100,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      items: [
                                        const PopupMenuItem(
                                          value: 'view',
                                          child: Text('View'),
                                        ),
                                        const PopupMenuItem(
                                          value: 'delete',
                                          child: Text('Delete'),
                                        ),
                                      ],
                                      elevation: 8.0,
                                    ).then((value) {
                                      if (value == 'view') {
                                        showPictureDialog(
                                          context: context,
                                          today: today,
                                          index: index,
                                        );
                                      } else if (value == 'delete') {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Center(
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 50.w),
                                                  padding: EdgeInsets.all(20.w),
                                                  decoration: BoxDecoration(
                                                    color: grey600,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.r),
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        "Are you sure you want to delete this photo?",
                                                        style: TextStyle(
                                                          color: grey100,
                                                          fontSize: 18.sp,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      SizedBox(height: 30.h),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                dayNotes[dateToString(
                                                                            today)]
                                                                        ?[
                                                                        "images"]
                                                                    .removeAt(
                                                                        index);

                                                                Navigator.pop(
                                                                    context);
                                                              });
                                                            },
                                                            child: const Icon(
                                                              Icons.done,
                                                              color:
                                                                  Colors.green,
                                                            ),
                                                          ),
                                                          SizedBox(width: 80.w),
                                                          GestureDetector(
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Icon(
                                                              Icons.close,
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                      }
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: grey300,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.r),
                                      child: Image.file(
                                        File(
                                          dayNotes[dateToString(today)]
                                              ?["images"][index],
                                        ),
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(width: 12.w);
                              },
                            ),
                          ),
                        SizedBox(height: 14.h),
                        Expanded(
                          child: dayNotes.containsKey(dateToString(today)) &&
                                  dayNotes[dateToString(today)]?["note"]
                                          .trim() !=
                                      ""
                              ? SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Text(
                                      dayNotes[dateToString(today)]!["note"],
                                      maxLines: null,
                                      style: TextStyle(
                                        color: grey300,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                  ),
                                )
                              : TextField(
                                  focusNode: focusNode,
                                  controller: controller,
                                  keyboardType: TextInputType.multiline,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  maxLines: null,
                                  style: TextStyle(
                                    color: grey300,
                                    fontSize: 18.sp,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      panelController.open();
                                      focusNode.requestFocus();
                                    });
                                  },
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Enter note here...",
                                    hintStyle: TextStyle(
                                      color: grey500,
                                      fontSize: 18.sp,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                        ),
                        SizedBox(height: 15.h),
                      ],
                    ),
                  ),
                  body: Column(
                    children: [
                      TableCalendar(
                        firstDay: DateTime.utc(2010, 10, 16),
                        lastDay: DateTime.utc(2030, 3, 14),
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        focusedDay: today,
                        selectedDayPredicate: (day) => isSameDay(day, today),
                        calendarStyle: CalendarStyle(
                          selectedDecoration: BoxDecoration(
                            color: grey800,
                            shape: BoxShape.circle,
                          ),
                          weekendTextStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 16.sp,
                          ),
                        ),
                        headerStyle: HeaderStyle(
                          formatButtonVisible: false,
                          titleTextStyle: TextStyle(
                            color: grey900,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          leftChevronIcon: Icon(
                            Icons.chevron_left_rounded,
                            color: grey900,
                          ),
                          rightChevronIcon: Icon(
                            Icons.chevron_right_rounded,
                            color: grey900,
                          ),
                        ),
                        daysOfWeekStyle: DaysOfWeekStyle(
                          weekdayStyle: TextStyle(
                            color: grey700,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                          weekendStyle: TextStyle(
                            color: grey700,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                        availableGestures: AvailableGestures.all,
                        onDaySelected: _onDaySelected,
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 120.h,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [grey800.withOpacity(0), grey800],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
              ],
            )),
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
                  String currentDate = dateToString(today);

                  if (!dayNotes.containsKey(currentDate)) {
                    if (controller.value.text.trim() != "") {
                      dayNotes[currentDate] = {
                        "images": [],
                        "note": controller.text.trim(),
                      };
                      controller.clear();
                    } else {
                      panelController.open();
                      focusNode.requestFocus();
                    }
                  } else {
                    Map<String, dynamic>? currentDayNote =
                        dayNotes[currentDate];
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
                      panelController.open();
                      focusNode.requestFocus();
                    }
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
                    : controller.text.trim().isEmpty
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
    );
  }
}
