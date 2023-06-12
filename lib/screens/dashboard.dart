import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mrx_charts/mrx_charts.dart';
import 'package:strady/custom/circle_tab_indicator.dart';
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
    var week1 = generateNumbersWithSum(targetSum: 7, count: 3);
    var week2 = generateNumbersWithSum(targetSum: 7, count: 3);
    var week3 = generateNumbersWithSum(targetSum: 7, count: 3);
    var week4 = generateNumbersWithSum(targetSum: 7, count: 3);

    goodDays = (week1[0] + week2[0] + week3[0] + week4[0]).toDouble();
    badDays = (week1[1] + week2[1] + week3[1] + week4[1]).toDouble();
    neutralDays = (week1[2] + week2[2] + week3[2] + week4[2]).toDouble();

/*     var goodDayValues = generateNumbersWithSum(
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

    int maxV = maxValue([maxGoodValue, maxBadValues, maxNeutralValue]); */

/*     // Accessing data
    int year = 2023;
    var months = yearData[year]; // Get the list of months for the year
    int month = 1;
    var days = months?[0][month]; // Get the map of days for the month
    String? dayStatus = days?[1]; // Get the status for day 1 (e.g., 'good')

// Modifying data
    days?[1] = 'neutral'; // Change the status for day 1

// Adding new data
    days?[2] = 'bad'; // Add a new day to the map

// Adding a new month
    months?.add(
        {6: {}}); // Add a new month (e.g., June) with an empty map of days */

    // Calculate the percentages
    double totalDays = goodDays + badDays + neutralDays;
    double goodPercentage = (goodDays / totalDays * 100);
    double badPercentage = (badDays / totalDays * 100);
    double neutralPercentage = (neutralDays / totalDays * 100);

    // Create a map of percentages and labels
    Map<String, double> percentages = {
      "Good days": goodPercentage,
      "Bad days": badPercentage,
      "Neutral days": neutralPercentage,
    };
// Convert the Map to a List of entries (key-value pairs)
    List<MapEntry<String, double>> entries = percentages.entries.toList();

