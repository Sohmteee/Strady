import 'package:flutter/material.dart';
import 'package:strady/static/colors.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          backgroundColor: grey800,
          body: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
