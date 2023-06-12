import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strady/data/functions.dart';
import 'package:strady/data/variables.dart';
import 'package:strady/static/colors.dart';

class NoteArea extends StatefulWidget {
  const NoteArea({super.key});

  @override
  State<NoteArea> createState() => _NoteAreaState();
}

class _NoteAreaState extends State<NoteArea> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: dayNotes.containsKey(dateToString(today)) &&
              dayNotes[dateToString(today)]?["note"].trim() != ""
          ? SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  dayNotes[dateToString(today)]!["note"],
                  maxLines: null,
                  style: TextStyle(
                    color: grey300,
                    fontSize: 18.sp,
                  ),
                ),
              ),
            )
          : TextField(
              focusNode: focusNode,
              controller: controller,
              keyboardType: TextInputType.multiline,
              textCapitalization: TextCapitalization.sentences,
              maxLines: null,
              style: TextStyle(
                color: grey300,
                fontSize: 18.sp,
              ),
              onTap: () {
                setState(() {
                  focusNode.requestFocus();
                });
              },
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: "Enter note here...",
                hintStyle: TextStyle(
                  color: grey500,
                  fontSize: 18.sp,
                ),
                border: InputBorder.none,
              ),
            ),
    );
  }
}
