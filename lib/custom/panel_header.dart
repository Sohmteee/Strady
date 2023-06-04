import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strady/data/variables.dart';
import 'package:strady/static/colors.dart';

class PanelHeader extends StatefulWidget {
  const PanelHeader({super.key});

  @override
  State<PanelHeader> createState() => _PanelHeaderState();
}

class _PanelHeaderState extends State<PanelHeader> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 10.h),
            width: 80.w,
            height: 8.h,
            decoration: BoxDecoration(
              color: grey50,
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () => panelController.isPanelOpen
                ? panelController.close()
                : panelController.open(),
            child: Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: isPanelOpen
                  ? Icon(
                      Icons.swipe_down_alt,
                      color: grey100,
                      size: 35.sp,
                    )
                  : Icon(
                      Icons.swipe_up_alt,
                      color: grey100,
                      size: 35.sp,
                    ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Icon(
                Icons.menu,
                color: grey100,
                size: 35.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
