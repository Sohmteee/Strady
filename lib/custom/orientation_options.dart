import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strady/data/variables.dart';
import 'package:strady/static/colors.dart';

class OrientationOptions extends StatefulWidget {
  const OrientationOptions({
    super.key,
    required this.selected,
  });

  final int selected;

  @override
  State<OrientationOptions> createState() => _OrientationOptionsState();
}

class _OrientationOptionsState extends State<OrientationOptions> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              selectedOrientation = OrientationOption.listView;
            });
          },
          child: RotatedBox(
            quarterTurns: 2,
            child: Icon(
              Icons.horizontal_split,
              color: grey100,
              size: 35.sp,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              selectedOrientation = OrientationOption.gridView;
            });
          },
          child: Icon(
            Icons.dashboard,
            color: grey100,
            size: 30.sp,
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              selectedOrientation = OrientationOption.splitView;
            });
          },
          child: RotatedBox(
            quarterTurns: 2,
            child: Icon(
              Icons.vertical_split,
              color: grey100,
              size: 35.sp,
            ),
          ),
        ),
      ],
    );
  }
}
