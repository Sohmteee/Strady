import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mrx_charts/mrx_charts.dart';
import 'package:strady/data/functions.dart';
import 'package:strady/data/variables.dart';
import 'package:strady/static/colors.dart';

class PieChart extends StatelessWidget {
  const PieChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                          if (goodDays != 0)
                            ChartGroupPieDataItem(
                              amount: goodDays,
                              color: Colors.green,
                              label: "Good Days",
                            ),
                          if (badDays != 0)
                            ChartGroupPieDataItem(
                              amount: badDays,
                              color: Colors.red,
                              label: "Bad Days",
                            ),
                          if (neutralDays != 0)
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
                            shape: BoxShape.circle,
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
}
