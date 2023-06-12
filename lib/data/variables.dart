import 'package:flutter/material.dart';

bool isClicked = false;
DateTime today = DateTime.now();
TextEditingController controller = TextEditingController();
late TabController tabController;
late TabController graphController;
FocusNode focusNode = FocusNode();
bool isPanelOpen = false;
  bool startAnimation = false;

double goodDays = 0, badDays = 0, neutralDays = 0;
double totalDays = goodDays + badDays + neutralDays;

List<MapEntry<String, double>> entries = [];

enum OrientationOption {
  splitView,
  listView,
}

OrientationOption selectedOrientation = OrientationOption.listView;

List<DateTime>? events = [
  DateTime.now(),
];

Map<int, List<Map<int, Map<int, String>>>> yearData = {
  2023: [
    {
      1: {
        1: 'good',
        2: 'neutral',
        3: 'bad',
        4: 'good',
        5: 'neutral',
        6: 'good',
        7: 'neutral',
        // ... days of the month
      },
      2: {
        1: 'neutral',
        2: 'bad',
        3: 'good',
        4: 'neutral',
        5: 'good',
        6: 'neutral',
        7: 'bad',
        // ... days of the month
      },
      3: {
        // ... days of the month
      },
      4: {
        // ... days of the month
      },
      5: {
        // ... days of the month
      },
      6: {
        1: 'good',
        2: 'bad',
        3: 'neutral',
        4: 'good',
        5: 'neutral',
        6: 'good',
        7: 'neutral',
        // ... days of the month
      },
    },
  ],
};

Map<String, Map<String, dynamic>> dayNotes = {
  "29-5-2023": {
    "images": <String>[],
    "note": "I started this project today even though a gay called Zendor refused to acknoledge that I am better than him."
        "\nBut because I have a good heart, and I am indeed superior, I decided to go on with it.\n\n"
        "I started this project today even though a gay called Zendor refused to acknoledge that I am better than him."
        "\nBut because I have a good heart, and I am indeed superior, I decided to go on with it.\n\n"
        "I started this project today even though a gay called Zendor refused to acknoledge that I am better than him."
        "\nBut because I have a good heart, and I am indeed superior, I decided to go on with it.\n\n"
        "I started this project today even though a gay called Zendor refused to acknoledge that I am better than him."
        "\nBut because I have a good heart, and I am indeed superior, I decided to go on with it.\n\n"
        "I started this project today even though a gay called Zendor refused to acknoledge that I am better than him."
        "\nBut because I have a good heart, and I am indeed superior, I decided to go on with it.\n\n"
        "I started this project today even though a gay called Zendor refused to acknoledge that I am better than him."
        "\nBut because I have a good heart, and I am indeed superior, I decided to go on with it.\n\n"
        "I started this project today even though a gay called Zendor refused to acknoledge that I am better than him."
        "\nBut because I have a good heart, and I am indeed superior, I decided to go on with it.\n\n"
        "I started this project today even though a gay called Zendor refused to acknoledge that I am better than him."
        "\nBut because I have a good heart, and I am indeed superior, I decided to go on with it.\n\n"
        "I started this project today even though a gay called Zendor refused to acknoledge that I am better than him."
        "\nBut because I have a good heart, and I am indeed superior, I decided to go on with it.\n\n"
        "I started this project today even though a gay called Zendor refused to acknoledge that I am better than him."
        "\nBut because I have a good heart, and I am indeed superior, I decided to go on with it.\n\n"
        "I started this project today even though a gay called Zendor refused to acknoledge that I am better than him."
        "\nBut because I have a good heart, and I am indeed superior, I decided to go on with it.\n\n"
        "I started this project today even though a gay called Zendor refused to acknoledge that I am better than him."
        "\nBut because I have a good heart, and I am indeed superior, I decided to go on with it.\n\n"
        "I started this project today even though a gay called Zendor refused to acknoledge that I am better than him."
        "\nBut because I have a good heart, and I am indeed superior, I decided to go on with it.\n\n"
        "I started this project today even though a gay called Zendor refused to acknoledge that I am better than him."
        "\nBut because I have a good heart, and I am indeed superior, I decided to go on with it.\n\n"
        "I started this project today even though a gay called Zendor refused to acknoledge that I am better than him."
        "\nBut because I have a good heart, and I am indeed superior, I decided to go on with it.\n\n"
        "I started this project today even though a gay called Zendor refused to acknoledge that I am better than him."
        "\nBut because I have a good heart, and I am indeed superior, I decided to go on with it.\n\n",
  },
};
