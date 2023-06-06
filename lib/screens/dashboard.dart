import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mrx_charts/mrx_charts.dart';
import 'package:strady/data/functions.dart';
import 'package:strady/data/variables.dart';
import 'package:strady/static/colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    var dayList = generateNumbersWithSum(targetSum: 30, count: 3);
    dayList.sort();
    goodDays = dayList[2].toDouble();
    badDays = dayList[1].toDouble();
    neutralDays = dayList[0].toDouble();

    var goodDayValues = generateNumbersWithSum(
      targetSum: goodDays.toInt(),
      count: 4,
    );
    var badDayValues = generateNumbersWithSum(
      targetSum: badDays.toInt(),
      count: 4,
    );
    var neutralDayValues = generateNumbersWithSum(
      targetSum: neutralDays.toInt(),
      count: 4,
    );

    int maxGoodValue = maxValue(goodDayValues);
    int maxBadValues = maxValue(badDayValues);
    int maxNeutralValue = maxValue(neutralDayValues);

    int maxV = maxValue([maxGoodValue, maxBadValues, maxNeutralValue]);

    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          backgroundColor: grey800,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                SizedBox(height: 40.h),
                Row(
                  children: [
                    Row(
                      children: [
                        ZoomTapAnimation(
                          onTap: () => Navigator.pop(context),
                          child: Icon(
                            Icons.chevron_left,
                            color: grey100,
                          ),
                        ),
                        SizedBox(width: 10.w),
                      ],
                    ),
                    Text(
                      "Dashboard",
                      style: TextStyle(
                        color: grey100,
                        fontSize: 26.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        SizedBox(height: 20.h),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Text(
                                "This month",
                                style: TextStyle(
                                  color: grey100,
                                  fontSize: 18.sp,
                                ),
                              ),
                              RotatedBox(
                                quarterTurns: 1,
                                child: Icon(
                                  Icons.chevron_right,
                                  color: grey100,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          decoration: BoxDecoration(
                            color: grey700,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 200.w,
                                height: 200.h,
                                child: Chart(
                                  duration: const Duration(seconds: 2),
                                  layers: [
                                    ChartGroupPieLayer(
                                      items: [
                                        [
                                          ChartGroupPieDataItem(
                                            amount: goodDays,
                                            color: Colors.green,
                                            label: "Good Days",
                                          ),
                                          ChartGroupPieDataItem(
                                            amount: badDays,
                                            color: Colors.red,
                                            label: "Bad Days",
                                          ),
                                          ChartGroupPieDataItem(
                                            amount: neutralDays,
                                            color: grey400,
                                            label: "Neutral Days",
                                          ),
                                        ]
                                      ],
                                      settings: ChartGroupPieSettings(
                                        radius: 30.r,
                                        thickness: 5,
                                        gapBetweenChartCircles: 2,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 10.w,
                                        height: 10.w,
                                        decoration: const BoxDecoration(
                                          color: Colors.green,
                                          shape: BoxShape.rectangle,
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Text(
                                        "Good days (${(goodDays / totalDays * 100).toStringAsFixed(1)}%)",
                                        style: TextStyle(
                                          color: grey100,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 10.w,
                                        height: 10.w,
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.rectangle,
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Text(
                                        "Bad days (${(badDays / totalDays * 100).toStringAsFixed(1)}%)",
                                        style: TextStyle(
                                          color: grey100,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 10.w,
                                        height: 10.w,
                                        decoration: BoxDecoration(
                                          color: grey400,
                                          shape: BoxShape.rectangle,
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Text(
                                        "Neutral days (${(neutralDays / totalDays * 100).toStringAsFixed(1)}%)",
                                        style: TextStyle(
                                          color: grey100,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Container(
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                            color: grey700,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: SizedBox(
                            width: double.maxFinite,
                            height: 200.h,
                            child: Chart(
                              duration: const Duration(seconds: 2),
                              layers: [
                                ChartAxisLayer(
                                  settings: ChartAxisSettings(
                                    x: ChartAxisSettingsAxis(
                                      frequency: 1.0,
                                      max: 4.0,
                                      min: 1.0,
                                      textStyle: TextStyle(
                                        color: grey100,
                                        fontSize: 10.0,
                                      ),
                                    ),
                                    y: ChartAxisSettingsAxis(
                                      frequency: 3,
                                      max: maxV + 2,
                                      min: 0.0,
                                      textStyle: TextStyle(
                                        color: grey100,
                                        fontSize: 10.0,
                                      ),
                                    ),
                                  ),
                                  labelX: (value) => "Week ${value.toInt()}",
                                  labelY: (value) => value.toInt().toString(),
                                ),
                                ChartLineLayer(
                                  items: [
                                    ChartLineDataItem(
                                        value: neutralDayValues[0].toDouble(),
                                        x: 1),
                                    ChartLineDataItem(
                                        value: neutralDayValues[1].toDouble(),
                                        x: 2),
                                    ChartLineDataItem(
                                        value: neutralDayValues[2].toDouble(),
                                        x: 3),
                                    ChartLineDataItem(
                                        value: neutralDayValues[3].toDouble(),
                                        x: 4),
                                  ],
                                  settings: ChartLineSettings(
                                    color: grey400,
                                    thickness: 2,
                                  ),
                                ),
                                ChartLineLayer(
                                  items: [
                                    ChartLineDataItem(
                                        value: badDayValues[0].toDouble(),
                                        x: 1),
                                    ChartLineDataItem(
                                        value: badDayValues[1].toDouble(),
                                        x: 2),
                                    ChartLineDataItem(
                                        value: badDayValues[2].toDouble(),
                                        x: 3),
                                    ChartLineDataItem(
                                        value: badDayValues[3].toDouble(),
                                        x: 4),
                                  ],
                                  settings: const ChartLineSettings(
                                    color: Colors.red,
                                    thickness: 2,
                                  ),
                                ),
                                ChartLineLayer(
                                  items: [
                                    ChartLineDataItem(
                                        value: goodDayValues[0].toDouble(),
                                        x: 1),
                                    ChartLineDataItem(
                                        value: goodDayValues[1].toDouble(),
                                        x: 2),
                                    ChartLineDataItem(
                                        value: goodDayValues[2].toDouble(),
                                        x: 3),
                                    ChartLineDataItem(
                                        value: goodDayValues[3].toDouble(),
                                        x: 4),
                                  ],
                                  settings: const ChartLineSettings(
                                    color: Colors.green,
                                    thickness: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Container(
                          decoration: BoxDecoration(
                            color: grey700,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            child: DataTable(
                              dividerThickness: 0,
                              columnSpacing:
                                  MediaQuery.of(context).size.width * .04,
                              columns: [
                                DataColumn(
                                  label: Text(
                                    "Week",
                                    style: TextStyle(
                                      color: grey300,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    "Good Days",
                                    style: TextStyle(
                                      color: Colors.green.shade400,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    "Bad Days",
                                    style: TextStyle(
                                      color: Colors.red.shade400,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    "Neutral Days",
                                    style: TextStyle(
                                      color: grey300,
                                    ),
                                  ),
                                ),
                              ],
                              rows: [
                                DataRow(
                                  cells: [
                                    DataCell(
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          '1',
                                          style: TextStyle(
                                            color: grey100,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          goodDayValues[0].toInt().toString(),
                                          style: TextStyle(
                                            color: Colors.green.shade400,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          badDayValues[0].toInt().toString(),
                                          style: TextStyle(
                                            color: Colors.red.shade400,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          neutralDayValues[0]
                                              .toInt()
                                              .toString(),
                                          style: TextStyle(
                                            color: grey300,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    DataCell(
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          '2',
                                          style: TextStyle(
                                            color: grey100,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          goodDayValues[1].toInt().toString(),
                                          style: TextStyle(
                                            color: Colors.green.shade400,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          badDayValues[1].toInt().toString(),
                                          style: TextStyle(
                                            color: Colors.red.shade400,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          neutralDayValues[1]
                                              .toInt()
                                              .toString(),
                                          style: TextStyle(
                                            color: grey300,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    DataCell(
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          '3',
                                          style: TextStyle(
                                            color: grey100,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          goodDayValues[2].toInt().toString(),
                                          style: TextStyle(
                                            color: Colors.green.shade400,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          badDayValues[2].toInt().toString(),
                                          style: TextStyle(
                                            color: Colors.red.shade400,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          neutralDayValues[2]
                                              .toInt()
                                              .toString(),
                                          style: TextStyle(
                                            color: grey300,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    DataCell(
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          '4',
                                          style: TextStyle(
                                            color: grey100,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          goodDayValues[3].toInt().toString(),
                                          style: TextStyle(
                                            color: Colors.green.shade400,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          badDayValues[3].toInt().toString(),
                                          style: TextStyle(
                                            color: Colors.red.shade400,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          neutralDayValues[3]
                                              .toInt()
                                              .toString(),
                                          style: TextStyle(
                                            color: grey300,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    DataCell(
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Total',
                                          style: TextStyle(
                                            color: grey100,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          goodDays.toInt().toString(),
                                          style: TextStyle(
                                            color: Colors.green.shade400,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          badDays.toInt().toString(),
                                          style: TextStyle(
                                            color: Colors.red.shade400,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          neutralDays.toInt().toString(),
                                          style: TextStyle(
                                            color: grey300,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],
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
