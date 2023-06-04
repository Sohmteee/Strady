import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

bool isClicked = false;
DateTime today = DateTime.now();
TextEditingController controller = TextEditingController();
PanelController panelController = PanelController();
FocusNode focusNode = FocusNode();
bool isPanelOpen = false;

enum OrientationOption {
  splitView,
  gridView,
  listView,
}

OrientationOption selectedOrientation = OrientationOption.listView;

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
