import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:strady/data/functions.dart';
import 'package:strady/data/variables.dart';
import 'package:strady/providers/notes_provider.dart';
import 'package:strady/static/colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class CustomListView extends StatefulWidget {
  const CustomListView({super.key});

  @override
  State<CustomListView> createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(
      builder: (context, noteProvider,_) {
        return Expanded(
          child: Column(
            children: [
              if ((noteProvider.dayNotes[dateToString(today)]?["images"] != null) &&
                  (noteProvider.dayNotes[dateToString(today)]?["images"].length! != 0))
                Column(
                  children: [
                    SizedBox(
                      height: 200.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: noteProvider.dayNotes[dateToString(today)]?["images"].length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              showPictureDialog(
                                context: context,
                                today: today,
                                index: index,
                              );
                            },
                            onLongPressStart: (LongPressStartDetails details) {
                              final RenderBox overlay = Overlay.of(context)
                                  .context
                                  .findRenderObject() as RenderBox;
                              final RelativeRect position = RelativeRect.fromRect(
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
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    ZoomTapAnimation(
                                                      onTap: () {
                                                        setState(() {
                                                          noteProvider.dayNotes[dateToString(
                                                                  today)]?["images"]
                                                              .removeAt(index);
        
                                                          Navigator.pop(context);
                                                        });
                                                      },
                                                      child: const Icon(
                                                        Icons.done,
                                                        color: Colors.green,
                                                      ),
                                                    ),
                                                    SizedBox(width: 80.w),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.pop(context);
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
                                    noteProvider.dayNotes[dateToString(today)]?["images"][index],
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
                  ],
                ),
        
              //note area
              Expanded(
                child: noteProvider.dayNotes.containsKey(dateToString(today)) &&
                        noteProvider.dayNotes[dateToString(today)]?["note"].trim() != ""
                    ? Align(
                        alignment: Alignment.topLeft,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              noteProvider.dayNotes[dateToString(today)]!["note"],
                              maxLines: null,
                              style: TextStyle(
                                color: grey300,
                                fontSize: 18.sp,
                              ),
                            ),
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        child: TextField(
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
                          onEditingComplete: () {
                            FocusScope.of(context).requestFocus(FocusNode());
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
              ),
            ],
          ),
        );
      }
    );
  }
}