// Sort the list based on the values
    entries.sort((a, b) => b.value.compareTo(a.value));

    Widget pieChart() {
      return AnimatedContainer(
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 300 + (1 * 100)),
        decoration: BoxDecoration(
          color: grey700,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20.w, left: 20.w),
              child: Text(
                "Pie Chart",
                style: TextStyle(
                  color: grey100,
                  fontSize: 18.sp,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Divider(color: grey400),
            ),
            Row(
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
                    for (var entry in entries)
                      Row(
                        children: [
                          Container(
                            width: 10.w,
                            height: 10.w,
                            decoration: BoxDecoration(
                              color: getColorForLabel(entry.key),
                              shape: BoxShape.rectangle,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            "${entry.key} (${entry.value.toStringAsFixed(1)}%)",
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
          ],
        ),
      );
    }

    Widget graphs() {
      return AnimatedContainer(
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 300 + (2 * 100)),
        width: double.maxFinite,
        height: 350.h,
        decoration: BoxDecoration(
          color: grey700,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20.w, left: 20.w),
              child: Text(
                "Graphs",
                style: TextStyle(
                  color: grey100,
                  fontSize: 18.sp,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Divider(color: grey400),
            ),
            Align(
              alignment: Alignment.center,
              child: TabBar(
                controller: graphController,
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
                      text: "Line",
                    ),
                  ),
                  ZoomTapAnimation(
                    child: Tab(
                      text: "Grouped Bar",
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: TabBarView(
                controller: graphController,
                physics: const BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Chart(
                      duration: const Duration(seconds: 2),
                      layers: [
                        ChartAxisLayer(
                          settings: ChartAxisSettings(
                            x: ChartAxisSettingsAxis(
                              frequency: 1,
                              max: 4,
                              min: 1,
                              textStyle: TextStyle(
                                color: grey100,
                                fontSize: 10,
                              ),
                            ),
                            y: ChartAxisSettingsAxis(
                              frequency: 1,
                              max: 7,
                              min: 0,
                              textStyle: TextStyle(
                                color: grey100,
                                fontSize: 10,
                              ),
                            ),
                          ),
                          labelX: (value) => "Week ${value.toInt()}",
                          labelY: (value) => value.toInt().toString(),
                        ),
                        ChartLineLayer(
                          items: [
                            ChartLineDataItem(value: week1[2].toDouble(), x: 1),
                            ChartLineDataItem(value: week2[2].toDouble(), x: 2),
                            ChartLineDataItem(value: week3[2].toDouble(), x: 3),
                            ChartLineDataItem(value: week4[2].toDouble(), x: 4),
                          ],
                          settings: ChartLineSettings(
                            color: grey400,
                            thickness: 2,
                          ),
                        ),
                        ChartLineLayer(
                          items: [
                            ChartLineDataItem(value: week1[1].toDouble(), x: 1),
                            ChartLineDataItem(value: week2[1].toDouble(), x: 2),
                            ChartLineDataItem(value: week3[1].toDouble(), x: 3),
                            ChartLineDataItem(value: week4[1].toDouble(), x: 4),
                          ],
                          settings: const ChartLineSettings(
                            color: Colors.red,
                            thickness: 2,
                          ),
                        ),
                        ChartLineLayer(
                          items: [
                            ChartLineDataItem(value: week1[0].toDouble(), x: 1),
                            ChartLineDataItem(value: week2[0].toDouble(), x: 2),
                            ChartLineDataItem(value: week3[0].toDouble(), x: 3),
                            ChartLineDataItem(value: week4[0].toDouble(), x: 4),
                          ],
                          settings: const ChartLineSettings(
                            color: Colors.green,
                            thickness: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Chart(
                      duration: const Duration(seconds: 2),
                      layers: [
                        ChartAxisLayer(
                          settings: ChartAxisSettings(
                            x: ChartAxisSettingsAxis(
                              frequency: 1,
                              max: 4,
                              min: 1,
                              textStyle: TextStyle(
                                color: grey100,
                                fontSize: 10,
                              ),
                            ),
                            y: ChartAxisSettingsAxis(
                              frequency: 1,
                              max: 7,
                              min: 0,
                              textStyle: TextStyle(
                                color: grey100,
                                fontSize: 10,
                              ),
                            ),
                          ),
                          labelX: (value) => "Week ${value.toInt()}",
                          labelY: (value) => value.toInt().toString(),
                        ),
                        ChartGroupBarLayer(
                          items: [
                            [
                              ChartGroupBarDataItem(
                                color: Colors.green,
                                value: week1[0].toDouble(),
                                x: 1,
                              ),
                              ChartGroupBarDataItem(
                                color: Colors.red,
                                value: week1[1].toDouble(),
                                x: 1,
                              ),
                              ChartGroupBarDataItem(
                                color: grey400,
                                value: week1[2].toDouble(),
                                x: 1,
                              ),
                            ],
                            [
                              ChartGroupBarDataItem(
                                color: Colors.green,
                                value: week2[0].toDouble(),
                                x: 2,
                              ),
                              ChartGroupBarDataItem(
                                color: Colors.red,
                                value: week2[1].toDouble(),
                                x: 2,
                              ),
                              ChartGroupBarDataItem(
                                color: grey400,
                                value: week2[2].toDouble(),
                                x: 2,
                              ),
                            ],
                            [
                              ChartGroupBarDataItem(
                                color: Colors.green,
                                value: week3[0].toDouble(),
                                x: 3,
                              ),
                              ChartGroupBarDataItem(
                                color: Colors.red,
                                value: week3[1].toDouble(),
                                x: 3,
                              ),
                              ChartGroupBarDataItem(
                                color: grey400,
                                value: week3[2].toDouble(),
                                x: 4,
                              ),
                            ],
                            [
                              ChartGroupBarDataItem(
                                color: Colors.green,
                                value: week4[0].toDouble(),
                                x: 4,
                              ),
                              ChartGroupBarDataItem(
                                color: Colors.red,
                                value: week4[1].toDouble(),
                                x: 4,
                              ),
                              ChartGroupBarDataItem(
                                color: grey400,
                                value: week4[2].toDouble(),
                                x: 4,
                              ),
                            ]
                          ],
                          settings: ChartGroupBarSettings(
                            thickness: 5,
                            radius: BorderRadius.vertical(
                                top: Radius.circular(10.r)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget table() {
      return AnimatedContainer(
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 300 + (1 * 100)),
        decoration: BoxDecoration(
          color: grey700,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20.w, left: 20.w),
              child: Text(
                "Table",
                style: TextStyle(
                  color: grey100,
                  fontSize: 18.sp,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Divider(color: grey400),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: DataTable(
                dividerThickness: 0,
                columnSpacing: MediaQuery.of(context).size.width * .04,
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
                            week1[0].toString(),
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
                            week1[1].toString(),
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
                            week1[2].toString(),
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
                            week2[0].toString(),
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
                            week2[1].toString(),
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
                            week2[2].toString(),
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
                            week3[0].toString(),
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
                            week3[1].toString(),
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
                            week3[2].toString(),
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
                            week4[0].toString(),
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
                            week4[1].toString(),
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
                            week4[2].toString(),
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
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: grey800,
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
                                "Last 4 weeks",
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
                        pieChart(),
                        SizedBox(height: 20.h),
                        graphs(),
                        SizedBox(height: 20.h),
                        table(),
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
