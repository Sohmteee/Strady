import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strady/data/functions.dart';
import 'package:strady/data/variables.dart';
import 'package:strady/static/colors.dart';

class ImageList extends StatefulWidget {
  const ImageList({super.key});

  @override
  State<ImageList> createState() => _ImageListState();
}

class _ImageListState extends State<ImageList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: dayNotes[dateToString(today)]?["images"].length,
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
              final RenderBox overlay =
                  Overlay.of(context).context.findRenderObject() as RenderBox;
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
                            margin: EdgeInsets.symmetric(horizontal: 50.w),
                            padding: EdgeInsets.all(20.w),
                            decoration: BoxDecoration(
                              color: grey600,
                              borderRadius: BorderRadius.circular(20.r),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          dayNotes[dateToString(today)]
                                                  ?["images"]
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
                    dayNotes[dateToString(today)]?["images"][index],
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
    );
  }
}
