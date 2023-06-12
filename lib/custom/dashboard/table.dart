import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strady/data/variables.dart';
import 'package:strady/static/colors.dart';

class CustomTable extends StatelessWidget {
  const CustomTable({
    super.key,
    required this.week1,
    required this.week2,
    required this.week3,
    required this.week4,
  });

  final List<int> week1, week2, week3, week4;

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
}
