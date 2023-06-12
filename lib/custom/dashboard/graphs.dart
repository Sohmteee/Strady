import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mrx_charts/mrx_charts.dart';
import 'package:strady/data/variables.dart';
import 'package:strady/static/colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../home/circle_tab_indicator.dart';

class Graphs extends StatelessWidget {
  const Graphs({
    super.key,
    required this.week1,
    required this.week2,
    required this.week3,
    required this.week4,
  });

  final List<int> week1, week2, week3,  week4;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                            if (week1[0].toDouble() != 0)
                              ChartGroupBarDataItem(
                                color: Colors.green,
                                value: week1[0].toDouble(),
                                x: 1,
                              ),
                            if (week1[1].toDouble() != 0)
                              ChartGroupBarDataItem(
                                color: Colors.red,
                                value: week1[1].toDouble(),
                                x: 1,
                              ),
                            if (week1[2].toDouble() != 0)
                              ChartGroupBarDataItem(
                                color: grey400,
                                value: week1[2].toDouble(),
                                x: 1,
                              ),
                          ],
                          [
                            if (week2[0].toDouble() != 0)
                              ChartGroupBarDataItem(
                                color: Colors.green,
                                value: week2[0].toDouble(),
                                x: 2,
                              ),
                            if (week2[1].toDouble() != 0)
                              ChartGroupBarDataItem(
                                color: Colors.red,
                                value: week2[1].toDouble(),
                                x: 2,
                              ),
                            if (week2[2].toDouble() != 0)
                              ChartGroupBarDataItem(
                                color: grey400,
                                value: week2[2].toDouble(),
                                x: 2,
                              ),
                          ],
                          [
                            if (week3[0].toDouble() != 0)
                              ChartGroupBarDataItem(
                                color: Colors.green,
                                value: week3[0].toDouble(),
                                x: 3,
                              ),
                            if (week3[1].toDouble() != 0)
                              ChartGroupBarDataItem(
                                color: Colors.red,
                                value: week3[1].toDouble(),
                                x: 3,
                              ),
                            if (week3[2].toDouble() != 0)
                              ChartGroupBarDataItem(
                                color: grey400,
                                value: week3[2].toDouble(),
                                x: 4,
                              ),
                          ],
                          [
                            if (week4[0].toDouble() != 0)
                              ChartGroupBarDataItem(
                                color: Colors.green,
                                value: week4[0].toDouble(),
                                x: 4,
                              ),
                            if (week4[1].toDouble() != 0)
                              ChartGroupBarDataItem(
                                color: Colors.red,
                                value: week4[1].toDouble(),
                                x: 4,
                              ),
                            if (week4[2].toDouble() != 0)
                              ChartGroupBarDataItem(
                                color: grey400,
                                value: week4[2].toDouble(),
                                x: 4,
                              ),
                          ]
                        ],
                        settings: ChartGroupBarSettings(
                          thickness: 5,
                          radius:
                              BorderRadius.vertical(top: Radius.circular(10.r)),
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
}
