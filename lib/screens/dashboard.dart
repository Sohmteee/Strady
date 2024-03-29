import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strady/custom/dashboard/graphs.dart';
import 'package:strady/custom/dashboard/pie_chart.dart';
import 'package:strady/custom/dashboard/table.dart';
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
    entries = percentages.entries.toList();

// Sort the list based on the values
    entries.sort((a, b) => b.value.compareTo(a.value));

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
                        const PieChart(),
                        SizedBox(height: 20.h),
                        Graphs(
                          week1: week1,
                          week2: week2,
                          week3: week3,
                          week4: week4,
                        ),
                        SizedBox(height: 20.h),
                        CustomTable(
                          week1: week1,
                          week2: week2,
                          week3: week3,
                          week4: week4,
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
