import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strady/data/variables.dart';
import 'package:strady/screens/dashboard.dart';
import 'package:strady/static/colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class OrientationOptions extends StatefulWidget {
  final OrientationOption selectedOrientation;
  final void Function(OrientationOption) onOrientationChanged;

  const OrientationOptions({
    required this.selectedOrientation,
    required this.onOrientationChanged,
    Key? key,
  }) : super(key: key);

  @override
  State<OrientationOptions> createState() => _OrientationOptionsState();
}

class _OrientationOptionsState extends State<OrientationOptions> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ZoomTapAnimation(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DashBoard(),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 10.h,
            ),
            decoration: BoxDecoration(
              color: grey100,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              "View Dashboard",
              style: TextStyle(
                color: grey800,
                fontSize: 16.sp,
              ),
            ),
          ),
        ),
        Row(
          children: [
            ZoomTapAnimation(
              onTap: () {
                widget.onOrientationChanged(OrientationOption.listView);
              },
              child: RotatedBox(
                quarterTurns: 2,
                child: Icon(
                  Icons.horizontal_split,
                  color:
                      widget.selectedOrientation == OrientationOption.listView
                          ? grey100
                          : grey500,
                  size: 35.sp,
                ),
              ),
            ),
            ZoomTapAnimation(
              onTap: () {
                widget.onOrientationChanged(OrientationOption.splitView);
              },
              child: RotatedBox(
                quarterTurns: 2,
                child: Icon(
                  Icons.vertical_split,
                  color:
                      widget.selectedOrientation == OrientationOption.splitView
                          ? grey100
                          : grey500,
                  size: 35.sp,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
