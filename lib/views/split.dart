import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:strady/controllers/scroll_controllers.dart';
import 'package:strady/custom/circle_tab_indicator.dart';
import 'package:strady/data/functions.dart';
import 'package:strady/data/variables.dart';
import 'package:strady/static/colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class SplitView extends StatefulWidget {
  const SplitView({super.key});

  @override
  State<SplitView> createState() => _SplitViewState();
}

class _SplitViewState extends State<SplitView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: TabBar(
              controller: tabController,
              isScrollable: true,
              labelColor: grey100,
              unselectedLabelColor: grey500,
              indicator: CircleTabIndicator(
                color: grey100,
              ),
              splashFactory: NoSplash.splashFactory,
              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  return states.contains(MaterialState.focused)
                      ? null
                      : Colors.transparent;
                },
              ),
              tabs: const [
                ZoomTapAnimation(
                  child: Tab(
                    text: "Images",
                  ),
                ),
                ZoomTapAnimation(
                  child: Tab(
                    text: "Note",
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),

          //tab view
          Expanded(
            child: TabBarView(
              controller: tabController,
              physics: const BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: dayNotes[dateToString(today)]?["images"].length ==
                              null ||
                          dayNotes[dateToString(today)]?["images"].length == 0
                      ? Center(
                          child: Text(
                            "You have not added any images yet",
                            style: TextStyle(
                              color: grey500,
                              fontSize: 18.sp,
                            ),
                          ),
                        )
                      : MasonryGridView.builder(
                          controller: gridController,
                          gridDelegate:
                              const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          crossAxisSpacing: 16.w,
                          mainAxisSpacing: 16.h,
                          physics: const BouncingScrollPhysics(
                            decelerationRate: ScrollDecelerationRate.fast,
                          ),
                          itemCount:
                              dayNotes[dateToString(today)]?["images"].length,
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
                                final RenderBox overlay = Overlay.of(context)
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
                                                    BorderRadius.circular(20.r),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "Are you sure you want to delete this photo?",
                                                    style: TextStyle(
                                                      color: grey100,
                                                      fontSize: 18.sp,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  SizedBox(height: 30.h),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      ZoomTapAnimation(
                                                        onTap: () {
                                                          setState(() {
                                                            dayNotes[dateToString(
                                                                        today)]
                                                                    ?["images"]
                                                                .removeAt(
                                                                    index);

                                                            Navigator.pop(
                                                                context);
                                                          });
                                                        },
                                                        child: const Icon(
                                                          Icons.done,
                                                          color: Colors.green,
                                                        ),
                                                      ),
                                                      SizedBox(width: 80.w),
                                                      ZoomTapAnimation(
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
                                      dayNotes[dateToString(today)]?["images"]
                                          [index],
                                    ),
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: dayNotes.containsKey(dateToString(today)) &&
                          dayNotes[dateToString(today)]?["note"].trim() != ""
                      ? Align(
                          alignment: Alignment.topLeft,
                          child: SingleChildScrollView(
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
                          ),
                        )
                      : TextField(
                          focusNode: focusNode,
                          controller: controller,
                          keyboardType: TextInputType.multiline,
                          textCapitalization: TextCapitalization.sentences,
                          maxLines: null,
                          style: TextStyle(
                            color: grey300,
                            fontSize: 18.sp,
                          ),
                          onTap: () {
                            setState(() {
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
