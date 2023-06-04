import 'package:flutter/material.dart';

class AppProgressIndicator extends StatelessWidget {
  AppProgressIndicator({Key? key, required this.color, required this.text})
      : super(key: key);
  final Color? color;
  String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        children: [
          CircularProgressIndicator(
            color: color,
          ),
          Text(text)
        ],
      ),
    );
  }
}
