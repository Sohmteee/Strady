import 'package:flutter/material.dart';

bool isClicked = false;
DateTime today = DateTime.now();
TextEditingController controller = TextEditingController();
late TabController tabController;
FocusNode focusNode = FocusNode();
bool isPanelOpen = false;

double goodDays = 0, badDays = 0, neutralDays = 0;
double totalDays = goodDays + badDays + neutralDays;

enum OrientationOption {
  splitView,
  listView,
}

OrientationOption selectedOrientation = OrientationOption.listView;

List<DateTime>? events = [
  DateTime.now(),
];

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
