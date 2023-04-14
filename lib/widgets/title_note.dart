import 'package:flutter/material.dart';

class TitleNotesWidget extends StatefulWidget {
  final String label;

  const TitleNotesWidget({super.key, required this.label});

  @override
  TitleNotesWidgetState createState() => TitleNotesWidgetState();
}

class TitleNotesWidgetState extends State<TitleNotesWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 16.0, bottom: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          widget.label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
