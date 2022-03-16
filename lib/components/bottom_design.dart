import 'package:flutter/material.dart';

class BottomDesign extends StatelessWidget {
  final Widget widget;
  // ignore: use_key_in_widget_constructors
  const BottomDesign({required this.widget});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(150),
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10, right: 4.0),
          child: widget,
        ),
      ),
    );
  }
}
