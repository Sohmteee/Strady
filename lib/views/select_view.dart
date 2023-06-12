import 'package:flutter/material.dart';
import 'package:strady/data/variables.dart';
import 'package:strady/views/split.dart';

import 'list.dart';

class SelectView extends StatefulWidget {
  const SelectView({Key? key, required this.selectedOrientation})
      : super(key: key);

  final OrientationOption selectedOrientation;

  @override
  State<SelectView> createState() => _SelectViewState();
}

class _SelectViewState extends State<SelectView> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    graphController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    graphController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.selectedOrientation == OrientationOption.listView
        ? const CustomListView()
        : widget.selectedOrientation == OrientationOption.splitView
            ? const SplitView()
            : const SizedBox();
  }
}
